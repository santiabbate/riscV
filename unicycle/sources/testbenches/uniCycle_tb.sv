`timescale 1ns / 1ps

module uniCycle_tb();
  parameter  WIDTH = 64;

  logic clk,rst;
  // logic [WIDTH-1:0] dataAddress, readData, writeData;
  // logic [31:0] instruction;

  logic [3:0] led;
  logic [3:0] btn;
  logic [3:0] sw;

  //DUT
  // top uniCycle(clk, rst,dataAddress, readData, writeData,instruction);
  top uniCycle(clk,led,btn,sw);

  // Generate clock
  always begin
    clk = 1; #5; clk = 0; #5;
  end

  initial begin
    sw[0] = 1;
    #8;
    sw[0] = 0;
  end


endmodule
