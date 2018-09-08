`timescale 1ns / 1ps

import defines::*;

module datapath #(parameter  WIDTH = 64)
  (input clk, rst,
  //Instruction memory access
  output logic [WIDTH-1:0] pc,
  input logic [31:0] instruction,
  //Data memory access
  output logic [WIDTH-1:0] dataAddress,
  input logic [WIDTH-1:0] readData,
  output logic [WIDTH-1:0] writeData,
  //Output to Controller
  output logic zero,
  //Controller inputs
  input aluOperations_t aluControl,
  input logic aluSrc,memToReg,regWrite,pcSrc);

  //Internal signals definitions
  logic [WIDTH-1:0] regWriteData,     //Data input to register bank
                    regOut2,          //Data out 2 from register bank (rs2)
                    aluSrc1, aluSrc2, //ALU Sources
                    immExt,          //Extended immediate
                    aluOut,
                    nextPC,
                    pcPlus4,
                    pcBranch,
                    immExtShifted;


  //Program Counter & Next PC Logic
  ffReset #(WIDTH) pcReg(clk,rst,
                      nextPC,
                      pc);

  mux2 #(WIDTH) nextPCMux(pcPlus4,
                           pcBranch,
                           pcSrc,
                           nextPC);

  adder #(WIDTH) pcPlus4Adder(pc,
                              64'b100,
                              pcPlus4);


  adder #(WIDTH) pcBranchAdder(pc,
                               immExtShifted,
                               pcBranch);

  signExt #(WIDTH) immGen(instruction,
                          immExt);

  shiftLeft immShifter(immExt,immExtShifted);

  //Registers data flow logic
  regBank #(WIDTH,32) registers(clk,
                             regWrite,
                             instruction[19:15],
                             instruction[24:20],
                             instruction[11:7],
                             regWriteData,
                             aluSrc1,
                             regOut2);

  mux2 #(WIDTH) regWriteDataMux(aluOut,
                                readData,
                                memToReg,
                                regWriteData);


  //ALU second operand mux
  mux2 #(WIDTH) aluSrcMux(regOut2,
                           immExt,
                           aluSrc,
                           aluSrc2);

  alu #(WIDTH) alu(aluControl,
                   aluSrc1,
                   aluSrc2,
                   aluOut,
                   zero);

  //Data Memory access
  assign dataAddress = aluOut;
  assign writeData = regOut2;


endmodule
