module pc_mux (input  [31:0] PCPlus4,PCTarget,Result,input  [1:0] PCSrc,output [31:0] PCnext);
     assign PCnext = (PCSrc==2'b00)?PCPlus4:(PCSrc==2'b01)?PCTarget:Result;
endmodule
