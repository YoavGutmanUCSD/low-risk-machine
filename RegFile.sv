module RegFile(
  input      Clk,	 // clock
             WriteEnable,    // write enable
             InPlace,   // write select (acc or oper)
  input[3:0] AddressIn,     // read address pointer B
  input[7:0] WriteData,   // write data in
  output[7:0]AccOut,	 // read data out A
             OperandOut); // read data out B

  logic[7:0] Core[8]; // reg file itself (8*8 array)

  always_ff @(posedge Clk)
    if(WriteEnable) 
      if (InPlace) Core[AddressIn] <= WriteData;
      else Core[0] <= WriteData;

  assign AccOut = Core[0];
  assign OperandOut = Core[AddressIn];

endmodule
