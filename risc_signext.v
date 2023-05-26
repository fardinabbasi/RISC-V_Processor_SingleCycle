module sign_ext (input [2:0]Imm_Src,input [24:0]d_in,output reg [31:0]ImmExt);
  always@(*)
  case(Imm_Src)
  //I_type
  3'b000: ImmExt={{20{d_in[24]}},d_in[24:13]};
  //S_type
  3'b001: ImmExt = {{20{d_in[24]}}, d_in[24:18], d_in[4:0]};
  //B_type
  3'b010: ImmExt = {{20{d_in[24]}}, d_in[0],  d_in[23:18], d_in[4:1], 1'b0};
  // u type
	3'b011: ImmExt ={d_in[24:5],12'b000000000000};
  // j type
	3'b100: ImmExt =  {{12{d_in[24]}}, d_in[12:5],  d_in[13], d_in[23:14], 1'b0};
  default: 	ImmExt = 32'bx; // undefined
    endcase
endmodule
