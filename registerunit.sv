module registerunit (
    input logic clk,            // Clock input
    input logic [4:0] rs1, rs2,// Inputs to select registers
    input logic [4:0] rd,      // Input to select register for writing
    input logic RuWr,          // Write enable signal
    input logic [31:0] RuWrData, // Data to be written to the selected register
    output logic [31:0] ru1, ru2 // Outputs from selected registers
);

    // Define 32 registers each of 32 bits
    logic [31:0] registers [31:0];

    // Wire up ru1 and ru2 outputs
    assign ru1 = registers[rs1];
    assign ru2 = registers[rs2];

    // Write data to the selected register on rising edge of the clock
    always_ff @(posedge clk) begin
        if (RuWr) begin
            // Write data to the selected register
            registers[rd] <= RuWrData;
        end
    end

endmodule