module half_adder(S,C,x,y);
	input x,y;
	output S,C;
	reg S,C;
	always@(x or y)
		begin
			{C,S}=x+y;
		end
endmodule

module full_adder(S1,C1,x1,y1,z1);
	input x1,y1,z1;
	output S1,C1;
	reg S1,C1;
	always@(x1 or y1 or z1)
		begin
			{C1,S1}=x1+y1+z1;
		end
endmodule

module fbit_adder(S2,C2,A,B,i);
	input [3:0] A,B;
	input i;
	output [3:0] S2;
	output C2;
	reg S2,C2;
	always@(A or B or i)
		begin
			{C2,S2}=A+B+i;
		end

endmodule

module add_sub(S3,C3,A1,B1,select);
	input [3:0] A1,B1;
	input select;
	output [3:0] S3;
	output C3;
	reg S3,C3;
	always@(A1 or B1 or select)
		begin
			{C3,S3}=A1+(B1^select)+select;
		end	
endmodule