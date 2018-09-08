`timescale 1ns / 1ps

module peripherials #(parameter  WIDTH = 64)
  (input logic clk, wen, ren,
  //Address
  input logic [$clog2(DEPTH)-1:0] a,
  //Data In and Out
  input logic [WIDTH-1:0] wd,
  output logic [WIDTH-1:0] rd,
  //LEDs Output
  output logic [3:0] ledsOut,
  //Switch & Pushbutton inputs
  input logic [WIDTH-1:0] swIn,
  input logic [WIDTH-1:0] pshIn);

  localparam  DEPTH = 4;

  // Memory elements
  logic [WIDTH-1:0] mem [DEPTH];

  //Combinationa read
  assign rd = ren ? mem[a] : 0; //Data to cpu
  assign ledsOut = mem[0][3:0];      //Output to LEDs

  // Sequential write
  always_ff @ (posedge clk) begin
      //Memory elements 1 and 2 are read only from CPU
      mem[1] <= swIn;
      mem[2] <= pshIn;
      if (wen) mem[a] <= wd;
      // if (wen) mem[a] <= ((a == 1)|(a == 2) ? mem[a] : wd);

  end

  //initial begin
  //   mem[0] = 1;
  //   mem[1] = 1;
  //   mem[2] = 2;
  //   mem[3] = 3;
//end

endmodule
