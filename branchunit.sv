module branchunit (
    input logic [31:0] rs1,
    input logic [31:0] rs2,
    input logic [4:0] BrOp,
    output logic NextPcSrc
);

  always @* begin
    if (BrOp[4] == 1) NextPcSrc <= 1;
    else if (BrOp[4] == 0 && BrOp[3] == 0) NextPcSrc <= 0;
    else if (BrOp[4] == 0 && BrOp[3] == 1) begin
      if (BrOp[2:0] == 3'b000) NextPcSrc <= rs1 == rs2;
      else if (BrOp[2:0] == 3'b001) NextPcSrc <= rs1 != rs2;
      else if (BrOp[2:0] == 3'b100) NextPcSrc <= signed'(rs1) < signed'(rs2);
      else if (BrOp[2:0] == 3'b101) NextPcSrc <= signed'(rs1) >= signed'(rs2);
      else if (BrOp[2:0] == 3'b110) NextPcSrc <= rs1 < rs2;
      else if (BrOp[2:0] == 3'b111) NextPcSrc <= rs1 >= rs2;
    end
  end

endmodule
