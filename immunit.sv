module immunit (
    input  logic [24:0] ImmInput,
    input  logic [ 2:0] ImmSrc,
    output logic [31:0] ImmExt
);

  always @(ImmInput) begin
    case (ImmSrc)
      3'b000:  ImmExt = {{20{ImmInput[24]}}, ImmInput[24:13]};
      3'b001:  ImmExt = {{20{ImmInput[24]}}, ImmInput[24:18], ImmInput[4:0]};
      3'b101:  ImmExt = {{19{ImmInput[24]}}, ImmInput[0], ImmInput[23:18], ImmInput[4:1], 1'b0};
      3'b010:  ImmExt = {ImmInput[24:5], {12{1'b0}}};
      3'b110:  ImmExt = {{12{ImmInput[24]}}, ImmInput[12:5], ImmInput[13], ImmInput[23:14], 1'b0};
      default: ImmExt = 0;
    endcase
  end
endmodule
