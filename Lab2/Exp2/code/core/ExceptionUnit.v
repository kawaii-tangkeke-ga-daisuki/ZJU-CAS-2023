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

    reg [11:0] csr_raddr, csr_waddr;
    reg [31:0] csr_wdata;
    reg csr_w;
    reg [1:0] csr_wsc;

    wire[31:0] mstatus;

    reg [2:0] state = 3'd0; 
    
    reg[31:0] EPC; 
    
    reg [1:0] thisType = 2'd0;
    wire [1:0] exp_t;
    
    localparam MSTATUS = 12'h300;
    localparam MTVEC   = 12'h305;
    localparam MEPC    = 12'h341;
    localparam MCAUSE  = 12'h342;
    localparam MTVAL   = 12'h343;
    localparam MIE     = 12'h304;
    
    localparam BADINST = 2'd0;
    localparam ECALL = 2'd1;
    localparam INTERRUPT = 2'd2;
    localparam MRET = 2'd3;
    assign exp_t =  (BADINST & {2{illegal_inst | l_access_fault | s_access_fault}}) |
                    (ECALL & {2{ecall_m}}) | 
                    (INTERRUPT & {2{interrupt & mstatus[3]}}) |
                    (MRET & {2{mret}});

    wire exp_init;
    assign exp_init = illegal_inst | l_access_fault | s_access_fault |
                        ecall_m | mret | (interrupt & mstatus[3]);

    wire flush = (state == 3'd1) || ((state == 3'd2) && (thisType != MRET)) || (state == 3'd7);
    assign reg_FD_flush = flush;
    assign reg_DE_flush = flush;
    assign reg_EM_flush = flush;
    assign reg_MW_flush = flush;
    assign RegWrite_cancel = (state == 3'd1) & !mret;
    
    assign PC_redirect = csr_r_data_out;    
    assign redirect_mux = ((state == 3'd2) & (thisType != MRET)) | (mret & (state == 3'd1));

    reg [31:0] prev_epc_next;
    reg [31:0] cause;
    always @(posedge exp_init or posedge clk or posedge rst) begin
        if (rst) begin
            state <= 3'd0;
        end
        else if ((state == 3'd0) && exp_init) begin
            if (exp_t == INTERRUPT)
                state <= 3'd7;
            else
                state <= 3'd1;
            thisType <= exp_t;
            cause <= ecall_m ? 32'hb : (l_access_fault ? 32'h5 : (s_access_fault ? 32'h7 : (illegal_inst ? 32'h2 : 32'hb)));
            EPC <= epc_cur;
            prev_epc_next <= epc_next - 3'd4;
        end
        else if(state == 3'd7) begin
            state <= 3'd1;
        end
        else if (state == 3'd1) begin 
            state <= 3'd2;
        end
        else if (state == 3'd2) begin 
            state <= 3'd3;
        end 
        else if (state == 3'd3) begin 
            state <= 3'd4;
        end
        else if (state == 3'd4) begin 
            state <= 3'd0;
        end
    end
    
    initial begin
        csr_raddr = 0;
    end
    
    always @* begin
        if (csr_rw_in || state) begin   
            case(state)  
                3'b000: begin
                    csr_raddr <= csr_rw_addr_in;
                    csr_waddr <= csr_rw_addr_in;
                    csr_wdata <= (csr_w_imm_mux ? {{27{0}},csr_w_data_imm} : csr_w_data_reg);
                    csr_w <= csr_rw_in;
                    csr_wsc <= csr_wsc_mode_in;
                end
                3'b001: begin
                    if (thisType == MRET)
                        csr_raddr <= MEPC;
                    else begin
                        csr_waddr <= MSTATUS;
                        csr_wdata <= {mstatus[31:8], mstatus[3], mstatus[6:4], 1'b0, mstatus[2:0]};
                        csr_w <= 1'b1;
                        csr_wsc <= 2'b01;
                    end
                end
                3'b010: begin 
                    if (thisType != MRET) begin
                        csr_raddr <= MTVEC;
                        csr_waddr <= MEPC;
                        csr_wdata <= (thisType == INTERRUPT ? prev_epc_next : EPC);
                        csr_w <= 1'b1;
                        csr_wsc <= 2'b01;
                    end else begin
                        csr_waddr <= MSTATUS;
                        csr_wdata <= {mstatus[31:8], 1'b1, mstatus[6:4], mstatus[7], mstatus[2:0]};
                        csr_w <= 1'b1;
                        csr_wsc <= 2'b01;
                    end
                end
                3'b011: begin
                    if (thisType != MRET) begin 
                        csr_waddr <= MCAUSE;
                        csr_wdata <= cause;
                        csr_w <= 1'b1;
                        csr_wsc <= 2'b01;
                    end
                end
                3'b100: begin
                    if (thisType != MRET) begin
                        csr_waddr <= MTVAL;
                        csr_wdata <= EPC;
                        csr_w <= 1'b1;
                        csr_wsc <= 2'b01;
                    end
                end
                default : begin end
            endcase
        end 
    end

    CSRRegs csr(.clk(clk),.rst(rst),.csr_w(csr_w),.raddr(csr_raddr),.waddr(csr_waddr),
        .wdata(csr_wdata),.rdata(csr_r_data_out),.mstatus(mstatus),.csr_wsc_mode(csr_wsc));

endmodule