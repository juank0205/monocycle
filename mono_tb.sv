module mono_tb;
  // Define clock parameters
  parameter CLK_PERIOD = 10;  // Clock period in time units
  parameter HALF_PERIOD = CLK_PERIOD / 2;  // Half clock period

  mono dut (.clk(clk));

  logic clk = 0;
  always #HALF_PERIOD clk = !clk;

  // Print content of submodules
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, mono_tb);

    for (int cycle = 0; cycle < 1000; cycle++) begin
      // Print the cycle number
      $display("Cycle %d:", cycle);

      // Loop through all registers and print their content
      for (int i = 0; i < 32; i++) begin
        if (i % 2 == 0)  // Print newline every 2 registers
          $write("\n");
        $write("x%d:%08h    ", i, dut.mregisterunit.registers[i]);
      end
      $write("\n");

      // Delay for one clock cycle
      #10;
    end
    $finish;
  end

endmodule
