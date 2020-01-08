module reg_32bit(q,d,clk,rst);
input [0:31]d;
input clk,rst;
output [0:31]q;
reg [0:31]q;

always@(posedge clk or negedge rst)
begin
if(!rst) q<=32'b00000000000000000000000000000000;
else q<=d;
end
endmodule
/*
module tb32reg;//testbench for 32 bit register
reg [31:0] d;
reg clk,reset;
wire [31:0] q;
reg_32bit R(q,d,clk,reset);
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
always@(posedge clk)
$monitor($time,"rst=%b,clk=%b,d=%b,q=%b",reset,clk,d,q);
initial
begin
clk= 1'b1;
reset=1'b0;//reset the register
#20 reset=1'b1;
#20 d=32'hAFAFAFAF;
#200 $finish;
end
endmodule */

module mux4_1(re,q1,q2,q3,q4,sel);
input [0:31]q1,q2,q3,q4;
input [1:0]sel;
output [0:31]re;
reg [0:31]re;
always@(sel or q1 or q2 or q3 or q4)
begin
if(sel==2'b00) re=q1;
else if(sel==2'b01)re=q2;
else if(sel==2'b10)re=q3;
else re=q4;
end
endmodule

module decoder2_4(register,reg_no);
input [1:0]reg_no;
output [3:0]register;
wire n1,n2;
not z1(n1,reg_no[0]);
not z2(n2,reg_no[1]);

and z3(register[0],n1,n2);
and z4(register[1],reg_no[0],n2);
and z5(register[2],n1,reg_no[1]);
and z6(register[3],reg_no[0],reg_no[1]);
endmodule

module RegFile(clk,reset,ReadReg1,ReadReg2,WriteData,WriteReg,RegWrite,ReadData1,ReadData2);
//readreg1=sel1 readreg2=sel2 readdata1 readdat2 regwrite & clk & out of decoder, writereg=reg_no  writedata
input clk,reset,RegWrite;
input [1:0]ReadReg1,ReadReg2;
input [31:0] WriteData;
input [1:0]WriteReg;
output [31:0]ReadData1,ReadData2;

wire [3:0] decoder_out;
decoder2_4 y1(decoder_out,WriteReg);
wire clk0,clk1,clk2,clk3;
wire [31:0] q0,q1,q2,q3;
/*
initial
begin
reg_32bit rr1(q0,WriteData,clk,0);
reg_32bit rr2(q1,WriteData,clk,0);
reg_32bit rr3(q2,WriteData,clk,0);
reg_32bit rr4(q3,WriteData,clk,0);

end*/

and a1(clk0,clk,RegWrite,decoder_out[0]);
and a2(clk1,clk,RegWrite,decoder_out[1]);
and a3(clk2,clk,RegWrite,decoder_out[2]);
and a4(clk3,clk,RegWrite,decoder_out[3]);

reg_32bit r1(q0,WriteData,clk0,reset);
reg_32bit r2(q1,WriteData,clk1,reset);
reg_32bit r3(q2,WriteData,clk2,reset);
reg_32bit r4(q3,WriteData,clk3,reset);

mux4_1 m1(ReadData1,q0,q1,q2,q3,ReadReg1);
mux4_1 m2(ReadData2,q0,q1,q2,q3,ReadReg2);

endmodule


module testbench;//how do i reset the resgisters initially????
reg clk,reset,RegWrite;
reg [31:0] WriteData;
reg [1:0]WriteReg,ReadReg1,ReadReg2;
wire [31:0]ReadData1,ReadData2;
RegFile RF1(clk,reset,ReadReg1,ReadReg2,WriteData,WriteReg,RegWrite,ReadData1,ReadData2);

initial
begin
forever
begin
clk=0;
#10
clk=1;
#10
clk=0;
end
end

always@(posedge clk)
$monitor($time,"write=%b,writeto=%b,Written=%b,sel1=%b,sel2=%b,rd1=%b,rd2=%b",RegWrite,WriteReg,WriteData,ReadReg1,ReadReg2,ReadData1,ReadData2);

initial 
begin

RegWrite=0;
end

initial
begin
reset=0;
#5 reset=1;
#10 ReadReg1=2'b00;ReadReg2=2'b01;RegWrite=0;//reading initially
#20 RegWrite=1;WriteReg=2'b00;WriteData=32'hAAAAAAAA;ReadReg1=2'b00;ReadReg2=2'b01;//writing to 00

#50 WriteReg=2'b01;WriteData=32'h0000AAAA;ReadReg1=2'b00;ReadReg2=2'b01;//writing to 01
#20 ReadReg1=2'b00;ReadReg2=2'b01;RegWrite=0;//reading after updating
#20 $finish;


end

endmodule











