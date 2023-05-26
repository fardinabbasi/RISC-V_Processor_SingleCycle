`timescale 1ns/1ns
module PCPlus4_adder(input[31:0]PC,output[31:0]PCPlus4);
    assign PCPlus4 = PC + 3'd4;
endmodule
