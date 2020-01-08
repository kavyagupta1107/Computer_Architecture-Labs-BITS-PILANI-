`include "dff.v"
module testbench;
	reg d,clear,clk;
	wire q;
	dff_sync df(d,q,clk,clear);
	always@(posedge clk)
		$display($time,"d=%b,clear=%b,clk=%b,q=%b",d,clear,clk,q);
	
	initial
		begin
			forever 
				begin
				clk=0;
				#5
				clk=1;
				#5
				clk=0;
				end
			
		end
	initial 
		begin
			d=0; clear=1;
			#4
			d=1; clear=0;
			#50
			d=1; clear=1;
			#20
			d=0; clear=0;
		end
	initial
		begin
			$dumpfile("dff_tb.vcd");
			$dumpvars;
		end	
endmodule