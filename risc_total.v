`timescale 1ns/1ns
module risc_total(input rst,clk);
wire mem_write,ALU_Src,reg_write,WD3_Src,Zero;
wire[1:0] ResultSrc,PCSrc;
wire [2:0] ALUControl,funct3,Imm_Src;
wire [6:0] OP,funct7;


datapath DP(rst, clk,mem_write,ALU_Src,reg_write,WD3_Src,ResultSrc,PCSrc,Imm_Src,ALUControl,OP,funct7,funct3,Zero);
Controller CU(OP,funct7,funct3,Zero,mem_write,ALU_Src,reg_write,ResultSrc,PCSrc,ALUControl,Imm_Src,WD3_Src);

endmodule