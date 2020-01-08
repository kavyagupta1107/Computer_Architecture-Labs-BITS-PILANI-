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

module mux41_32(out,in1,in2,in3,in4,sel);
input [0:31]in1,in2,in3,in4;
input [0:1]sel;
output [0:31]out;
reg [0:31]out;
always@(sel or in1 or in2 or in3 or in4)
begin
if(sel==2'b00) out=in1;
else if(sel==2'b01)out=in2;
else if(sel==2'b10)out=in3;
else out=in4;
end
endmodule

module and_32(out,in1,in2);
input [0:31]in1,in2;
output [0:31]out;

assign {out}=in1 & in2;
endmodule

module or_32(out,in1,in2);
input [0:31]in1,in2;
output [0:31]out;

assign {out}=in1 | in2;
endmodule

module fa_32(sum,c,in1,in2,cin);
input [0:31]in1,in2;
input cin;
output c;
output [0:31]sum;
assign {c,sum}=in1+in2+cin;
endmodule

module ALU(a,b,Bi,cin,Op,res,cout);
input [0:31]a,b;
input Bi,cin;
input [0:1]Op;
output [0:31]res;
output cout;

wire [0:31]not_b,f_b,ar,oor,sr;
assign not_b=~b;


mux21_32 m1(f_b,b,not_b,Bi);
and_32 a1(ar,a,f_b);
or_32 o1(oor,a,f_b);
fa_32 f1(sr,cout,a,f_b,Bi);

mux41_32 m2(res,ar,oor,sr,,Op);
endmodule

module tbALU;
reg Binvert, Carryin;
reg [1:0] Operation;
reg [31:0] a,b;
wire [31:0] Result;
wire CarryOut;
ALU a1(a,b,Binvert,Carryin,Operation,Result,CarryOut);
initial
begin
$monitor($time,"|a=%b,b=%b,op=%b,res=%b,c=%b",a,b,Operation,Result,CarryOut);
a=32'ha5a5a5a5;
b=32'h5a5a5a5a;
Operation=2'b00;
Binvert=1'b0;
Carryin=1'b0; //must perform AND resulting in zero
#100 Operation=2'b01; //OR
#100 Operation=2'b10; //ADD
#100 Binvert=1'b1;//SUB
#200 $finish;
end
endmodule


module ANDarray (RegDst,ALUSrc, MemtoReg, RegWrite,
MemRead, MemWrite,Branch,ALUOp1,ALUOp2,Op);
input [5:0] Op;
output RegDst,ALUSrc,MemtoReg, RegWrite, MemRead,
MemWrite,Branch,ALUOp1,ALUOp2;
wire Rformat, lw,sw,beq;
assign Rformat= (~Op[0])& (~Op[1])& (~Op[2])& (~Op[3])&(~Op[4])& (~Op[5]);
assign lw=(Op[0])& (Op[1])& (~Op[2])& (~Op[3])&(~Op[4])& (Op[5]);
assign sw=(Op[0])& (Op[1])& (~Op[2])& (Op[3])&(~Op[4])& (Op[5]); 
assign beq=(~Op[0])& (~Op[1])& (Op[2])& (~Op[3])&(~Op[4])& (~Op[5]); 

assign RegDst=Rformat;
assign ALUSrc=lw |  sw;
assign MemtoReg=lw;
assign RegWrite=Rformat|lw;
assign MemRead=lw;
assign MemWrite=sw;
assign Branch=beq;
assign ALUOp1=Rformat;
assign ALUOp2=beq;
endmodule



module ALUcontrol(ALUop,F,op);
input [1:0]ALUop;
input [5:0]F;
output [2:0]op;
assign op[2]=(F[1]&ALuop[1])| ALUop[0];
assign op[1]= (~F[2]) | (~ALUop[1]);
assign op[0]=(F[0]|F[3])& ALuop[1];
endmodule














