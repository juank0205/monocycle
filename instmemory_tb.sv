module instmemory_tb;

  // Parameters
  parameter CLK_PERIOD = 10;  // Clock period in time units

  // Signals
  logic [31:0] address;
  logic [31:0] instruction;

  // Instantiate the module under test
  instmemory uut (
      .address(address),
      .instruction(instruction)
  );

  // Clock generation
  logic clk = 0;
  always #((CLK_PERIOD) / 2) clk = ~clk;

  // Test stimulus
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, instmemory_tb);
    // Initialize address
    address = 0;

    // Test reading instructions at different addresses
    #10;
    address = 4;  // Read instruction at address 0
    #10;
    address = 8;  // Read instruction at address 1
    #10;
    address = 12;  // Read instruction at address 2
    #10;
    // Add more test cases as needed...

    // Finish simulation
    #10;
    $finish;
  end

  // Clock driver
  always #((CLK_PERIOD) / 2) clk = ~clk;

endmodule
