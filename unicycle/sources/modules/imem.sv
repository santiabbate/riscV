`timescale 1ns / 1ps

module imem #(parameter  WIDTH = 64, DEPTH = 32)
  (input logic [$clog2(DEPTH)-1:0] ra,
  output logic [WIDTH-1:0] rd);

  // Memory elements
  logic [WIDTH-1:0] mem [0:DEPTH-1];

  // Combinational read
  assign rd = mem[ra];

  initial begin
    $readmemh("imem.h",mem);
  end


endmodule
