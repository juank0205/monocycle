module mono (
    input logic clk
);
  logic [31:0] PcPlus4;  // PC ADDED 4
  logic [31:0] BuPp4Mux;  // BRANCH UNIT and PC ADDED 4 mux
  logic [31:0] inst;  // INSTRUCTION MEMORY OUTPUT
  logic [31:0] RUDataMux;  // DATA MEMORY, ALU and PC ADDED 4 mux
  logic [31:0] RU1;  // REGISTER UNIT OUTPUT 1
  logic [31:0] RU2;  // REGISTER UNIT OUTPUT 2
  logic [31:0] ALUAMux;  // RU1 and PC mux
  logic [31:0] ALUBMux;  // RU2 and IMM GEN mux
  logic [31:0] ALURes;  // ALU OUTPUT
  logic [31:0] DataRd;  // DATA MEMORY OUTPUT
  logic [31:0] ImmExt;  // IMMEDIATE EXTENDED
  logic NextPcSrc;  // BRANCH UNIT OUTPUT
  logic [31:0] FUAMux;  // FORWARDING UNIT MUX
  logic [31:0] FUBMux;  // FORWARDING UNIT MUX

  logic [1:0] FUAsrc;
  logic [1:0] FUBsrc;
  logic eden_hazard;

  logic RUWr;
  logic [3:0] ALUOp;
  logic [2:0] ImmSrc;
  logic ALUASrc;
  logic ALUBSrc;
  logic DMWr;
  logic DMRd;
  logic [2:0] DMCtrl;
  logic [4:0] BrOp;
  logic [1:0] RUDataWrSrc;

  //FETCH
  logic [31:0] pc_fe;

  //DECODE
  logic [31:0] inst_de;
  logic [31:0] pc_de;
  logic [31:0] pcInc_de;

  //EXECUTE
  logic [31:0] pc_ex;
  logic [31:0] pcInc_ex;
  logic [31:0] RUrs1_ex;
  logic [31:0] RUrs2_ex;
  logic [31:0] ImmExt_ex;
  logic [4:0] rd_ex;
  logic [4:0] rs1_ex;
  logic [4:0] rs2_ex;
  logic RUWr_ex;
  logic DMWr_ex;
  logic DMRd_ex;
  logic ALUASrc_ex;
  logic ALUBSrc_ex;
  logic [1:0] RUDataWrSrc_ex;
  logic [2:0] DMCtrl_ex;
  logic [3:0] ALUOp_ex;
  logic [4:0] BrOp_ex;

  //MEMORY
  logic [31:0] pcInc_me;
  logic [31:0] ALURes_me;
  logic [4:0] rd_me;
  logic [31:0] RUrs2_me;
  logic DMWr_me;
  logic RUWr_me;
  logic [1:0] RUDataWrSrc_me;
  logic [2:0] DMCtrl_me;

  //WRITEBACK
  logic [31:0] pcInc_wb;
  logic [31:0] ALURes_wb;
  logic [31:0] DMDataRd_wb;
  logic [4:0] rd_wb;
  logic RUWr_wb;
  logic [1:0] RUDataWrSrc_wb;


  fetchregisters fe (
      .pc_input(BuPp4Mux),
      .pc_output(pc_fe),
      .clk(clk),
      .enable(eden_hazard)
  );

  instmemory minstmemory (
      .address(pc_fe),
      .instruction(inst)
  );

  decoderegisters de (
      .instruction_input(inst),
      .pc_input(pc_fe),
      .pcInc_input(PcPlus4),
      .instruction_output(inst_de),
      .pc_output(pc_de),
      .pcInc_output(pcInc_de),
      .clk(clk),
      .enable(eden_hazard),
      .clear(NextPcSrc)
  );

  controlunit mcontrolunit (
      .OpCode(inst_de[6:0]),
      .Funct3(inst_de[14:12]),
      .Funct7(inst_de[31:25]),
      .RUWr(RUWr),
      .ALUOp(ALUOp),
      .ImmSrc(ImmSrc),
      .ALUASrc(ALUASrc),
      .ALUBSrc(ALUBSrc),
      .DMWr(DMWr),
      .DMRd(DMRd),
      .DMCtrl(DMCtrl),
      .BrOp(BrOp),
      .RUDataWrSrc(RUDataWrSrc)
  );

  hazardunit eden (
      .rs1_de(inst_de[19:15]),
      .rs2_de(inst_de[24:20]),
      .rd_ex(rd_ex),
      .DMRd_ex(DMRd_ex),
      .eden_hazard(eden_hazard)
  );

  registerunit mregisterunit (
      .clk(clk),
      .rs1(inst_de[19:15]),
      .rs2(inst_de[24:20]),
      .rd(rd_wb),
      .RuWr(RUWr_wb),
      .RuWrData(RUDataMux),
      .ru1(RU1),
      .ru2(RU2)
  );

  immunit mimmunit (
      .ImmInput(inst_de[31:7]),
      .ImmSrc  (ImmSrc),
      .ImmExt  (ImmExt)
  );

  executeregisters ex (
      .pc_input(pc_de),
      .pcInc_input(pcInc_de),
      .RUrs1_input(RU1),
      .RUrs2_input(RU2),
      .ImmExt_input(ImmExt),
      .rd_input(inst_de[11:7]),
      .rs1_input(inst_de[19:15]),
      .rs2_input(inst_de[24:20]),
      .RUWr_input(RUWr),
      .DMWr_input(DMWr),
      .DMRd_input(DMRd),
      .ALUASrc_input(ALUASrc),
      .ALUBSrc_input(ALUBSrc),
      .RUDataWrSrc_input(RUDataWrSrc),
      .DMCtrl_input(DMCtrl),
      .AluOp_input(ALUOp),
      .BrOp_input(BrOp),
      .pc_output(pc_ex),
      .pcInc_output(pcInc_ex),
      .RUrs1_output(RUrs1_ex),
      .RUrs2_output(RUrs2_ex),
      .ImmExt_output(ImmExt_ex),
      .rd_output(rd_ex),
      .rs1_output(rs1_ex),
      .rs2_output(rs2_ex),
      .RUWr_output(RUWr_ex),
      .DMWr_output(DMWr_ex),
      .DMRd_output(DMRd_ex),
      .ALUASrc_output(ALUASrc_ex),
      .ALUBSrc_output(ALUBSrc_ex),
      .RUDataWrSrc_output(RUDataWrSrc_ex),
      .DMCtrl_output(DMCtrl_ex),
      .AluOp_output(ALUOp_ex),
      .BrOp_output(BrOp_ex),
      .clk(clk),
      .clear_eden_hazard(eden_hazard),
      .clear_branchUnit(NextPcSrc)
  );

  forwardingunit fun (
      .rs1_ex (rs1_ex),
      .rs2_ex (rs2_ex),
      .rd_me  (rd_me),
      .rd_wb  (rd_wb),
      .RUWr_me(RUWr_me),
      .RUWr_wb(RUWr_wb),
      .FUAsrc (FUAsrc),
      .FUBsrc (FUBsrc)
  );

  alu malu (
      .A(ALUAMux),
      .B(ALUBMux),
      .ALUOp(ALUOp_ex),
      .S(ALURes)
  );

  branchunit mbranchunit (
      .rs1(FUAMux),
      .rs2(FUBMux),
      .BrOp(BrOp_ex),
      .NextPcSrc(NextPcSrc)
  );

  memoryregisters me (
      .clk(clk),
      .pcInc_input(pcInc_ex),
      .ALURes_input(ALURes),
      .rd_input(rd_ex),
      .RUrs2_input(RUrs2_ex),
      .DMWr_input(DMWr_ex),
      .RUWr_input(RUWr_ex),
      .RUDataWrSrc_input(RUDataWrSrc_ex),
      .DMCtrl_input(DMCtrl_ex),
      .pcInc_output(pcInc_me),
      .ALURes_output(ALURes_me),
      .rd_output(rd_me),
      .RUrs2_output(RUrs2_me),
      .DMWr_output(DMWr_me),
      .RUWr_output(RUWr_me),
      .RUDataWrSrc_output(RUDataWrSrc_me),
      .DMCtrl_output(DMCtrl_me)
  );

  datamemory mdatamemory (
      .Address(ALURes_me),
      .DataWr(RUrs2_me),
      .DMWr(DMWr_me),
      .DMCtrl(DMCtrl_me),
      .DataRd(DataRd)
  );

  writebackregisters wb (
      .clk(clk),
      .pcInc_input(pcInc_me),
      .ALURes_input(ALURes_me),
      .DMDataRd_input(DataRd),
      .rd_input(rd_me),
      .RUWr_input(RUWr_me),
      .RUDataWrSrc_input(RUDataWrSrc_me),
      .pcInc_output(pcInc_wb),
      .ALURes_output(ALURes_wb),
      .DMDataRd_output(DMDataRd_wb),
      .rd_output(rd_wb),
      .RUWr_output(RUWr_wb),
      .RUDataWrSrc_output(RUDataWrSrc_wb)
  );

  initial begin
      BuPp4Mux <= 0;
  end

  always_comb begin
    PcPlus4 = pc_fe + 4;

    if (NextPcSrc) BuPp4Mux = ALURes;
    else BuPp4Mux = PcPlus4;

    if (FUAsrc == 2'b01) FUAMux = ALURes_me;
    else if (FUAsrc == 2'b10) FUAMux = RUDataMux;
    else FUAMux = RUrs1_ex;

    if (FUBsrc == 2'b01) FUBMux = ALURes_me;
    else if (FUBsrc == 2'b10) FUBMux = RUDataMux;
    else FUBMux = RUrs2_ex;

    if (ALUASrc_ex) ALUAMux = pc_ex;
    else ALUAMux = FUAMux;

    if (ALUBSrc_ex) ALUBMux = ImmExt_ex;
    else ALUBMux = FUBMux;

    if (RUDataWrSrc_wb == 2'b10) RUDataMux = pcInc_wb;
    else if (RUDataWrSrc_wb == 2'b01) RUDataMux = DMDataRd_wb;
    else if (RUDataWrSrc_wb == 2'b00) RUDataMux = ALURes_wb;
  end

endmodule
