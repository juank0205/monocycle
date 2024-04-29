module pc_tb;

  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in ns

  // Signals
  logic clk;
  logic [31:0] pc_input;
  logic [31:0] pc_output;

  // Instantiate the module under test
  pc dut (
    .clk(clk),
    .pc_input(pc_input),
    .pc_output(pc_output)
  );

  // Clock generation
  always #((CLK_PERIOD)/2) clk = ~clk;

  // Test stimulus
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, pc_tb);
    clk = 0;
    pc_input = 32'h00000000; // Initial value for pc_input

    // Test case 1
    #10; // Wait for 10 time units
    pc_input = 32'h00000001; // Change pc_input value
    #10; // Wait for 10 time units

    // Test case 2
    pc_input = 32'h00000010; // Change pc_input value
    #10; // Wait for 10 time units

    // Test case 3
    pc_input = 32'h80000000; // Change pc_input value
    #10; // Wait for 10 time units
    #10;

    // Finish simulation
    $finish;
  end

  // Display output
  always @(posedge clk) begin
    $display("pc_output = %h", pc_output);
  end

endmodule
