

module btog_data(out,in);
	output [3:0] out;
	input [3:0] in;
	assign out[3]=in[3];
	genvar ind;
	for(ind=2;ind>=0;ind=ind-1)
		begin
			assign out[ind]=in[ind]^in[ind+1];
		end
endmodule
