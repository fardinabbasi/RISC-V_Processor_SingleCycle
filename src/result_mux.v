module result_mux (input  [31:0] ALUResult, ReadData, PCPlus4,ImmExt,input  [1:0] ResultSrc,output [31:0] Result);
     assign Result = (ResultSrc==2'b00)?ALUResult:(ResultSrc==2'b01)?ReadData:(ResultSrc==2'b10)?PCPlus4:ImmExt;
endmodule