`timescale 1ns / 1ps
package defines;

typedef enum logic [3:0] {
  ADD = 4'b0010,    //2
  SUB = 4'b0110,    //6
  AND = 4'b0000,    //0
  OR = 4'b0001}     //1
  aluOperations_t;

typedef enum logic [6:0] {
  RTYPE = 51,
  LD = 3,
  SD = 35,
  BEQ = 99} opcode_t;

typedef struct packed{
  opcode_t opcode;
  logic [31:7] instructionBits;
} instruction_t;

endpackage
