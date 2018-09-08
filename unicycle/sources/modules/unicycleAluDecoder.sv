`timescale 1ns / 1ps

//typedef enum logic [3:0] {ADD = 4'b0010, SUB = 4'b0110, AND = 4'b0000, OR = 4'b0001, NONE = 4'bxxxx} aluOperations_t;
import defines::*;

module aluDecoder
  (input logic [1:0] aluOp,
  input logic [2:0] funct7,
  input logic [2:0] funct3,
  //output logic [3:0] aluControl);
  output aluOperations_t aluControl);

  // localparam  ADD = 4'b0010;
  // localparam  SUB = 4'b0110;
  // localparam  AND = 4'b0000;
  // localparam  OR  = 4'b0001;

always_comb begin
  case (aluOp)
    2'b00: aluControl = ADD;  // ld or sd instructions
    2'b01: aluControl = SUB;  // beq instruction
    default: case ({funct7[1], funct3}) // R-type instructions
      4'b0000: aluControl = ADD;
      4'b1000: aluControl = SUB;
      4'b0111: aluControl = AND;
      4'b0110: aluControl = OR;
      default: aluControl = ADD;
    endcase
  endcase
end

endmodule
