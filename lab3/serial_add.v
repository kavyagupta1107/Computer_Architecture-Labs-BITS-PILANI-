module fa(x,y,z,s,c);
input x,y,z;
output s,c;
assign {c,s}=x+y+z;
endmodule

module dff(clk,d,q);
input clk,d;
output q;
reg q;
initial
q=0;
always@(posedge clk)
q<=d;
endmodule

module shift_reg_loadA(x,y,clk,s,S1);
input [0:3]x;
input clk,s;
output [0:3]y,S1;
reg [0:3]y,S1;
initial
assign y=x;

always@(posedge clk)
begin
y={s,y[0:2]};
S1=y;
end
endmodule

module shift_reg_loadB(x,y,clk);
input [0:3]x;
input clk;
output [0:3]y;
reg [0:3]y;
initial
assign y=x;
always@(posedge clk)
y<=y>>1;
endmodule

module mainmodule(A,B,clk,S1,C);
input [0:3]A,B;
input clk;
output C;
output [0:3]S1;
wire [0:3]A1,B1;
wire s;
shift_reg_loadA l1(A,A1,clk,s,S1);
shift_reg_loadB l2(B,B1,clk);
dff d1(clk,C,cin);
fa fa1(A1[3],B1[3],cin,s,C);
endmodule


module testbench;
reg [0:3]A,B;
reg clk;
wire [0:3]S;
wire C;

mainmodule m(A,B,clk,S,C);
always@(posedge clk)
$monitor($time,"|A=%b|B=%b|S=%b|C=%b",A,B,S,C);

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
#2 A=4'b1010;
   B=4'b0101;
#100 $finish;

end

endmodule













