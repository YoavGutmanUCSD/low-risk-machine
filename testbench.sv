// Code your testbench here
// or browse Examples
`include "DUT.sv"
module testbench();

  bit clk, reset;
  wire done;
  parameter D = 6, A = 2;

  DUT t1(
    .Clk  (clk),
	.Reset(reset),
	.Done (done));
  
  always begin
    #5ns clk = 1;
	#5ns clk = 0;
  end

  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
    for(int i=0; i<16; i++)
      t1.RegisterFile.Core[i] = i; 
    #10ns reset = 1;
	#10ns reset = 0;
	#2000ns $stop;
  end

						
endmodule