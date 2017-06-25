`timescale 1ns/10ps


module PATTERN(
  clk,
  rst,
  in_valid,
  instruction,
  busy,
  out_valid,
  out
);

output reg clk;
output reg rst;
output reg in_valid;
output reg [13:0] instruction;
input busy;
input out_valid;
input [7:0] out;
reg [7:0] ans;
reg [1:0] err;
reg [3:0] ins_num;

//
parameter  CYCLE = 4;			  
always  #(CYCLE/2.0)  clk=~clk;   

integer  error;
always@(posedge clk)begin
    if(out_valid)begin
        case(ins_num)
            4'd1: begin
                if(out===8'dx) begin
                    fail_print;
                end
                else if(out!==ans) begin
                    $display("1th pattern error, the correct out = 2'b%b\n\n",ans);
                    $display("                   Your answer     = 2'b%b\n\n",out);
                    $finish();
                end
                else
                    $display("1th pattern pass\n\n");
            end
            4'd2: begin
                if(out===8'dx) begin
                    fail_print;
                end
                else if(out!==ans) begin
                    $display("2th pattern error, the correct out = 2'b%b\n\n",ans);
                    $display("                   Your answer     = 2'b%b\n\n",out);
                    $finish();
                end
                else
                    $display("2th pattern pass\n\n");
            end
            4'd3: begin
                if(out===8'dx) begin
                    fail_print;
                end
                else if(out!==ans) begin
                    $display("3th pattern error, the correct out = 2'b%b\n\n",ans);
                    $display("                   Your answer     = 2'b%b\n\n",out);
                    $finish();
                end
                else
                    $display("3th pattern pass\n\n");
            end
            4'd4: begin
                if(out===8'dx) begin
                    fail_print;
                end
                else if(out!==ans) begin
                    $display("4th pattern error, the correct out = 2'b%b\n\n",ans);
                    $display("                   Your answer     = 2'b%b\n\n",out);
                    $finish();
                end
                else
                    $display("4th pattern pass\n\n");
            end
            4'd5: begin
                if(out===8'dx) begin
                    fail_print;
                end
                else if(out!==ans) begin
                    $display("5th pattern error, the correct out = 2'b%b\n\n",ans);
                    $display("                   Your answer     = 2'b%b\n\n",out);
                    $finish();
                end
                else
                    $display("5th pattern pass\n\n");
            end
            4'd6: begin
                if(out===8'dx) begin
                    fail_print;
                end
                else if(out!==ans) begin
                    $display("6th pattern error, the correct out = 2'b%b\n\n",ans);
                    $display("                   Your answer     = 2'b%b\n\n",out);
                    $finish();
                end
                else
                    $display("6th pattern pass\n\n");
            end
        endcase  
    end
end
always@(negedge clk)begin
    if(rst)
        ins_num<=4'b0;
    else if(busy)
        ins_num<=ins_num+4'b1;
    else
        ins_num<=ins_num;
end
always@(*)begin
    case(ins_num)
        4'd1: ans = 8'b0000_0001;
        4'd2: ans = 8'b0000_0010;
        4'd3: ans = 8'b0000_0011;
        4'd4: ans = 8'b0000_0011;
        4'd5: ans = 8'b0000_0010;
        4'd6: ans = 8'b0000_0010;
        default: ans = 8'd0;
    endcase 
end

initial
begin
	error = 0;
    clk = 0;                      
	rst  = 0;
	in_valid = 0;
	instruction =0;
		
	@(negedge clk)  rst = 1'b1;
	@(negedge clk)  rst = 1'b0;
    if(out===8'dx || busy===1'dx || out_valid===1'dx) 
        fail_print;
		
	else begin	
        @(negedge clk);
        while(busy==1'b1) begin
          @(negedge clk);
        end
        
    // #1 i/p 	
          instruction = 14'b10_0001_0000_0001;  // O.R. R1, #1
          in_valid    =  1'b1;
            
         @(negedge clk);
          instruction = 14'd0;
          in_valid    =  1'b0;
          
         while(busy==1'b1)          
           @(negedge clk);
         
          
            
    // #2 i/p 
          instruction = 14'b10_0010_0000_0010;  // O.R R2, #2
          in_valid    =  1'b1;
            
         @(negedge clk);
          instruction = 14'd0;
          in_valid    =  1'b0;
          
         while(busy==1'b1)          
           @(negedge clk);

    // #3 i/p 
          instruction = 14'b00_0001_0010_0011;  // R3 = R1 + R2
          in_valid    =  1'b1;
            
         @(negedge clk);
          instruction = 14'd0;
          in_valid    =  1'b0;
          
         while(busy==1'b1)          
           @(negedge clk);
         
         
    // #4 i/p 
          instruction = 14'b11_0011_0000_0000;  // Read R3
          in_valid    =  1'b1;
            
         @(negedge clk);
          instruction = 14'd0;
          in_valid    =  1'b0;
          
         while(busy==1'b1)          
           @(negedge clk);

    // #5 i/p 
          instruction = 14'b01_0001_0010_0100;  // R4 = R1 * R2
          in_valid    =  1'b1;
            
         @(negedge clk);
          instruction = 14'd0;
          in_valid    =  1'b0;
          
         while(busy==1'b1)          
           @(negedge clk);

         
    // #6 i/p 
          instruction = 14'b11_0100_0000_0000;  // Read R4
          in_valid    =  1'b1;
            
         @(negedge clk);
          instruction = 14'd0;
          in_valid    =  1'b0;
          
         while(busy==1'b1)          
           @(negedge clk);



        if(error==0) pass_print;

        
         
        repeat(5) @(negedge clk);
          
        $finish();		
        end
end




task pass_print ;
begin
    $display(" You have passed this pattern!!");	
	$display("   ******---------******   ");		
	$display("   **                 **   ");
	$display("   ** congratulation! **   ");
	$display("   **                 **   ");	
	$display("   ******---------******   ");
    $display("      ");
    $display("      ");
    $finish();	
end	
endtask


task fail_print ;
begin

    $display("  FFFFFFFFFFFFFF         AAA          LLL               LLL          " );
    $display("  FFFFFFFFFFFFFF        AA AA         LLL               LLL          " );
    $display("  FFF                  AA   AA        LLL               LLL          " );
    $display("  FFFFFFFFFFFFFF      AA     AA       LLL               LLL          " );
    $display("  FFFFFFFFFFFFFF     AAAAAAAAAAA      LLL               LLL          " );
    $display("  FFF               AAAAAAAAAAAAA     LLL               LLL          " );
    $display("  FFF               AA         AA     LLL               LLL          " );
    $display("  FFF               AA         AA     LLLLLLLLLLLLL     LLLLLLLLLLLLL" );
    $display("  FFF               AA         AA     LLLLLLLLLLLLL     LLLLLLLLLLLLL" );
    $display(" You are fail !! OUTPUT CAN NOT BE UNKNOEN AFTER \"RESET\"(red line)");	
    $display(" Your OUTPUT DATA SHOULD BE ZERO ");
	$display("   ******---------******   ");		
	$display("   ** So Sad QQ **   ");	
	$display("   ******---------******   ");
    $display("      ");
    $display("      ");
    $finish;
end	
endtask
endmodule
