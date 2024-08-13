`timescale 1ns/1ns
module Controller (
    input [6:0] OP,funct7,
    input [2:0] funct3,
    input Zero,
    output reg mem_write,ALU_Src,reg_write,
    output reg [1:0] ResultSrc,PCSrc,
    output reg [2:0] ALUControl,
    output reg [2:0] Imm_Src,
    output reg WD3_Src
);
reg branch;
    always @(*)begin
         branch <=(OP==7'b1100011)?1'b1:1'b0;
    end
    
    wire [9:0] check;
    assign check={{funct7},{funct3}};
    reg [1:0] ALUOp;
    always @(OP) begin
	{reg_write,mem_write}=2'b0;
	{ALU_Src,ResultSrc,PCSrc,Imm_Src,WD3_Src,ALUOp}=11'bxxxxxxxxxxx;
        casex (OP)
            7'b0110011: begin  //R_type
                reg_write <= 1;
                Imm_Src <= 3'bxxx;
                ALU_Src <= 0;
                mem_write <= 0;
                ResultSrc <= 2'b00;
                //PCSrc <=2'b00;
                ALUOp <= 2'b00;
                WD3_Src <=0;
            end 

            7'b0010011:begin  //I_type
                reg_write <= 1;
                Imm_Src <= 3'b000;
                ALU_Src <= 1;
                mem_write <= 0;
                ResultSrc <= 2'b00;
               // PCSrc <=2'b00;
                ALUOp <= 2'b01;
                WD3_Src <=0;
            end

            7'b1100111:begin  //jalr
                reg_write <= 1;
                Imm_Src <= 3'b000;
                ALU_Src <= 1;
                mem_write <= 0;
                ResultSrc <= 2'b00;
               // PCSrc <=2'b10;
                ALUOp <= 2'b11;
                WD3_Src <=1;
            end

            7'b0000011:begin  //Lw
                reg_write <= 1;
                Imm_Src <= 3'b000;
                ALU_Src <= 1;
                mem_write <= 0;
                ResultSrc <= 2'b01;
               // PCSrc <=2'b00;
                ALUOp <= 2'b10;
                WD3_Src <=0;
            end

            7'b0100011:begin  //S_type
                reg_write <= 0;
                Imm_Src <= 3'b001;
                ALU_Src <= 1;
                mem_write <= 1;
                ResultSrc <= 2'bxx;
               // PCSrc <=2'b00;
                ALUOp <= 2'b10;
                WD3_Src <=0;
            end
            7'b1100011:begin //B_type
                reg_write <= 0;
                Imm_Src <= 3'b010;
                ALU_Src <= 0;
                mem_write <= 0;
                ResultSrc <= 2'b00;
                //PCSrc <=(Zero)?2'b01:2'b00;
                ALUOp <= 2'b10;
                WD3_Src <=0;
            end
            7'b0110111:begin//lui
                reg_write <= 1;
                Imm_Src <= 3'b011;
                ALU_Src <= 1'bx;
                mem_write <= 0;
                ResultSrc <= 2'b11;
               // PCSrc <=2'b00;
                ALUOp <= 2'bxx;
                WD3_Src <=0;
            end    
            7'b1101111:begin//jal
                reg_write <= 1;
                Imm_Src <= 3'b100;
                ALU_Src <= 1'bx;
                mem_write <= 0;
                ResultSrc <= 2'bxx;
               // PCSrc <=2'b01;
                ALUOp <= 2'bxx;
                WD3_Src <=1;
            end  
            default:begin
                reg_write <= 0;
                Imm_Src <= 3'bxxx;
                ALU_Src <= 1'bx;
                mem_write <= 0;
                ResultSrc <= 2'bxx;
                //PCSrc <=2'bxx;
                ALUOp <= 2'bxx;
                WD3_Src <=1'bx;
            end 
            
        endcase
        
    end
    always @(*) begin
	PCSrc=2'bxx;
        case (OP)
            7'b0110011:PCSrc<=2'b0;
            7'b0010011:PCSrc<=2'b0;
            7'b1100111:PCSrc<=2'b10;
            7'b0000011: PCSrc<=2'b0;
            7'b0100011:PCSrc<=2'b0;
            7'b1100011:PCSrc=(Zero)?2'b01:2'b0;
            7'b0110111:PCSrc<=2'b0;
            7'b1101111:PCSrc<=2'b01;
            default: PCSrc <= 2'bxx;
        endcase
        
    end
    always @(ALUOp,check,funct3,funct7) begin
	ALUControl=3'bxxx;
        case (ALUOp)
             2'b00:begin ALUControl<=(check==10'b0)?3'b0:
                  (check==10'd256)?3'b001:
                  (check==10'd7)?3'b010:
                  (check==10'd6)?3'b011:
                  (check==10'd2)?3'b100:3'bxxx;
                  end
            2'b01:begin ALUControl<=(funct3==3'b000)?3'b0:
                  (funct3==3'b110)?3'b011:
                  (funct3==3'b100)?3'b101:
                  (funct3==3'b010)?3'b100:3'bxxx;
                   end
            2'b10:begin ALUControl<=(funct3==10'b010)?3'b0:
                  (funct3==3'b0)?3'b001:
                  (funct3==3'b001)?3'b001:
                  (funct3==3'b100)?3'b100:
                  (funct3==3'b101)?3'b100:3'bxxx;
                   end
            2'b11: ALUControl<=3'b0;
            default: ALUControl <= 3'bxxx;
        endcase
        
    end
endmodule