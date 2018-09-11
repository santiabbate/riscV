`timescale 1ns / 1ps
package defines;

parameter XLEN = 32;

typedef enum logic [3:0] {
  ADD = 4'b0010,    //2
  SUB = 4'b0110,    //6
  AND = 4'b0000,    //0
  OR = 4'b0001}     //1
  aluOperations_t;

typedef enum logic [6:0] {
  OPCODE_LOAD =   7'b00_000_11,  // h03
  OPCODE_STORE =  7'b01_000_11,  // h23
  //OPCODE_MADD
  OPCODE_BRANCH =  7'b11_000_11, // h63
  //OPCODE_LOAD_FP
  //OPCODE_STORE_FP
  //OPCODE_MSUB
  OPCODE_JALR =   7'b11_001_11,   // h67
  //OPCODE_NMSUB
  //OPCODE_MISC_MEM
  //OPCODE_AMO
  //OPCODE_NMADD
  OPCODE_JAL =    7'b11_011_11,   // h6F
  OPCODE_OP_IMM = 7'b00_100_11,   // h13
  OPCODE_OP =     7'b01_100_11,   // h33
  //OPCODE_FP
  //OPCODE_SYSTEM
  OPCODE_AUIPC =  7'b00_101_11,   // h17
  OPCODE_LUI =    7'b01_101_11,   // h37
  //OPCODE_OP_IMM_32
  //OPCODE_OP_32
  } opcode_t;

// Instrucion parameters

parameter FUNCT3_ADD = 3'b000;
parameter FUNCT3_SUB = 3'b000;

parameter FUNCT3_SLT =  3'b010;
parameter FUNCT3_SLTU = 3'b011;

parameter FUNCT3_XOR = 3'b100;
parameter FUNCT3_OR =  3'b110;

parameter FUNCT3_OR =  3'b110;
parameter FUNCT3_AND = 3'b111;


typedef struct packed{
  logic [31:7] instructionBits;
  opcode_t opcode;
} instruction_generic_t;

// RV32I Core Instruction formats

// R-Type
typedef struct packed{
  logic [31:25] func7;
  logic [24:20] rs2;
  logic [19:15] rs1;
  logic [14:12] funct3;
  logic [11:7] rd;
  opcode_t opcode;
} instruction_rtype_t;

// I-Type
typedef struct packed{
  logic [31:20] imm;
  logic [19:15] rs1;
  logic [14:12] funct3;
  logic [11:7] rd;
  opcode_t opcode;
} instruction_itype_t;

// S-Type
typedef struct packed{
  logic [31:25] immHigh;
  logic [24:20] rs2;
  logic [19:15] rs1;
  logic [14:12] funct3;
  logic [11:7] immLow;
  opcode_t opcode;
} instruction_stype_t;

// U-Type
typedef struct packed{
  logic [31:12] imm;
  logic [11:7] rd;
  opcode_t opcode;
} instruction_utype_t;

typedef union packed{
  instruction_rtype_t instruction_rtype;
  instruction_itype_t instruction_itype;
  instruction_stype_t instruction_stype;
  instruction_utype_t instruction_utype;
}

endpackage
