module OPLUT(
  input logic[3:0] InstructionOpcode,
  output logic[3:0] ALUOp);

  always_comb begin
    ALUOp = 4'b0000;
    case(InstructionOpcode)
      4'b0100: ALUOp = 4'b0001; // add
      4'b0101: ALUOp = 4'b0010; // sub
      4'b0110: ALUOp = 4'b0110; // not
      4'b0111: ALUOp = 4'b0011; // xor
      4'b1000: ALUOp = 4'b0100; // lsh
      4'b1001: ALUOp = 4'b0101; // rsh
    endcase
  end

endmodule
