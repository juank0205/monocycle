module hazardunit (
    input logic [4:0] rs1_de,
    input logic [4:0] rs2_de,
    input logic [4:0] rd_ex,
    input logic DMRd_ex,
    output logic eden_hazard
);

  always_comb begin
    if ((rd_ex == rs1_de || rd_ex == rs2_de) && DMRd_ex) eden_hazard = 1;
    else eden_hazard = 0;

    if (rs1_de === 5'bXXXXX || rs2_de === 5'bXXXXX || rd_ex === 5'bXXXXX || DMRd_ex === 1'bX)
      eden_hazard = 0;
  end

endmodule
