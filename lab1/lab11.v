`timescale 1ns/1ps
module nand_1(c,b,a);
	output c;
	input a,b;
	wire d;
	and a1(d,a,b);
	not n1(c,d);
endmodule


