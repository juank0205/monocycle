module forwardingunit (
    input logic [4:0] rs1_ex,
    input logic [4:0] rs2_ex,
    input logic [4:0] rd_me,
    input logic [4:0] rd_wb,
    input logic RUWr_me,
    input logic RUWr_wb,

    output logic [1:0] FUAsrc,
    output logic [1:0] FUBsrc
);

  always @* begin
    FUAsrc = 0;
    FUBsrc = 0;
    if (rd_me != 5'b00000 && RUWr_me) begin
      if (rd_me == rs1_ex) FUAsrc <= 2'b01;
      if (rd_me == rs2_ex) FUBsrc <= 2'b01;
    end
    if (rd_wb != 5'b00000 && RUWr_wb) begin
      if (rd_wb == rs1_ex) FUAsrc <= 2'b10;
      if (rd_wb == rs2_ex) FUBsrc <= 2'b10;
    end
    if ((rd_me != 5'b00000 && RUWr_me) && (rd_wb != 5'b00000 && RUWr_wb)) begin
      if (rd_me == rs1_ex) FUAsrc <= 2'b01;
      if (rd_me == rs2_ex) FUBsrc <= 2'b01;
    end
  end

endmodule
