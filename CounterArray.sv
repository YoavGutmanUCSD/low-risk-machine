module CounterArray (
	input logic rst,
	input logic [3:0] select,
	input logic clk,
	input logic rstAll,
	output logic Value);

	wire[3:0][7:0] CounterValues;

	// from stackoverflow
	generate
		genvar i;
		for (i=0; i<15; i++) begin
			Counter i_cntr(
				.rst((rst == i) || rstAll),
				.incr(clk),
				.val(CounterValues[select]));
		end

	endgenerate

	assign Value = CounterValues[select];


endmodule
