module WD3_mux (input  [31:0] PCPlus4,Result,input WD3_Src,output [31:0] OUTWD3);
     assign OUTWD3 = WD3_Src ? PCPlus4:Result;
endmodule

