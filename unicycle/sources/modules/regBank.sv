`timescale 1ns / 1ps

module regBank #(parameter  WIDTH = 64, DEPTH = 32)
  (input logic clk, wen,
  input logic [$clog2(DEPTH)-1:0] ra1, ra2, wa,
  input logic [WIDTH-1:0] wd,
  output logic [WIDTH-1:0] rd1,rd2);

  // Memory elements
  logic [WIDTH-1:0] regFile [0:DEPTH-1];

  // Combinational read
  // regFile[0] hardwired to zero
  assign rd1 = (ra1 != 0) ? regFile[ra1] : 0;
  assign rd2 = (ra2 != 0) ? regFile[ra2] : 0;

  // Sequential write
  always_ff @ (posedge clk) begin
      if (wen & wa != 0) regFile[wa] <= wd;
  end

endmodule
