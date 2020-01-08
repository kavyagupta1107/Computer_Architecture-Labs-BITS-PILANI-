module mealy(clk,rst,in,out);
	input clk,in,rst;
	output out;
	reg out;
	reg [1:0]state;
	always@(posedge clk or posedge rst)
		begin
			if(rst)
				begin
					state<=2'b00;
					out<=1'b0;
				end
			else 
				begin
					case(state)
							2'b00:begin
							if(in) begin
							state<=2'b01;
							out=1'b0;
							end
							else begin
							state<=2'b10;
							out=1'b0;
							end
							end
							2'b01:begin
							if(in) begin
							state<=2'b00;
							out=1'b1;
							end
							else begin
							state<=2'b10;
							out=1'b0;
							end
							end
							2'b10:begin
							if(in) begin
							state<=2'b01;
							out=1'b0;
							end
							else begin
							state<=2'b00;
							out=1'b1;
							end
							end
							default:begin
							state<=2'b00;
							out<=1'b0;
							end
							
				
				
				
					endcase
				end
			
		end
endmodule