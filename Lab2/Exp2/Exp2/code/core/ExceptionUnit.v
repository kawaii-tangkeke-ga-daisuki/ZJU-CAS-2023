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

    reg [2:0] state = 3'd0;
    
    
    reg [1:0] thisType = 2'd0;
    wire [1:0] exp_type;
    
    localparam MSTATUS = 12'h300;
    localparam MTVEC   = 12'h305;
    localparam MEPC    = 12'h341;
    localparam MCAUSE  = 12'h342;
    localparam MTVAL   = 12'h343;
    localparam MIE     = 12'h304;
    
    localparam BAD_INST = 2'd0;
    localparam ECALL = 2'd1;
    localparam INTERRUPT = 2'd2;
    localparam MRET = 2'd3;
    assign exp_type = {2{illegal_inst | l_access_fault | s_access_fault}} & BAD_INST |
                        {2{ecall_m}} & ECALL |
                        {2{interrupt & mstatus[3]}} & interrupt |
                        {2{mret}} & MRET;

    wire trap_init;
    assign trap_init = illegal_inst | l_access_fault | s_access_fault |
                        ecall_m | interrupt & mstatus[3] | mret | (state != 3'd0);


    reg[31:0] prev_epc_cur;
    reg[31:0] prev_epc_next;
    reg [31:0] EPC;
    always @(posedge trap_init or posedge clk or posedge rst) begin
        if (rst) begin
            state <= 3'd0;
        end
        else begin 
            case (state)
                3'b000: begin
                    if(trap_init) begin
                        if(exp_type != INTERRUPT) begin
                            state = 3'b001;
                        end else begin
                            state = 3'b111;
                            prev_epc_cur <= epc_cur;
                            prev_epc_next <= epc_next; 
                        end
                        thisType <= exp_type;
                        EPC <= epc_cur;
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


    reg [31:0] mcause_w = 0;
    always @(negedge clk) begin
        if (rst) begin
            csr_w <= 0;
        end else begin
            case(state)
                3'b000: begin
                    csr_w     <= csr_rw_in;
                    csr_raddr <= csr_rw_addr_in;
                    csr_waddr <= csr_rw_addr_in;
                    csr_wsc   <= csr_wsc_mode_in;
                    csr_wdata <= csr_w_imm_mux ? {{27{0}},csr_w_data_imm} : csr_w_data_reg;
                end
                3'b001: begin
                    csr_w <= thisType != 2'b11;
                    csr_raddr <= (thisType == MRET) ? MEPC : MTVEC;
                    csr_waddr <= MEPC;
                    csr_wdata <= (thisType == INTERRUPT) ? prev_epc_next : epc_cur;
                    csr_wsc   <= 2'b01;
       
                    mcause_w <= illegal_inst ? 32'h2 : (l_access_fault ? 32'h5 : (s_access_fault ? 32'h7 : (ecall_m ? 32'hb : 32'h2)));                          
                end 
               3'b010: begin 
                    csr_w <= thisType != 2'b11;
                    csr_raddr <= MEPC;
                    csr_waddr <= MCAUSE;
                    csr_wdata <= mcause_w;
                    csr_wsc   <= 2'b01;
                end
                3'b011: begin 
                    csr_w     <= 1'b1;
                    csr_raddr <= MEPC;
                    csr_waddr <= MTVAL;
                    csr_wdata <= EPC;
                    csr_wsc <= 2'b01;
                end 
                3'b100: begin 
                    csr_w     <= 1'b1;
                    csr_raddr <= MEPC;
                    csr_waddr <= MSTATUS;
                    csr_wdata <= (thisType == MRET) ? {mstatus[31:8], 1'b0, mstatus[6:4], mstatus[7], mstatus[2:0]} : {mstatus[31:8], mstatus[3], mstatus[6:4], 1'b0, mstatus[2:0]};
                    csr_wsc <= 2'b01;
                end
             endcase
        end
    end

    CSRRegs csr(.clk(clk),.rst(rst),.csr_w(csr_w),.raddr(csr_raddr),.waddr(csr_waddr),
        .wdata(csr_wdata),.rdata(csr_r_data_out),.mstatus(mstatus),.csr_wsc_mode(csr_wsc));
        
    wire flush = (state == 3'b001) | (state == 3'b111);
    assign reg_FD_flush = flush;
    assign reg_DE_flush = flush;
    assign reg_EM_flush = flush;
    assign reg_MW_flush = flush;
    assign RegWrite_cancel = flush;
    
    assign PC_redirect = csr_r_data_out;    
    assign redirect_mux = flush;

endmodule