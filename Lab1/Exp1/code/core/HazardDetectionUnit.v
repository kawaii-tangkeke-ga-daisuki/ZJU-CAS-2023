`timescale 1ps/1ps

module HazardDetectionUnit(
    input clk,
    input Branch_ID, rs1use_ID, rs2use_ID,
    input[1:0] hazard_optype_ID,
    input[4:0] rd_EXE, rd_MEM, rs1_ID, rs2_ID, rs2_EXE,

    output PC_EN_IF, reg_FD_EN, reg_FD_stall, reg_FD_flush,
        reg_DE_EN, reg_DE_flush, reg_EM_EN, reg_EM_flush, reg_MW_EN,
    output forward_ctrl_ls,
    output [1:0] forward_ctrl_A, forward_ctrl_B
);
    reg [1:0] hazard_optype_EXE, hazard_optype_MEM;
    always @(posedge clk) begin
        hazard_optype_MEM <= hazard_optype_EXE;
        hazard_optype_EXE <= {2{~reg_DE_flush}} & hazard_optype_ID;
    end

    wire forward_rs1_EXE = rs1use_ID & rs1_ID != 5'b0 & rs1_ID == rd_EXE & hazard_optype_EXE == 2'b01;
    wire forward_rs1_MEM = rs1use_ID & rs1_ID != 5'b0 & rs1_ID == rd_MEM & hazard_optype_MEM == 2'b01;
    wire forward_rs1_LD = rs1use_ID & rs1_ID != 5'b0 & rs1_ID == rd_MEM & hazard_optype_MEM == 2'b10;

    wire forward_rs2_EXE = rs2use_ID & rs2_ID != 5'b0 & rs2_ID == rd_EXE & hazard_optype_EXE == 2'b01;
    wire forward_rs2_MEM = rs2use_ID & rs2_ID != 5'b0 & rs2_ID == rd_MEM & hazard_optype_MEM == 2'b01;
    wire forward_rs2_LD = rs2use_ID & rs2_ID != 5'b0 & rs2_ID == rd_MEM & hazard_optype_MEM == 2'b10;

    wire stall = (rs1use_ID & rs1_ID != 5'b0 & rs1_ID == rd_EXE & hazard_optype_EXE == 2'b10 & hazard_optype_ID != 2'b11) |
                (rs2use_ID & rs2_ID != 5'b0 & rs2_ID == rd_EXE & hazard_optype_EXE == 2'b10 & hazard_optype_ID != 2'b11); 

    assign reg_FD_stall = stall;
    
    assign PC_EN_IF = ~stall;
    assign reg_FD_EN = 1'b1;
    assign reg_DE_EN = 1'b1;
    assign reg_EM_EN = 1'b1;
    assign reg_MW_EN = 1'b1;

    assign reg_DE_flush = stall; 
    assign reg_FD_flush = Branch_ID;
    assign reg_EM_flush = 1'b0;

    assign forward_ctrl_A = {2{forward_rs1_EXE}} & 2'b01 |
                            {2{forward_rs1_MEM}} & 2'b10 |
                            {2{forward_rs1_LD}} & 2'b11;
    assign forward_ctrl_B = {2{forward_rs2_EXE}} & 2'b01 |
                            {2{forward_rs2_MEM}} & 2'b10 |
                            {2{forward_rs2_LD}} & 2'b11;

    assign forward_ctrl_ls = (rs2_EXE == rd_MEM) & (hazard_optype_EXE == 2'b11) & (hazard_optype_MEM == 2'b10); //sd after ld
endmodule