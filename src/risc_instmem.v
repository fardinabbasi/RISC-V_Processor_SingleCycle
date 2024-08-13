`timescale 1ns/1ns
module Instruction_Memory (
    input [31:0] PC,
    output reg [31:0] instruction
);
    reg [31:0] instructions_Value[31:0];
initial begin
    $readmemh("instruction.txt", instructions_Value);
end
    always@(*) begin
    instruction = instructions_Value[PC/4];
    end
endmodule
