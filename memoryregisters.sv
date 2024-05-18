module memoryregisters (
    input logic clk,

    input logic [31:0] pcInc_input,
    input logic [31:0] ALURes_input,
    input logic [4:0] rd_input,
    input logic [31:0] RUrs2_input,

    //CONTROL
    input logic DMWr_input,
    input logic RUWr_input,
    input logic [1:0] RUDataWrSrc_input,
    input logic [2:0] DMCtrl_input,


    output logic [31:0] pcInc_output,
    output logic [31:0] ALURes_output,
    output logic [4:0] rd_output,
    output logic [31:0] RUrs2_output,

    //CONTROL
    output logic DMWr_output,
    output logic RUWr_output,
    output logic [1:0] RUDataWrSrc_output,
    output logic [2:0] DMCtrl_output
);

  always @(posedge clk) begin
    pcInc_output <= pcInc_input;
    ALURes_output <= ALURes_input;
    rd_output <= rd_input;
    DMWr_output <= DMWr_input;
    RUWr_output <= RUWr_input;
    RUDataWrSrc_output <= RUDataWrSrc_input;
    DMCtrl_output <= DMCtrl_input;
    RUrs2_output <= RUrs2_input;
  end

endmodule
