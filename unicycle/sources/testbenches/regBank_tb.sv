`timescale 1ns / 1ps

module regBank_tb();
  parameter  WIDTH = 64, DEPTH = 32;

  logic clk, wen;
  logic [$clog2(DEPTH)-1:0] ra1, ra2, wa;
  logic [WIDTH-1:0] wd;
  logic [WIDTH-1:0] rd1,rd2;
  //DUT
  regBank regFile(clk, wen, ra1, ra2, wa, wd, rd1, rd2);

  // Generate clock
  always begin
    clk = 1; #5; clk = 0; #5;
  end

  initial begin
    wen = 0;
    ra1 = 0;
    ra2 = 1;
    wa = 1;
    wd = 3;
    #20;
    wen = 1;
  end


endmodule
