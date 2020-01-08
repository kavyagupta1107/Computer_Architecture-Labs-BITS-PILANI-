module dff_sync(d,q,clk,clear);//active low reset
	input clk,d,clear;
	output q;
	reg q;
	always@(posedge clk)
		if(!clear) 
			begin
				q<=1'b0;
			end
		else 
			begin
				q<=d;
			end
endmodule

module dff_async(d,q,clk,clear);//active low reset
	input d,clk,clear;
	output q;
	reg q;
	always@(posedge clk or negedge clear)
		if(!clear) 
			begin
				q<=1'b0;
			end
		else 
			begin
				q<=d;
			end
endmodule
