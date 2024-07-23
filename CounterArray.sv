module CounterArray (
	input logic rst,
	input logic [3:0] select,
	input logic clk,
	input logic rstAll,
  output logic [7:0] Value);

  wire[7:0] CounterValues[16];

	// from stackoverflow
	generate
		genvar i;
      for (i=0; i<16; i++) begin
			Counter i_cntr(
				.rst((rst == i) || rstAll),
				.incr(clk),
              .val(CounterValues[i]));
		end

	endgenerate

	assign Value = CounterValues[select];


endmodule
