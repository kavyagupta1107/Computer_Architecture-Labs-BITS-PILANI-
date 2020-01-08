module mux21_32(out,in1,in2,sel);
input [0:31]in1,in2;
input sel;
output [0:31]out;
reg [0:31]out;
always@(in1 or in2 or sel)
begin
if(sel==0) out=in1;
else out=in2;


end
endmodule


module testbench;
reg [0:31]in1,in2;
reg sel;
wire [0:31]out;
mux21_32 m(out,in1,in2,sel);
initial
begin
$monitor ($time,"|in1=%b|in2=%b|sel=%b|out=%b",in1,in2,sel,out);
in1=32'b11111111111111111111111111111111;
in2=32'b00000000000000000000000000000000;
#2 sel=1'b0;
#5 sel=1'b1;
#10 sel =1'b0;
end
endmodule