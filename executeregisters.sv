
module executeregisters (
    input logic [31:0] pc_input,
    input logic [31:0] pcInc_input,
    input logic [31:0] RUrs1_input,
    input logic [31:0] RUrs2_input,
    input logic [31:0] ImmExt_input,
    input logic [ 4:0] rd_input,
    input logic [ 4:0] rs1_input,
    input logic [ 4:0] rs2_input,

    input logic RUWr_input,
    input logic DMWr_input,
    input logic DMRd_input,
    input logic ALUASrc_input,
    input logic ALUBSrc_input,
    input logic [1:0] RUDataWrSrc_input,
    input logic [2:0] DMCtrl_input,
    input logic [3:0] AluOp_input,
    input logic [4:0] BrOp_input,

    input logic clk,
    input logic clear_eden_hazard,
    input logic clear_branchUnit,

    output logic [31:0] pc_output,
    output logic [31:0] pcInc_output,
    output logic [31:0] RUrs1_output,
    output logic [31:0] RUrs2_output,
    output logic [31:0] ImmExt_output,
    output logic [ 4:0] rd_output,
    output logic [ 4:0] rs1_output,
    output logic [ 4:0] rs2_output,

    output logic RUWr_output,
    output logic DMWr_output,
    output logic DMRd_output,
    output logic ALUASrc_output,
    output logic ALUBSrc_output,
    output logic [1:0] RUDataWrSrc_output,
    output logic [2:0] DMCtrl_output,
    output logic [3:0] AluOp_output,
    output logic [4:0] BrOp_output
);

  always_ff @(posedge clk) begin
    pc_output <= pc_input;
    pcInc_output <= pcInc_input;
    RUrs1_output <= RUrs1_input;
    RUrs2_output <= RUrs2_input;
    ImmExt_output <= ImmExt_input;
    rd_output <= rd_input;
    rs1_output <= rs1_input;
    rs2_output <= rs2_input;

    RUWr_output <= RUWr_input;
    DMWr_output <= DMWr_input;
    DMRd_output <= DMRd_input;
    ALUASrc_output <= ALUASrc_input;
    ALUBSrc_output <= ALUBSrc_input;
    RUDataWrSrc_output <= RUDataWrSrc_input;
    DMCtrl_output <= DMCtrl_input;
    AluOp_output <= AluOp_input;
    BrOp_output <= BrOp_input;

    if (clear_eden_hazard || clear_branchUnit) begin
      pc_output <= 0;
      pcInc_output <= 0;
      RUrs1_output <= 0;
      RUrs2_output <= 0;
      ImmExt_output <= 0;
      rd_output <= 0;
      rs1_output <= 0;
      rs2_output <= 0;

      RUWr_output <= 1;
      DMWr_output <= 0;
      DMRd_output <= 0;
      ALUASrc_output <= 0;
      ALUBSrc_output <= 0;
      RUDataWrSrc_output <= 0;
      DMCtrl_output <= 0;
      AluOp_output <= 0;
      BrOp_output <= 0;
    end
  end
endmodule
