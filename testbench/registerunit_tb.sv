module registerunit_tb;

  // Parameters
  parameter int CLOCK_PERIOD = 10;  // Clock period in ns

  // Inputs
  logic clk;
  logic [4:0] rs1, rs2, rd;
  logic RuWr;
  logic [31:0] RuWrData;

  // Outputs
  logic [31:0] ru1, ru2;

  // Instantiate the RegistersUnit module
  registerunit dut (
      .clk(clk),
      .rs1(rs1),
      .rs2(rs2),
      .rd(rd),
      .RuWr(RuWr),
      .RuWrData(RuWrData),
      .ru1(ru1),
      .ru2(ru2)
  );

  // Clock generation
  always #((CLOCK_PERIOD) / 2) clk = ~clk;

  // Test stimulus
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, registerunit_tb);
    // Initialize inputs
    clk      = 0;
    rs1      = 5'b00000;  // Select register 0 initially
    rs2      = 5'b00001;  // Select register 1 initially
    rd       = 5'b00010;  // Select register 2 for writing initially
    RuWr     = 0;  // Enable write initially
    RuWrData = 32'h12345678;  // Data to be written

    #10;  // Wait for a few cycles
    rd       = 5'b00010;  // Select register 2 for writing initially
    RuWr     = 1;  // Enable write initially

    #10;  // Wait for a few cycles
    rd       = 5'b00001;  // Select register 2 for writing initially
    RuWr     = 1;  // Enable write initially

    #10;  // Wait for a few cycles
    RuWr = 0;

    #10;  // Wait for a few cycles
    rs1      = 5'b00001;  // Select register 0 initially
    rs2      = 5'b00011;  // Select register 1 initially

    // End simulation
    #10;  // Wait for a few cycles
    $finish;
  end

endmodule

