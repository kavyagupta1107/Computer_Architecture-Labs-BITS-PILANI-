`include "ALU.v"
`include "register.v"
module PC(q,d,clk,reset);                                     //PC
input [4:0]d;
output [4:0]q;
input clk;
input reset;
reg [4:0]q;

always@(posedge clk or negedge reset)
begin
if(!reset) q<=5'b00000;
else q<=d;
end
endmodule

module InstructionMem(ins,PC);
input [4:0]PC;
output [31:0]ins;
wire [31:0] regs[31:0];

initial
begin
genvar i;
for(i=0;i<32;i=i+1)
begin
assign regs[i]=32'h00000000;          //starting the IM with all zeros.. instantiate with R format if you want to
end
end

assign ins=regs[PC];

endmodule

module datamem(readdata,address,writedata,memwrite);
input [4:0]address;
input [31:0]writedata;
input regwrite;
output [31:0]readdata;

wire [31:0]regs[31:0];
initial
begin
genvar i;
for(i=0;i<32;i=i+1)
begin
assign regs[i]=32'h00000000;          //starting the DM with all zeros
end
end

always@(memwrite or writedata)         //writing to mem
begin
if(memwrite) regs[address]=writedata;
end

assign readdata=regs[address];              //reading from mem
endmodule 

 
module sign_extend(out,in);             //sign extends from 16 bit to 32 bit
input [15:0]in;
output [31:0]out;
reg [31:0]out;
always@(in)
begin
out={{16{in[15]}},in[15:0]};
end
endmodule

module shifter(out,in);             //shifts 26->28
input [25:0]in;
output [27:0]out;
reg [27:0]out;
always@(in)
begin
out={in[25:0],2'b00};
end
endmodule

module adder(S,C,in1,in2);          //adder for pc+4
input [4:0]in1,in2;
assign {C,S}=in1+in2;
endmodule

module mux5_21(out,in1,in2,sel);             // 2:1 mux for 5 bit
input [4:0]in1,in2;
output [4:0]out;
input sel;
reg [4:0]out;
always@(sel or in1 or in2)
begin
if(sel==0) out=in1;
else out=in2;
end
endmodule

module mux32_21(out,in1,in2,sel);            //2:1 mux for 32 bit
input [31:0]in1,in2;
output [31:0]out;
input sel;
reg [31:0]out;
always@(sel or in1 or in2)
begin
if(sel==0) out=in1;
else out=in2;
end
endmodule

SCDataPath (ALU_output,PC,reset,clk);
input [31:0]PC;
input reset,clk;
output [31:0]ALU_output;
wire [31:0]instruction;
wire RegDst,ALUSrc,MemtoReg, RegWrite, MemRead,
MemWrite,Branch,ALUOp1,ALUOp2;
reg [4:0]rs,rt,rd;
wire [31:0]ReadData1,ReadData2;
wire [2:0]ALUcont;
wire [15:0] offset;
wire[31:0] source2,alusrcb;
wire cout;

InstructionMem i1(instruction,PC[4:0]);              //read instruction

 ANDarray a1(RegDst,ALUSrc, MemtoReg, RegWrite,
MemRead, MemWrite,Branch,ALUOp1,ALUOp2,instruction[31:26]);       //get control signals

always@(instruction)                 //get rs rt and rt
begin
rs=instruction[25:21];
rt=instruction[20:16];
rd=instruction[15:11];
end

RegFile r1(clk,reset,rs,rt,ALU_output,rd,RegWrite,ReadData1,ReadData2)           //read for rs and rt and write back to reg file

ALUcontrol a2({ALUOp1,ALUOp2},instruction[31:26],ALUcont);          //get alucontrol
 
sign_extend s1(source2,offset);                                      //gets sign extended offset
mux32_21 m1(alusrcb,ReadData2,source2,ALUSrc);                        //choosing 2nd input to alu
  
 
ALU(ReadData1,alusrcb,ALUcont[2],ALUcont[2],ALUcont[1:0],ALU_output,cout);         //alu operation
endmodule;
 



