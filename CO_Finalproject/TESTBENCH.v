`timescale 1ns/10ps
`include "PATTERN.v"
`include "SP.v"

module TESTBED();


wire clk, rst, in_valid;
wire [13:0] instruction;
wire busy, out_valid;
wire [7:0] out;


SP U_CORE(
			.clk(clk),
			.rst(rst),
			.in_valid(in_valid),
			.instruction(instruction),
			.busy(busy),
			.out_valid(out_valid),
			.out(out)		    
		  );		

PATTERN U_PATTERN(
			.clk(clk),
			.rst(rst),
			.in_valid(in_valid),
			.instruction(instruction),
			.busy(busy),
			.out_valid(out_valid),
			.out(out)
		  );	

endmodule
