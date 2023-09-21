`timescale 1ps/1ps

module HazardDetectionUnit(
    input clk,
    input Branch_ID, rs1use_ID, rs2use_ID,
    input[1:0] hazard_optype_ID,
    input[4:0] rd_EXE, rd_MEM, rs1_ID, rs2_ID, rs2_EXE,

    output PC_EN_IF, reg_FD_EN, reg_FD_stall, reg_FD_flush,
        reg_DE_EN, reg_DE_flush, reg_EM_EN, reg_EM_flush, reg_MW_EN,
    output forward_ctrl_ls,
    output[1:0] forward_ctrl_A, forward_ctrl_B
);
    always @(posedge clk) begin
        if (((rs1use_ID) & (rs1_ID != 0) & (rd_MEM == rs1_ID)) | ((rs2use_ID) & (rs2_ID != 0) & (rd_MEM == rs2_ID))) begin
            // mem haz
            PC_EN_IF = 1'b0;
            reg_FD_flush = 1'b1;
            reg_DE_EN <= 0;
            reg_DE_flush <= 1'b1;
            reg_EM_EN <= 0;
            reg_EM_flush <= 1'b1;
            reg_MW_EN <= 0;
            reg_FD_stall <= 1'b1;

        end else if(rs2use_ID & ((rs2_ID == rd_EXE)|(rs2_ID == rd_MEM))) begin
            
        end else if(Branch_ID & ())
    end        //according to the diagram, design the Hazard Detection Unit

    if  begin
        // MEM hazard
        reg_FD_stall = 1'b1;
    end
    if (((rs1use_ID) & (rs1_ID != 0) & (rd_EXE == rs1_ID)) | ((rs2use_ID) & (rs2_ID != 0) & (rd_EXE == rs2_ID))) begin
        // EX hazard
        
    end
    if Branch_ID begin
        // ctrl hazard

    end


endmodule