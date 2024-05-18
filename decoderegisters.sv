module decoderegisters (
    input logic [31:0] instruction_input,
    input logic [31:0] pc_input,
    input logic [31:0] pcInc_input,
    input logic clk,

    output logic [31:0] instruction_output,
    output logic [31:0] pc_output,
    output logic [31:0] pcInc_output
);

  always_ff @(posedge clk) begin
    pc_output <= pc_input;
    pcInc_output <= pcInc_input;
    instruction_output <= instruction_input;
  end
endmodule
