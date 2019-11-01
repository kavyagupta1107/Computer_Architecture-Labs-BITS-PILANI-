module mux_21_beh(f,a,b,s);
	output f;
	input a,b,s;
	reg f;
	always@(s or a or b)
		if(s==0) f=a;
		else f=b;
endmodule
	