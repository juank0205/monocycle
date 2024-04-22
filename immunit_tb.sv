module immunit_tb;
  logic [24:0] ImmInput;
  logic [ 2:0] ImmSrc;
  logic [31:0] ImmExt;

  immunit uut (
      .ImmInput(ImmInput),
      .ImmSrc  (ImmSrc),
      .ImmExt  (ImmExt)
  );

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, immunit_tb);

    // Test case 1: Immediate type I
    ImmInput = 25'b0000000011110000000000000;  //000000000101  5
    ImmSrc = 3'b000;
    #10;  // Wait for 10 time units
    // Test case 2: Immediate type S
    ImmInput = 25'b1000000000000000000000010;  //100000000010 1026
    ImmSrc = 3'b001;
    #10;  // Wait for 10 time units
    // Test case 3: Immediate type B   32+2
    ImmInput = 25'b0000001000000000000000010;  // 34
    ImmSrc = 3'b101;
    #10;  // Wait for 10 time units
    // Test case 4: Immediate type U
    ImmInput = 25'b0000000000000000000100000;  //1024
    ImmSrc = 3'b010;
    #10;  // Wait for 10 time units
    // Test case 5: Immediate type J
    ImmInput = 25'b0000000000000000000100000;  //1024
    ImmSrc = 3'b110;
    #10;  // Wait for 10 time units
    // End of simulation
    $finish;
  end

endmodule
