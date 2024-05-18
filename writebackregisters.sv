module writebackregisters (
    input logic clk,

    input logic [31:0] pcInc_input,
    input logic [31:0] ALURes_input,
    input logic [31:0] DMDataRd_input,
    input logic [4:0] rd_input,

    //CONTROL
    input logic RUWr_input,
    input logic [1:0] RUDataWrSrc_input,

    output logic [31:0] pcInc_output,
    output logic [31:0] ALURes_output,
    output logic [31:0] DMDataRd_output,
    output logic [4:0] rd_output,

    //CONTROL
    output logic RUWr_output,
    output logic [1:0] RUDataWrSrc_output
);

  always @(posedge clk) begin
    pcInc_output <= pcInc_input;
    ALURes_output <= ALURes_input;
    rd_output <= rd_input;
    DMDataRd_output <= DMDataRd_input;
    RUWr_output <= RUWr_input;
    RUDataWrSrc_output <= RUDataWrSrc_input;
  end

endmodule
