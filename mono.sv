module mono (
    input logic clk
);
  logic [31:0] PcOutput;  // PC OUTPUT
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

  logic RUWr;
  logic [3:0] ALUOp;
  logic [2:0] ImmSrc;
  logic ALUASrc;
  logic ALUBSrc;
  logic DMWr;
  logic [2:0] DMCtrl;
  logic [4:0] BrOp;
  logic [1:0] RUDataWrSrc;

  pc mpc (
      .clk(clk),
      .pc_input(BuPp4Mux),
      .pc_output(PcOutput)
  );

  instmemory minstmemory (
      .address(PcOutput),
      .instruction(inst)
  );

  controlunit mcontrolunit (
      .OpCode(inst[6:0]),
      .Funct3(inst[14:12]),
      .Funct7(inst[31:25]),
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

  registerunit mregisterunit (
      .clk(clk),
      .rs1(inst[19:15]),
      .rs2(inst[24:20]),
      .rd(inst[11:7]),
      .RuWr(RUWr),
      .RuWrData(RUDataMux),
      .ru1(RU1),
      .ru2(RU2)
  );

  alu malu (
      .A(ALUAMux),
      .B(ALUBMux),
      .ALUOp(ALUOp),
      .S(ALURes)
  );

  datamemory mdatamemory (
      .Address(ALURes),
      .DataWr(RU2),
      .DMWr(DMWr),
      .DMCtrl(DMCtrl),
      .DataRd(DataRd)
  );

  immunit mimmunit (
      .ImmInput(inst[31:7]),
      .ImmSrc  (ImmSrc),
      .ImmExt  (ImmExt)
  );

  branchunit mbranchunit (
      .rs1(RU1),
      .rs2(RU2),
      .BrOp(BrOp),
      .NextPcSrc(NextPcSrc)
  );

  initial begin
    BuPp4Mux <= 0;
  end

  always @* begin
    PcPlus4 <= PcOutput + 4;

    if (NextPcSrc) BuPp4Mux <= ALURes;
    else BuPp4Mux <= PcPlus4;

    if (ALUASrc) ALUAMux <= PcOutput;
    else ALUAMux <= RU1;

    if (ALUBSrc) ALUBMux <= ImmExt;
    else ALUBMux <= RU2;

    if (RUDataWrSrc == 2'b10) RUDataMux <= PcPlus4;
    else if (RUDataWrSrc == 2'b01) RUDataMux <= DataRd;
    else if (RUDataWrSrc == 2'b00) RUDataMux <= ALURes;
  end

endmodule
