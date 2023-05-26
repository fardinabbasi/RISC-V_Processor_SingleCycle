`timescale 1ns / 1ns
module datapath(input rst, clk,mem_write,ALU_Src,reg_write,WD3_Src,input[1:0]ResultSrc,PCSrc,input [2:0]Imm_Src,input [2:0]ALUControl
,output [6:0]OP,funct7,output [2:0] funct3,output Zero);

    wire [31:0] WD,WD3,instruction,PC,PCPlus4,PCTarget,PCnext,ImmExt,RD1,RD2,ALUResult;
    //wire [2:0] funct3;
    wire [31:0] SrcA,SrcB;
    wire [31:0] Result,OUTWD3;
    wire [31:0] ReadData;
    wire [4:0] A1,A2,A3;
    wire [24:0] Imm;
    //wire [6:0] OP;
    
    //wire funct7,Zero;
    wire WE3,WE,Branch;


    Adress_Generator SSS (.rst(rst),.clk(clk),.PCnext(PCnext),.PC(PC));
    Instruction_Memory AAA (.PC(PC),.instruction(instruction));
    Instruction_Fetch BBB (.instruction(instruction),.A1(A1),.A2(A2),.A3(A3),.OP(OP),.funct3(funct3),.Imm(Imm),.funct7(funct7));
    Register_File CCC (.A1(A1),.A2(A2),.A3(A3),.WD3(OUTWD3),.clk(clk),.WE3(reg_write),.rst(rst),.RD1(RD1),.RD2(RD2));
    alu DDD (.SrcA(RD1),.SrcB(SrcB),.ALUControl(ALUControl),.funct3(funct3),.ALUResult(ALUResult),.Zero(Zero));
    sign_ext EEE (.Imm_Src(Imm_Src),.d_in(Imm),.ImmExt(ImmExt));
    datamem FFF (.WD(RD2),.A(ALUResult),.clk(clk),.WE(mem_write),.rst(rst),.RD(ReadData));
    PCPlus4_adder PPP(.PC(PC),.PCPlus4(PCPlus4));
    PCTarget_adder yyy(.PC(PC),.ImmExt(ImmExt),.PCTarget(PCTarget));
    mux uuu(.RD2(RD2),.ImmExt(ImmExt),.ALU_Src(ALU_Src),.SrcB(SrcB));
    result_mux rrr(.ALUResult(ALUResult),.ReadData(ReadData),.PCPlus4(PCPlus4),.ImmExt(ImmExt),.ResultSrc(ResultSrc),.Result(Result));
    pc_mux xxx(.PCPlus4(PCPlus4),.PCTarget(PCTarget),.Result(Result),.PCSrc(PCSrc),.PCnext(PCnext));
    WD3_mux WWW(.PCPlus4(PCPlus4),.Result(Result),.WD3_Src(WD3_Src),.OUTWD3(OUTWD3));




endmodule