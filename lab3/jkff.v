module jkff(clk,j,k,q);
input j,k,clk;
output q;
reg q;
initial
q=1'b0;
always@(posedge clk)
begin
if(j==1 & k==1) q<=~q;
else if(j==0 & k==0)q<=q;
else if(j==0 & k==1)q<=1'b0;
else q<=1'b1;
end
endmodule