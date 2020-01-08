module jkff(j,k,clk,q);
input j,k,clk;
output q;
reg q;
initial
q=1'b0;
always@(posedge clk)
begin
if(j==0 & k==0) q<=q;
else if(j==1 & k==1) q<=~q;
else if(j==0 & k==1) q<=1'b0;
else q<=1'b1;
end
endmodule

module counter(clk,Q);
input clk;
output [0:3] Q;
jkff f1(1,1,clk,Q[0]);
jkff f2(Q[0],Q[0],clk,Q[1]);
and a1(w1,Q[0],Q[1]);
jkff f3(w1,w1,clk,Q[2]);
and a2(w2,w1,Q[2]);
jkff f4(w2,w2,clk,Q[3]);

endmodule


module counter_tb;
reg clk;
wire [0:3] Q;
counter c(clk,Q);
initial 
begin
clk=0;
end
initial
		begin
			$dumpfile("sync_counter_4.vcd");
			$dumpvars;
		end	

always@(posedge clk)
begin
$monitor($time,"q4=%b|q3=%b|q2=%b|q1=%b",Q[3],Q[2],Q[1],Q[0]);
end

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
endmodule