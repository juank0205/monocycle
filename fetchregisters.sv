module fetchregisters (
    input logic [31:0] pc_input,
    input logic clk,
    input logic enable,
    output logic [31:0] pc_output
);

  always_ff @(posedge clk) begin
    if (enable == 0) pc_output <= pc_input;
  end
endmodule
