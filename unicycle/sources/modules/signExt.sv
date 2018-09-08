`timescale 1ns / 1ps

module signExt #(parameter  WIDTH = 64)
  (input logic [31:0] instruction,
  output logic [WIDTH-1:0] out);

  logic [11:0] immediate;

  //Opcodes
  // ld -> 3                 -> 0000011
  // sd -> 35                -> 0100011
  // beq -> 99               -> 1100011
  // add, dub, and, or -> 51 -> 0110011

always_comb begin
  case(instruction[6:5])
    2'b00: immediate = {instruction[31:20]};
    2'b01: immediate = {instruction[31:25],instruction[11:7]};
    2'b11: immediate = {instruction[31],instruction[7],instruction[30:25],instruction[11:8]};
    default: immediate = {instruction[31:20]};
  endcase
end

assign out = {{(WIDTH-12){immediate[11]}},immediate};

endmodule
