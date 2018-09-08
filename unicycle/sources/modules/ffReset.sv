`timescale 1ns / 1ps

module ffReset #(parameter  WIDTH = 64)
  (input logic clk, rst,
  input logic [WIDTH-1:0] d,
  output logic [WIDTH-1:0] q);

  always_ff @ (posedge clk)
    if(rst) q <= 0;
    else    q <= d;

endmodule
