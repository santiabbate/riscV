`timescale 1ns / 1ps

module dmem #(parameter  WIDTH = 64, DEPTH = 32)
  (input logic clk, wen, ren,
  input logic [$clog2(DEPTH)-1:0] a,
  input logic [WIDTH-1:0] wd,
  output logic [WIDTH-1:0] rd);

  // Memory elements
  logic [WIDTH-1:0] mem [0:DEPTH-1];

  assign rd = ren ? mem[a] : 0;

  // Sequential write
  always_ff @ (posedge clk) begin
      if (wen) mem[a] <= wd;
  end

  initial begin
    $readmemh("dmem.h",mem);
  end

endmodule
