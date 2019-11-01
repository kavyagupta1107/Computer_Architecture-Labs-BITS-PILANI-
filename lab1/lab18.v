module compar(f,a,b);
	output f;
	input a,b;
	reg f;
	always@(a or b)
		if(a<b) f=-1;
		else if (a==b) f=0;
		else f=1;
endmodule
