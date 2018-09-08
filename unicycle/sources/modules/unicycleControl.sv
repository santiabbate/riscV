`timescale 1ns / 1ps

import defines::*;

module control #(parameter  WIDTH = 64)
  (input opcode_t opcode,
  input logic [2:0] funct7,
  input logic [2:0] funct3,
  input logic zero,
  // output logic [3:0] aluControl,
  output aluOperations_t aluControl,
  output logic aluSrc,memToReg,regWrite,memRead,memWrite,pcSrc);

  //Internal signals definitions
  logic [1:0] aluOp;
  logic branch;
  logic [7:0] controlSignals;

  assign {aluSrc,memToReg,regWrite,memRead,memWrite,branch,aluOp} = controlSignals;
  assign pcSrc = branch & zero;

  //Alu Operation Decoder instance
  aluDecoder aluDec(aluOp,funct7,funct3,aluControl);

  //Main controller logic
  always_comb begin
    case (opcode)
      RTYPE: controlSignals = 8'b00100010; //R-format instruction
      LD: controlSignals = 8'b11110000; //ld
      SD: controlSignals = 8'b1x001000; //sd
      BEQ: controlSignals = 8'b0x000101; //beq
      default: controlSignals = 8'b0x100010; //Illegal opcode REVISAR!!!
    endcase
  end



endmodule
