module ProgCtr(
  input              Clk,
                     Reset,
//					 Jen,
  input        [1:0] BranchType,
  input        [7:0] Jump,
  output logic [7:0] PC);

// always_ff @(posedge Clk)
//   if(Reset) PC <= 'b0;
//   else if(Jen) PC <= PC + Jump;
//   else      PC <= PC + 6'd1;

  always_ff @(posedge Clk) begin
    if(Reset) PC = 'b0;
    else case(BranchType)
      2'b00: PC <= PC + 8'b1;
      2'b01: PC <= PC + Jump;
      2'b10: PC <= PC + Jump;
      2'b11: PC <= PC - Jump;
      // 2'b11: stall
    endcase
  end

endmodule
