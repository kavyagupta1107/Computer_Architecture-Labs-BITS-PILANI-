module half_adder(S,C,x,y);
	input x,y;
	output S,C;
	assign {C,S}=x+y;
endmodule

module full_adder(S1,C1,x1,y1,z1);
	input x1,y1,z1;
	output S1,C1;
	assign {C1,S1}=x1+y1+z1;
endmodule

module fbit_adder(S2,C2,A,B,i);
	input [3:0] A,B;
	input i;
	output [3:0] S2;
	output C2;
	assign {C2,S2}=A+B+i;
endmodule

module add_sub(S3,C3,A1,B1,select);
	input [3:0] A1,B1;
	input select;
	output [3:0] S3;
	output C3;
	assign {C3,S3}=A1+(B1^select)+select;
endmodule

	
	