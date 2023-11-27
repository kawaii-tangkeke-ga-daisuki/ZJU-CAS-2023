`timescale 1ns / 1ps

module FU_jump(
	input clk, EN, JALR,
	input[2:0] cmp_ctrl,
	input[31:0] rs1_data, rs2_data, imm, PC,
	output[31:0] PC_jump, PC_wb,
	output cmp_res, finish
);

    reg state;
    assign finish = state == 1'b1;
	initial begin
        state = 0;
    end

	reg JALR_reg;
	reg[2:0] cmp_ctrl_reg;
	reg[31:0] rs1_data_reg, rs2_data_reg, imm_reg, PC_reg;
    
	always @(posedge clk) begin
	   if (EN & ~state) begin 
	       state <= 1'b1;
	       rs1_data_reg <= rs1_data;
	       rs2_data_reg <= rs2_data;
	       imm_reg <= imm;
	       PC_reg <= PC;
	       cmp_ctrl_reg <= cmp_ctrl;
	       JALR_reg <= JALR;
	   end else
	       state <= 1'b0;
	end
	
	cmp_32 cmp_ID(.a(rs1_data_reg),.b(rs2_data_reg),.ctrl(cmp_ctrl_reg),.c(cmp_res));
	
	assign PC_jump = JALR_reg ? (rs1_data_reg + imm_reg) : (PC_reg + imm_reg);
	assign PC_wb = PC_reg + 3'd4;            //to fill sth.in

endmodule