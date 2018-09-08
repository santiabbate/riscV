`timescale 1ns / 1ps

import defines::*;

module riscvUnicycle #(parameter  WIDTH = 64)
  (input logic clk, rst,
  //Instruction memory access
  output logic [WIDTH-1:0] pc,
  input logic [31:0] instruction,
  //Data memory access
  output logic [WIDTH-1:0] dataAddress,
  input logic [WIDTH-1:0] readData,
  output logic [WIDTH-1:0] writeData,
  //Data memory control signals
  output logic memWrite,
  output logic memRead);

  //Internal signals definitions
  aluOperations_t aluControl;
  logic pcSrc,
        memToReg,
        aluSrc,
        regWrite,
        zero;

  //Datapath instance
  datapath #(WIDTH) d(clk,rst,
             pc, instruction,
             dataAddress, readData, writeData,
             zero, aluControl, aluSrc, memToReg, regWrite, pcSrc);

  //Controller instance
  control #(WIDTH) c(opcode_t'(instruction[6:0]),
              instruction[31:29],
              instruction[14:12],
              zero,
              aluControl,
              aluSrc,
              memToReg,
              regWrite,
              memRead,
              memWrite,
              pcSrc);


endmodule
