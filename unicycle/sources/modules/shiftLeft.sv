`timescale 1ns / 1ps

module shiftLeft #(parameter  WIDTH = 64, SHIFT = 1)
  (input logic [WIDTH-1:0] in,
  output logic [WIDTH-1:0] out);

//  assign out = {in[WIDTH-1-SHIFT]:0,SHIFT'b0};
assign out = in << SHIFT;

endmodule
