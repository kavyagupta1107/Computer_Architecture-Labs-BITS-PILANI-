module mux_21_data(f,a,b,s);
	output f;
	input a,s,b;
	assign f= s?a:b;
endmodule