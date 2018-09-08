`timescale 1ns / 1ps

import defines::*;

module memoryInterface #(parameter  WIDTH = 64, MAX_DEPTH = 32)
  (input logic clk, wen, ren,
  //Address and Data Inputs
  input logic [WIDTH-1:0] memAddress,
  input logic [WIDTH-1:0] writeData,
  //Data Output
  output logic [WIDTH-1:0] readData,
  //Peripherials interface
  output logic [WIDTH-1:0] ledsOut, //LEDs
  input logic [WIDTH-1:0] swIn,    //Switches
  input logic [WIDTH-1:0] pshIn);    //Pushbuttons

  //Internal signals definitions
  logic [WIDTH-1:0] dMemRd, pMemRd; //Data read outputs


  //Data routing muxes
    //Data read
  assign readData = (|memAddress[63:8]) ? pMemRd : dMemRd; //Higher Adresses than 256 map to peripherial memory

  //32 dwords data memory instance
  dmem #(WIDTH,32) dmem(clk,
                        (wen & (!memAddress[8])), //Enable write when address is valid
                        (ren & (!memAddress[8])), //Enable read when address is valid
                        memAddress[7:3],  //8 bytes doubleword. DoubleWord aligned
                        writeData,
                        dMemRd);

  //4 dwords peripherials memory interface
  peripherials #(WIDTH) per(clk,
                            (wen & (memAddress[8])), //Enable write when address is valid
                            (ren & (memAddress[8])), //Enable read when address is valid
                            memAddress[4:3],
                            writeData,
                            pMemRd,
                            ledsOut[3:0],
                            swIn,
                            pshIn);


endmodule
