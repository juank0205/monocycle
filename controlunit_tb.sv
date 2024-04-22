module controlunit_tb;
  logic [6:0] OpCode;
  logic [2:0] Funct3;
  logic [6:0] Funct7;
  logic RUWr;
  logic [3:0] ALUOp;
  logic [2:0] ImmSrc;
  logic ALUASrc;
  logic ALUBSrc;
  logic DMWr;
  logic [2:0] DMCtrl;
  logic [4:0] BrOp;
  logic [1:0] RUDataWrSrc;

  controlunit uut (
      .OpCode(OpCode),
      .Funct3(Funct3),
      .Funct7(Funct7),
      .RUWr(RUWr),
      .ALUOp(ALUOp),
      .ImmSrc(ImmSrc),
      .ALUASrc(ALUASrc),
      .ALUBSrc(ALUBSrc),
      .DMWr(DMWr),
      .DMCtrl(DMCtrl),
      .BrOp(BrOp),
      .RUDataWrSrc(RUDataWrSrc)
  );

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, controlunit_tb);
    // Test case 1 SUB
    OpCode = 7'b0110011;
    Funct3 = 3'b000;
    Funct7 = 7'b0100000;
    #10;  // Wait for 10 time units
    // ADDI
    OpCode = 7'b0010011;
    Funct3 = 3'b000;
    Funct7 = 7'b0000000;
    #10;  // Wait for 10 time units
    //beq
    OpCode = 7'b1100011;
    Funct3 = 3'b000;
    Funct7 = 7'b0000000;
    #10;  // Wait for 10 time units

    //sw
    OpCode = 7'b0100011;
    Funct3 = 3'b010;
    Funct7 = 7'b0000000;
    #10;  // Wait for 10 time units
    //jalr
    OpCode = 7'b1100111;
    Funct3 = 3'b000;
    Funct7 = 7'b0000000;
    #10;  // Wait for 10 time units
    //jal
    OpCode = 7'b1101111;
    Funct3 = 3'b000;
    Funct7 = 7'b0100000;
    #10;
    //u
    OpCode = 7'b0110111;
    Funct3 = 3'b000;
    Funct7 = 7'b0000000;
    #10;
  end

endmodule
