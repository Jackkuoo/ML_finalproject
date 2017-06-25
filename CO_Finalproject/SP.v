`timescale 1ns/10ps
module SP(
  clk,
  rst,
  in_valid,
  instruction,
  busy,
  out_valid,
  out
);
input clk;
input rst;
input in_valid;
input [13:0] instruction;

reg  [7:0]  r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
output reg busy;
output reg out_valid;
output reg [7:0] out;

wire [1:0]op;
wire [7:0]rs_00,rs_01,rs_10,rs_11,rt_00,rt_01;
wire [3:0]rd_00,rd_01;

assign op=instruction [13:12];

assign rs_00=(instruction[11:8]==4'd0 ) ? r0 :
			 (instruction[11:8]==4'd1 ) ? r1 :
             (instruction[11:8]==4'd2 ) ? r2 :
             (instruction[11:8]==4'd3 ) ? r3 :
             (instruction[11:8]==4'd4 ) ? r4 :
             (instruction[11:8]==4'd5 ) ? r5 :
             (instruction[11:8]==4'd6 ) ? r6 :
             (instruction[11:8]==4'd7 ) ? r7 :
             (instruction[11:8]==4'd8 ) ? r8 :
             (instruction[11:8]==4'd9 ) ? r9 :
             (instruction[11:8]==4'd10) ? r10:
             (instruction[11:8]==4'd11) ? r11:
             (instruction[11:8]==4'd12) ? r12:
             (instruction[11:8]==4'd13) ? r13:
             (instruction[11:8]==4'd14) ? r14:r15;
			                              
assign rs_01=(instruction[11:8]==4'd0 ) ? r0 :
			 (instruction[11:8]==4'd1 ) ? r1 :
             (instruction[11:8]==4'd2 ) ? r2 :
             (instruction[11:8]==4'd3 ) ? r3 :
             (instruction[11:8]==4'd4 ) ? r4 :
             (instruction[11:8]==4'd5 ) ? r5 :
             (instruction[11:8]==4'd6 ) ? r6 :
             (instruction[11:8]==4'd7 ) ? r7 :
             (instruction[11:8]==4'd8 ) ? r8 :
             (instruction[11:8]==4'd9 ) ? r9 :
             (instruction[11:8]==4'd10) ? r10:
             (instruction[11:8]==4'd11) ? r11:
             (instruction[11:8]==4'd12) ? r12:
             (instruction[11:8]==4'd13) ? r13:
             (instruction[11:8]==4'd14) ? r14:r15;

assign rs_10=(instruction[11:8]==4'd0 ) ? r0 :
		     (instruction[11:8]==4'd1 ) ? r1 :
             (instruction[11:8]==4'd2 ) ? r2 :
             (instruction[11:8]==4'd3 ) ? r3 :
             (instruction[11:8]==4'd4 ) ? r4 :
             (instruction[11:8]==4'd5 ) ? r5 :
             (instruction[11:8]==4'd6 ) ? r6 :
             (instruction[11:8]==4'd7 ) ? r7 :
             (instruction[11:8]==4'd8 ) ? r8 :
             (instruction[11:8]==4'd9 ) ? r9 :
             (instruction[11:8]==4'd10) ? r10:
             (instruction[11:8]==4'd11) ? r11:
             (instruction[11:8]==4'd12) ? r12:
             (instruction[11:8]==4'd13) ? r13:
             (instruction[11:8]==4'd14) ? r14:r15;
			                              
assign rs_11=(instruction[11:8]==4'd0 ) ? r0 :
			 (instruction[11:8]==4'd1 ) ? r1 :
             (instruction[11:8]==4'd2 ) ? r2 :
             (instruction[11:8]==4'd3 ) ? r3 :
             (instruction[11:8]==4'd4 ) ? r4 :
             (instruction[11:8]==4'd5 ) ? r5 :
             (instruction[11:8]==4'd6 ) ? r6 :
             (instruction[11:8]==4'd7 ) ? r7 :
             (instruction[11:8]==4'd8 ) ? r8 :
             (instruction[11:8]==4'd9 ) ? r9 :
             (instruction[11:8]==4'd10) ? r10:
             (instruction[11:8]==4'd11) ? r11:
             (instruction[11:8]==4'd12) ? r12:
             (instruction[11:8]==4'd13) ? r13:
             (instruction[11:8]==4'd14) ? r14:r15;
			 
assign rt_00=(instruction[7:4]==4'd0 ) ? r0 :
		 	 (instruction[7:4]==4'd1 ) ? r1 :
             (instruction[7:4]==4'd2 ) ? r2 :
             (instruction[7:4]==4'd3 ) ? r3 :
             (instruction[7:4]==4'd4 ) ? r4 :
             (instruction[7:4]==4'd5 ) ? r5 :
             (instruction[7:4]==4'd6 ) ? r6 :
             (instruction[7:4]==4'd7 ) ? r7 :
             (instruction[7:4]==4'd8 ) ? r8 :
             (instruction[7:4]==4'd9 ) ? r9 :
             (instruction[7:4]==4'd10) ? r10:
             (instruction[7:4]==4'd11) ? r11:
             (instruction[7:4]==4'd12) ? r12:
             (instruction[7:4]==4'd13) ? r13:
             (instruction[7:4]==4'd14) ? r14:r15;
			                             
assign rt_01=(instruction[7:4]==4'd0 ) ? r0 :
			 (instruction[7:4]==4'd1 ) ? r1 :
             (instruction[7:4]==4'd2 ) ? r2 :
             (instruction[7:4]==4'd3 ) ? r3 :
             (instruction[7:4]==4'd4 ) ? r4 :
             (instruction[7:4]==4'd5 ) ? r5 :
             (instruction[7:4]==4'd6 ) ? r6 :
             (instruction[7:4]==4'd7 ) ? r7 :
             (instruction[7:4]==4'd8 ) ? r8 :
             (instruction[7:4]==4'd9 ) ? r9 :
             (instruction[7:4]==4'd10) ? r10:
             (instruction[7:4]==4'd11) ? r11:
             (instruction[7:4]==4'd12) ? r12:
             (instruction[7:4]==4'd13) ? r13:
             (instruction[7:4]==4'd14) ? r14:r15;

always @(posedge clk) 
begin
	if(rst == 1'b1)begin
	r0<=0;
	r1<=0;
	r2<=0;
	r3<=0;
	r4<=0;
	r5<=0;
	r6<=0;
	r7<=0;
	r8<=0;
	r9<=0;
	r10<=0;
	r11<=0;
	r12<=0;
	r13<=0;
	r14<=0;
	r15<=0;
	out_valid<=0;
	out<=0;
	end
	else if(rst == 1'b0)begin
	if(in_valid == 1'b1)begin
		busy<=1;
		if(op == 2'b00)begin //and
			out_valid <= 1'b1;
			out <= rs_00 + rt_00;
			if(instruction[3:0] == 4'd0)begin
				r0 <= rs_00 + rt_00;
			end
			else if(instruction[3:0] == 4'd1)begin
				r1 <= rs_00 + rt_00;
			end
			else if(instruction[3:0] == 4'd2)begin
				r2 <= rs_00 + rt_00;
			end
			else if(instruction[3:0] == 4'd3)begin
				r3 <= rs_00 + rt_00;
			end 
			else if(instruction[3:0] == 4'd4)begin
				r4 <= rs_00 + rt_00;
			end
			else if(instruction[3:0] == 4'd5)begin
				r5 <= rs_00 + rt_00;
			end
			else if(instruction[3:0] == 4'd6)begin
				r6 <= rs_00 + rt_00;
			end
			else if(instruction[3:0] == 4'd7)begin
				r7 <= rs_00 + rt_00;
			end
			else if(instruction[3:0] == 4'd8)begin
				r8 <= rs_00 + rt_00;
			end
			else if(instruction[3:0] == 4'd9)begin
				r9 <= rs_00 + rt_00;
			end
			else if(instruction[3:0] == 4'd10)begin
				r10 <= rs_00 + rt_00;
			end
			else if(instruction[3:0] == 4'd11)begin
				r11 <= rs_00 + rt_00;
			end
			else if(instruction[3:0] == 4'd12)begin
				r12 <= rs_00 + rt_00;
			end
			else if(instruction[3:0] == 4'd13)begin
				r13 <= rs_00 + rt_00;
			end
			else if(instruction[3:0] == 4'd14)begin
				r14 <= rs_00 + rt_00;
			end
			else if(instruction[3:0] == 4'd15)begin
				r15 <= rs_00 + rt_00;
			end
		end 
		else if(op == 2'b01)begin //or
			out_valid <= 1'b1;
			out <= rs_00 * rt_00;
			if(instruction[3:0] == 4'd0)begin
				r0 <= rs_00 * rt_00;
			end
			else if(instruction[3:0] == 4'd1)begin
				r1 <= rs_00 * rt_00;
			end
			else if(instruction[3:0] == 4'd2)begin
				r2 <= rs_00 * rt_00;
			end
			else if(instruction[3:0] == 4'd3)begin
				r3 <= rs_00 * rt_00;
			end 
			else if(instruction[3:0] == 4'd4)begin
				r4 <= rs_00 * rt_00;
			end
			else if(instruction[3:0] == 4'd5)begin
				r5 <= rs_00 * rt_00;
			end
			else if(instruction[3:0] == 4'd6)begin
				r6 <= rs_00 * rt_00;
			end
			else if(instruction[3:0] == 4'd7)begin
				r7 <= rs_00 * rt_00;
			end
			else if(instruction[3:0] == 4'd8)begin
				r8 <= rs_00 * rt_00;
			end
			else if(instruction[3:0] == 4'd9)begin
				r9 <= rs_00 * rt_00;
			end
			else if(instruction[3:0] == 4'd10)begin
				r10 <= rs_00 * rt_00;
			end
			else if(instruction[3:0] == 4'd11)begin
				r11 <= rs_00 * rt_00;
			end
			else if(instruction[3:0] == 4'd12)begin
				r12 <= rs_00 * rt_00;
			end
			else if(instruction[3:0] == 4'd13)begin
				r13 <= rs_00 * rt_00;
			end
			else if(instruction[3:0] == 4'd14)begin
				r14 <= rs_00 * rt_00;
			end
			else if(instruction[3:0] == 4'd15)begin
				r15 <= rs_00 * rt_00;
			end
		end
		else if(op == 2'b10)begin //overwrite
			out_valid <=1'b1;
			out <= instruction[7:0];
			if(instruction[7:0] == 8'd0 )begin
				r0 <= instruction[7:0];
			end
			else if(instruction[7:0] == 8'd1 )begin
				r1 <= instruction[7:0];
			end
			else if(instruction[7:0] == 8'd2 )begin
				r2 <= instruction[7:0];
			end
			else if(instruction[7:0] == 8'd3 )begin
				r3 <= instruction[7:0];
			end
			else if(instruction[7:0] == 8'd4 )begin
				r4 <= instruction[7:0];
			end
			else if(instruction[7:0] == 8'd5 )begin
				r5 <= instruction[7:0];
			end
			else if(instruction[7:0] == 8'd6 )begin
				r6 <= instruction[7:0];
			end
			else if(instruction[7:0] == 8'd7 )begin
				r7 <= instruction[7:0];
			end
			else if(instruction[7:0] == 8'd8 )begin
				r8 <= instruction[7:0];
				out <= instruction[7:0];
			end
			else if(instruction[7:0] == 8'd9 )begin
				r9 <= instruction[7:0];
			end
			else if(instruction[7:0] == 8'd10 )begin
				r10 <= instruction[7:0];
			end
			else if(instruction[7:0] == 8'd11 )begin
				r11 <= instruction[7:0];
			end
			else if(instruction[7:0] == 8'd12 )begin
				r12 <= instruction[7:0];
			end
			else if(instruction[7:0] == 8'd13 )begin
				r13 <= instruction[7:0];
			end
			else if(instruction[7:0] == 8'd14 )begin
				r14 <= instruction[7:0];
			end
			else if(instruction[7:0] == 8'd15 )begin
				r15 <= instruction[7:0];
			end
		end
		else if(op == 2'b11)begin //read
			out_valid <= 1'b1;
			out<=rs_11;
		end
	end
	else if(in_valid == 1'b0)begin
		busy <= 0;
		out_valid <= 0;
	end
	end 
end	
 
 
endmodule
