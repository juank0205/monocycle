module decoderegisters (
    input logic [31:0] instruction_input,
    input logic [31:0] pc_input,
    input logic [31:0] pcInc_input,
    input logic clk,
    input logic enable,
    input logic clear,

    output logic [31:0] instruction_output,
    output logic [31:0] pc_output,
    output logic [31:0] pcInc_output
);

  always_ff @(posedge clk) begin
    if (!enable) begin
      pc_output <= pc_input;
      pcInc_output <= pcInc_input;
      instruction_output <= instruction_input;
    end
    if (clear) begin
      pc_output <= 0;
      pcInc_output <= 0;
      instruction_output <= 32'h00000013;
    end

  end
endmodule
