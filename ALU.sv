module ALU(
  input logic[3:0] op,
  input logic CarryIn,
  input logic ZeroIn,
  input logic[7:0] AccIn,
                   OperandIn,
  output logic[7:0] Rslt,
  output logic      Zero,
                    Carry);

always_comb begin
  Rslt = 8'b0;
  SCo  = 8'b0;
  Carry = CarryIn;
  Zero = !Rslt;
  case(op)
    4'b0100: {Carry, Rslt} = AccIn + OperandIn; // add
    4'b0101: {Carry, Rslt} = AccIn - OperandIn; // sub
    4'b0111: Rslt          = AccIn ^ OperandIn; // bitwise XOR
    4'b1000: begin
      {Carry, Rslt} = {AccIn, CarryIn};  // left shift by 1
      // Zero = ZeroIn && !Rslt;
    end
    4'b1001: begin // right shift by 1
      {Rslt, Carry} = {CarryIn, AccIn};
      // Zero = ZeroIn && !Rslt;
    end
    4'b0110: Rslt = ~AccIn; // bitwise not in place
    default: begin
      Rslt = AccIn;                     // nop
      Carry = CarryIn;
      Zero = ZeroIn;
    end
    // 2'b00: {SCo,Rslt} = DatA + DatB;   // add
    // 2'b01: {SCo,Rslt} = DatA<<1'b1;    // left shift
    // 2'b10: Rslt       = DatA & DatB;   // bitwise AND
    // 2'b11: Rslt       = DatA ^ DatB;   // bitwise XOR
  endcase
end

always_comb begin
  Zero <= !Rslt;
  Carry <= CarryIn;
  case(op)

  endcase

endmodule
  /* 
  *
    * 
    * mark 0
    * lsh r1 // lsb
    * lsh r2 // msb
    * jnc 2
    * add r3 // acc += 1
    * jz 2
    * back 0

    * mark 0
    * lsh r1 // lsb
    * jnc 2
    * add r3 // acc += 1
    * jz 2
    * back 0
    * mark 0
    * lsh r2 // msb
    * jnc 2
    * add r3 // acc += 1
    * jz 2
    * back 0
    */

   // 1110 0001 
   // 1100 0010
   // 1000 0100
   // 0000 1000
   // 0001 0000
   //
   // {AccIn[6:0], CarryIn}
