module alu_tb;
  reg [31:0] A;
  reg [31:0] B;
  reg [31:0] S;
  reg [ 3:0] ALUOp;
  alu uut (
      .A(A),
      .B(B),
      .S(S),
      .ALUOp(ALUOp)
  );
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, alu_tb);
    A = 1;
    B = 1;
    ALUOp = 4'b0000;
    #10;

    A = 1;
    B = 1;
    ALUOp = 4'b1000;
    #10;

    A = -1;
    B = 1;
    ALUOp = 4'b0010;
    #10;

    A = -1;
    B = 1;
    ALUOp = 4'b0011;
    #10;

    A = -1;
    B = 1;
    ALUOp = 4'b0100;
    #10;

    A = -1;
    B = 1;
    ALUOp = 4'b0101;
    #10;

    A = -1;
    B = 1;
    ALUOp = 4'b0110;
    #10;

    A = -1;
    B = 1;
    ALUOp = 4'b0111;
    #10;

    $finish;
  end
endmodule
