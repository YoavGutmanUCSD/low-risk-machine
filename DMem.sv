module DMem(
  input Clk,
        WriteEnable,
  input[7:0] WriteData,
             AddressIn,
  output logic[7:0] ValueOut);

  logic[7:0] Core[256];

  always_ff @(posedge Clk)
    if(WriteEnable) Core[Addr] <= WriteData;

  assign ValueOut = Core[AddressIn];

endmodule





