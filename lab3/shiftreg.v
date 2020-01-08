module shiftreg(clk,in,en,Q);
input clk,in,en;
output [0:3]Q;
reg [0:3]Q;

initial 
Q=4'b0101;
always@(posedge clk)
begin 
if(en)
begin
Q[0]<=in;
Q[1]<=Q[0];
Q[2]<=Q[1];
Q[3]<=Q[2];


end
end
endmodule

module shiftregtest;
reg EN,in , CLK;
wire [3:0] Q;
//reg [n-1:0] Q;
shiftreg shreg(CLK,in,EN,Q);
initial
begin
CLK=0;
end
always
#2 CLK=~CLK;
initial
$monitor($time,"EN=%b in= %b Q=%b\n",EN,in,Q);
initial
begin
in=0;EN=0;
#4 in=1;EN=1;
#4 in=1;EN=0;
#4 in=0;EN=1;
#5 $finish;
end
endmodule