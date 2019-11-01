`include "lab12.v"
module testbench;
	reg a,b,s;
	wire f;
	mux_21_gate mux_gate (f,a,b,s);
	initial
		begin
			$dumpfile("lab15.vcd");
			$dumpvars;
		end	
	
	
	initial
		begin
			$monitor($time,"a=%b,b=%b,s=%b,f=%b",a,b,s,f);
			#0 a=1'b0;b=1'b1;
			#2 s=1'b1;
			#5 s=1'b0;
			#10 a=1'b1;b=1'b0;
			#15 s=1'b1;
			#20 s=1'b0;
			#100 $finish;
		end
endmodule