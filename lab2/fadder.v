`include "decoder_38.v"
module fadder(S,C,x,y,z);
	output S,C;
	input x,y,z;
	wire d0,d1,d2,d3,d4,d5,d6,d7;
	decoder_38 dec(d0,d1,d2,d3,d4,d5,d6,d7,x,y,z);
	assign S=d1|d2|d4|d7;
	assign C=d3|d5|d6|d7;
endmodule

module adder_8(s,c,a,b,cin);
	input [0:7] a,b;
	input cin;
	output c;
	output [0:7]s;
	wire [0:6]ct;
	fadder f1(s[7],ct[6],a[7],b[7],cin);
	fadder f2(s[6],ct[5],a[6],b[6],ct[6]);
	fadder f3(s[5],ct[4],a[5],b[5],ct[5]);
	fadder f4(s[4],ct[3],a[4],b[4],ct[4]);
	fadder f5(s[3],ct[2],a[3],b[3],ct[3]);
	fadder f6(s[2],ct[1],a[2],b[2],ct[2]);
	fadder f7(s[1],ct[0],a[1],b[1],ct[1]);
	fadder f8(s[0],c,a[0],b[0],ct[0]);
endmodule

module adder_32(s,c,a,b,cin);
	input cin;
	input [0:31]a,b;
	output c;
	output [0:31]s;
	wire [0:2]ct;
	adder_8 a1(s[24:31],ct[2],a[24:31],b[24:31],cin);
	adder_8 a2(s[16:23],ct[1],a[16:23],b[16:23],ct[2]);
	adder_8 a3(s[8:15],ct[0],a[8:15],b[8:15],ct[1]);
	adder_8 a4(s[0:7],c,a[0:7],b[0:7],ct[0]);
endmodule
	
	
	