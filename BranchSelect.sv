module BranchSelect(
  input        [1:0] BranchType,
  input        [7:0] CounterValue,
                     ImmediateValue,
  input              Carry,
                     Zero,

  // output logic [1:0] Jen,
  output logic [7:0] JumpValue);

always_comb begin
  JumpValue = 8'b1;
  case(BranchType)
    2'b01: begin // jnc
      JumpValue = Carry ? 1 : ImmediateValue;
    end
    2'b10: begin // jz
      JumpValue = Zero ? ImmediateValue : 1;
    end
    2'b11: begin // back
      JumpValue = CounterValue;
    end
  endcase
end 
  
endmodule
