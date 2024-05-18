module fetchregisters (
    input logic [31:0] pc_input,
    input logic clk,
    output logic [31:0] pc_output
);

  always_ff @(posedge clk) begin
    pc_output <= pc_input;
  end
endmodule
