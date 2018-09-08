`timescale 1ns / 1ps
//typedef enum logic [3:0] {ADD = 4'b0010, SUB = 4'b0110, AND = 4'b0000, OR = 4'b0001,  NONE = 4'bxxxx} aluOperations_t;

import defines::*;

module control_tb();
  parameter  WIDTH = 64, DEPTH = 32;

  opcode_t opcode;
  logic [2:0] funct7, funct3;
  logic zero;
  aluOperations_t aluCtrl;
  logic aluSrc,memToReg,regWrite,memRead,memWrite,pcSrc;
  logic [5:0] controlOut;
  //DUT

  assign controlOut = {aluSrc,memToReg,regWrite,memRead,memWrite,pcSrc};
  control dut(opcode,
              funct7,
              funct3,
              zero,
              aluCtrl,
              aluSrc,
              memToReg,
              regWrite,
              memRead,
              memWrite,
              pcSrc);

  initial begin
    opcode = RTYPE; //R-type
    funct7 = 0;
    funct3 = 0; //ADD
    zero = 0;
    #50
    opcode = RTYPE; //R-type
    funct7 = 2;
    funct3 = 0; //SUB
    zero = 0;
    #50
    opcode = RTYPE; //R-type
    funct7 = 0;
    funct3 = 7; //AND
    zero = 0;
    #50
    opcode = RTYPE; //R-type
    funct7 = 0;
    funct3 = 6; //OR
    zero = 0;
    #50
    opcode = LD; //ld
    funct7 = 0;
    funct3 = 0;
    zero = 0;
    #50
    opcode = SD; //sd
    funct7 = 0;
    funct3 = 0;
    zero = 0;
    #50
    opcode = BEQ; //beq
    funct7 = 0;
    funct3 = 0;
    zero = 0;   //Hay que saltar
    #50
    opcode = BEQ; //beq
    funct7 = 0;
    funct3 = 0;
    zero = 1;   //No hay que saltar
  end


endmodule
