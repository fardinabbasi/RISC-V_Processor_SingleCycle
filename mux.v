module mux(input [31:0] RD2, ImmExt, input ALU_Src, output [31:0] SrcB);
     assign SrcB = ALU_Src ?  ImmExt:RD2;
endmodule
