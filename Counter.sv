module Counter (
	input logic rst,
	input logic incr,
	output logic [7:0] val);

	reg[7:0] Value;

	assign val = Value;

	always_ff @(posedge incr, posedge rst)
		if (rst)
			Value <= 0;
		else if (incr)
			Value <= Value + 1;
	
endmodule
