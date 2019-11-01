module mux_41(out,in,sel);
	input [0:3] in;
	input [0:1] sel;
	output out;
	wire w1,w2,d1,d2,d3,d4;
	not n1(w1,sel[0]);
	not n2(w2,sel[1]);
	and a1(d1,w1,w2,in[0]);
	and a2(d2,sel[1],w1,in[1]);
	and a3(d3,sel[0],w2,in[2]);
	and a4(d4,sel[0],sel[1],in[3]);
	or o1(out,d1,d2,d3,d4);
endmodule

module mux_161(out,in,sel);
	input [0:15]in;
	input [0:3]sel;
	output out;
	wire [0:3]t;
	mux_41 m1(t[0],in[0:3],sel[2:3]);
	mux_41 m2(t[1],in[4:7],sel[2:3]);
	mux_41 m3(t[2],in[8:11],sel[2:3]);
	mux_41 m4(t[3],in[12:15],sel[2:3]);
	mux_41 m5(out,t,sel[0:1]);
endmodule
	