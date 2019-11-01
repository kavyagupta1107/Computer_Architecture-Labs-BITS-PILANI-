`include "comp.v"
module testbench;
	reg [3:0] A,B;
	wire signA,signB,altb,agtb,aeqb;
	comparator c(signA,signB,altb,agtb,aeqb,A,B);
	initial
		begin
			$monitor($time," a=%b,b=%b,altb=%b,agtb=%b,aeqb=%b",A,B,altb,agtb,aeqb);
			#0 A=5;B=5;
			#4 A=-8;B=3;
			#4 A=1;B=-2;
			#2 $finish;
		end
endmodule