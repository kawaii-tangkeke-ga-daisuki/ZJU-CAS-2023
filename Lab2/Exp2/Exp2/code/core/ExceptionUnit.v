`timescale 1ns / 1ps

module ExceptionUnit(
    input clk, rst,
    input csr_rw_in,
    input[1:0] csr_wsc_mode_in,
    input csr_w_imm_mux,
    input[11:0] csr_rw_addr_in,
    input[31:0] csr_w_data_reg,
    input[4:0] csr_w_data_imm,
    output[31:0] csr_r_data_out,

    input interrupt,
    input illegal_inst,
    input l_access_fault,
    input s_access_fault,
    input ecall_m,

    input mret,

    input[31:0] epc_cur,
    input[31:0] epc_next,
    output[31:0] PC_redirect,
    output redirect_mux,

    output reg_FD_flush, reg_DE_flush, reg_EM_flush, reg_MW_flush, 
    output RegWrite_cancel
);

    reg[11:0] csr_raddr, csr_waddr;
    reg[31:0] csr_wdata;
    reg csr_w;
    reg[1:0] csr_wsc;

    wire[31:0] mstatus;
    
    reg [2:0] state = 3'b000;

    localparam mepc_addr = 12'h341;
    localparam mcause_addr = 12'h342;
    localparam mstatus_addr = 12'h300;
    localparam mie_addr = 12'h304;
    localparam mip_addr = 12'h344;
    localparam mtval_addr = 12'h343;
    
    localparam BAD_INST = 2'b00;
    localparam ECALL = 2'b01;
    localparam INTERRUPT = 2'b10;
    localparam MRET = 2'b11;

    wire [1:0] exp_type;
    assign exp_type = {2{illegal_inst | l_access_fault | s_access_fault}} & BAD_INST |
                    {2{ecall_m}} & ECALL |
                    {2{interrupt | mstatus[3]}} & INTERRUPT |
                    {2{mret}} & MRET;

    wire init_state;
    assign init_state = illegal_inst | l_access_fault | s_access_fault | ecall_m | (interrupt & mstatus[3]) | mret | (state != 3'b000);

    wire flush;
    assign flush = (state == 3'b001) | (state == 3'b111);
    assign reg_FD_flush = flush;
    assign reg_DE_flush = flush;
    assign reg_EM_flush = flush;
    assign reg_MW_flush = flush;
    assign RegWrite_cancel = flush;
    
    assign PC_redirect = csr_r_data_out;
    assign redirect_mux = flush;
    
    always @(posedge init_state or posedge clk or posedge rst) begin
        if (rst) begin
            state <= 3'b000;
        end else begin
            case (state)
                3'b000: begin
                    if(init_state) begin
                        if(exp_type != INTERRUPT) begin
                            state = 3'b001;
                        end else begin
                            state = 3'b111;
                        end
                    end
                end
                3'b001: state = 3'b010;
                3'b010: state = 3'b011;
                3'b011: state = 3'b100;
                3'b100: state = 3'b000;
                3'b111: state = 3'b001;
                default: ;
            endcase
        end
    end

    wire [11:0] jumpDest;
    assign jumpDest = exp_type == MRET ? mepc_addr : mtval_addr;

    reg [31:0] cause = 0;

    always @(negedge clk) begin
        if (rst) begin
            csr_w <= 0;
        end else begin 
            case(state)
                3'b000: begin 
                    csr_w <= csr_rw_in;
                    csr_raddr <= csr_rw_addr_in;
                    csr_waddr <= csr_rw_addr_in;
                    csr_wsc <= csr_wsc_mode_in;
                    csr_wdata <= csr_w_imm_mux ? {{27{0}},csr_w_data_imm} : csr_w_data_reg;
                end
                3'b001: begin                       // save exp PC to mepc, PC set mtvec
                    csr_w <= exp_type != 2'b11; // not mret
                    csr_raddr <= jumpDest;
                    csr_waddr <= mepc_addr;
                    csr_wdata <= exp_type == INTERRUPT ? epc_next : epc_cur;
                    csr_wsc   <= 2'b01;

                    cause <=  ecall_m ? 32'hb : (l_access_fault ? 32'h5 : 
                                (s_access_fault ? 32'h7 : (illegal_inst ? 32'h2 : 32'hb)));
                end 
                3'b010: begin                       // set mcause
                    csr_w <= exp_type != 2'b11;
                    csr_waddr <= mcause_addr;
                    csr_wdata <= cause;
                    csr_wsc   <= 2'b01;
                end
                3'b011: begin                       // set mtval
                    csr_w <= 1'b1;
                    csr_waddr <= mtval_addr;
                    csr_wdata <= epc_cur;
                    csr_wsc <= 2'b01;
                end 
                3'b100: begin 
                    csr_w <= 1'b1;
                    csr_waddr <= mstatus_addr;
                    csr_wdata <= exp_type == MRET ? 
                                {mstatus[31:8], 1'b0, mstatus[6:4], mstatus[7], mstatus[2:0]}: 
                                {mstatus[31:8], mstatus[3], mstatus[6:4], 1'b0, mstatus[2:0]};
                end
                default: ;
            endcase
        end
    end

    CSRRegs csr(.clk(clk),.rst(rst),.csr_w(csr_w),.raddr(csr_raddr),.waddr(csr_waddr),
        .wdata(csr_wdata),.rdata(csr_r_data_out),.mstatus(mstatus),.csr_wsc_mode(csr_wsc));
    //According to the diagram, design the Exception Unit

endmodule