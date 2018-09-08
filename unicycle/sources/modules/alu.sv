`timescale 1ns / 1ps

module alu #(parameter  WIDTH = 64)
  (input logic [3:0] aluControl,
  input logic [WIDTH-1:0] src1, src2,
  output logic [WIDTH-1:0] result,
  output logic zero);

  assign zero = (result == 0) ? 1 : 0;

  always_comb begin
    case (aluControl)
      4'b0000: result = src1 & src2;
      4'b0001: result = src1 | src2;
      4'b0010: result = src1 + src2;
      4'b0110: result = src1 - src2;
      default: result = 'x;
    endcase
  end


endmodule
