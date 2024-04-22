module controlunit (
    input logic [6:0] OpCode,
    input logic [2:0] Funct3,
    input logic [6:0] Funct7,
    output logic RUWr,
    output logic [3:0] ALUOp,
    output logic [2:0] ImmSrc,
    output logic ALUASrc,
    output logic ALUBSrc,
    output logic DMWr,
    output logic [2:0] DMCtrl,
    output logic [4:0] BrOp,
    output logic [1:0] RUDataWrSrc
);
  assign RUWr = OpCode[5:2] != 4'b1000;

  always @* begin
    if (OpCode == 7'b0110011 || OpCode == 7'b0010011)
      ALUOp <= {Funct7[5], Funct3[2], Funct3[1], Funct3[0]};
    else if ((OpCode == 7'b0110111) || (OpCode == 7'b0010111)) ALUOp <= 4'b0111;
    else ALUOp <= 4'b0000;
  end

  assign ImmSrc = {
    (OpCode[6] * (~OpCode[2])), ((~OpCode[6]) * OpCode[2]), (OpCode[5] * (~OpCode[2]))
  };

  assign ALUASrc = OpCode[6];
  assign ALUBSrc = OpCode != 7'b0110011;
  assign DMWr = OpCode == 7'b0100011;
  assign DMCtrl = Funct3;
  assign BrOp = {~OpCode[4] * OpCode[2], OpCode[6], Funct3[2], Funct3[1], Funct3[0]};
  assign RUDataWrSrc = {OpCode[6], ((~OpCode[6]) * (~OpCode[4]))};
endmodule
