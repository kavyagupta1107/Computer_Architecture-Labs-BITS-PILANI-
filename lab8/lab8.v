module encoder(in,out);
input [7:0]in;
output [2:0]out;

reg [2:0]out;
integer i;
always@(in)
begin
for(i=0;i<8;i=i+1)
begin
if(in[i]==1) out=i;
end

end
endmodule

module dff_4bit(q,d,reset,clk);           //4 bit register
input clk,reset;
input [3:0]d;
output [3:0]q;
reg [3:0]q;
always@(posedge clk or negedge reset)
begin
if(!reset) q<=4'b0000;
else q<=d;
end
endmodule

module dff_3bit(q,d,reset,clk);           //3 bit register
input clk,reset;
input [2:0]d;
output [2:0]q;
reg [2:0]q;
always@(posedge clk or negedge reset)
begin
if(!reset) q<=3'b000;
else q<=d;
end
endmodule

module ALU(A,B,op,out);
input [3:0]A,B;
input [2:0]op;
output [3:0]out;
reg [3:0]out;
reg [4:0]case_k;
always@(A or B or op)
begin
if(op==3'b000) begin case_k=A+B;out=case_k[3:0]; end
else if(op==3'b001) begin case_k=A-B;out=case_k[3:0]; end
else if(op==3'b010) out=A^B;
else if(op==3'b011) out=A|B;
else if(op==3'b100) out=A&B;
else if(op==3'b101) out=~(A|B);
else if(op==3'b110) out=~(A&B);
else out=~(A^B);
end
endmodule

module parity_gen(in,out);
input [3:0]in;
output out;
assign out=~(in[3]^in[2]^in[1]^in[0]);
endmodule

module main(reset,clk,en_in,A,B,parity);
input clk,reset;
input [7:0]en_in;
input [3:0]A,B;
output parity;

wire [2:0]en_out;
wire [3:0] src1,src2;
wire[2:0]op;
wire [3:0]ALU_out;
wire [3:0]final_out;
//wire cout;
encoder e1(en_in,en_out);
dff_4bit d1(src1,A,reset,clk);
dff_4bit d2(src2,B,reset,clk);
dff_3bit d3(op,en_out,reset,clk); 
ALU a1(src1,src2,op,ALU_out);
dff_4bit d4(final_out,ALU_out,reset,clk);


parity_gen p1(final_out,parity);
endmodule

module testbench;
reg [3:0]A,B;
reg clk,reset;
reg [7:0]en_in;
wire parity;
main m1(reset,clk,en_in,A,B,parity);

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
$monitor ($time,"A=%b,B=%b,en_in=%b,parity=%b",A,B,en_in,parity);

initial
begin
reset=1'b0;
#10 reset=1'b1; A=4'b1111;B=4'b0001;en_in=8'b00000100;
#10 reset=1'b0;
#10 reset =1'b1;  A=4'b1010;B=4'b0011;en_in=8'b00000001;
#10 $finish;
end

endmodule







