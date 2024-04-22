module pc (
   input logic clk,
   input logic pc_input [31:0],
   output logic pc_output[31:0]
);

    always_ff @(posedge clk) begin
        pc_output <= pc_input;
    end
endmodule
