`timescale 1ns / 1ps

import defines::*;

module top #(parameter WIDTH = 64) (input logic clk,
           //output logic [WIDTH-1:0] dataAddress, readData, writeData,
           //output logic [31:0] instruction,
           output logic [3:0] led,
           input logic [3:0] btn,
           input logic [3:0] sw);

  //Clock Generation Module
  logic tenMegClk;
  clk_wiz_0 clkDiv(tenMegClk,sw[0],clk);

  //Internal signals definitions
  //Instruction Memory signals
  logic [WIDTH-1:0] pc;
  logic [31:0] instruction;
  //Data Memory signals
  logic [WIDTH-1:0] dataAddress, readData, writeData;
  logic memWrite, memRead;

  logic [WIDTH-1:0] ledsOut;

  //riscV instance
  riscvUnicycle #(WIDTH) riscV(tenMegClk,sw[0],
             pc, instruction,
             dataAddress, readData, writeData,
             memWrite, memRead);

  //Instruction Memory instance
  localparam IMEM_DEPTH  = 32;
  imem #(32,IMEM_DEPTH) imem(pc[6:2],
                     instruction);

  //Data Memory interface
  localparam DMEM_MAX_DEPTH = 32;
  memoryInterface #(WIDTH,DMEM_MAX_DEPTH) memInterface(tenMegClk,
                                        memWrite,
                                        memRead,
                                        dataAddress,
                                        writeData,
                                        readData,
                                        ledsOut,
                                        { {60{1'b0}}, sw },
                                        { {60{1'b0}}, btn });

   assign led = ledsOut[3:0];

endmodule
