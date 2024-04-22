// Code your design here
module alu(
  input logic [31:0] A,
  input logic [31:0] B,
  input logic [3:0] ALUOp,
  output logic [31:0] S
);
  always @ (A, B, ALUOp)
  begin
    case (ALUOp)
      4'b0000: S = A + B;
      4'b1000: S = A - B;
      4'b0010: S = (signed'(A) < signed'(B));
      4'b0011: S = A < B;
      4'b0001: S = A << B;
      4'b0100: S = A ^ B;
      4'b0101: S = A >> B;
      4'b1101: S = A >>> B;
      4'b0110: S = A | B;
      4'b0111: S = A & B;
      default: S = 0;
    endcase
  end
endmodule
