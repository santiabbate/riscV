`timescale 1ns / 1ps

module adder #(parameter  WIDTH = 64)
  (input logic [WIDTH-1:0] in1,in2,
  output logic [WIDTH-1:0] sum);

  assign sum = in1 + in2;

endmodule
