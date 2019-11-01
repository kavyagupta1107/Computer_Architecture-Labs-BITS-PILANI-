module decoder_38(d0,d1,d2,d3,d4,d5,d6,d7,x,y,z);
	output d0,d1,d2,d3,d4,d5,d6,d7;
	input x,y,z;
	wire x0,y0,z0;
	not n1(x0,x);
	not n2(y0,y);
	not n3(z0,z);
	
	and a1(d0,x0,y0,z0);
	and a2(d1,x0,y0,z);
	and a3(d2,x0,y,z0);
	and a4(d3,x0,y,z);
	and a5(d4,x,y0,z0);
	and a6(d5,x,y0,z);
	and a7(d6,x,y,z0);
	and a8(d7,x,y,z);
endmodule
	