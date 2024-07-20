module Ctrl(
  input        [8:0] mach_code,
  output logic [7:0] Imm
  output logic [3:0] Aluop,
                     Value2, // either operand ptr, jump immediate, or counter select
  output logic [1:0] BranchType,
  output logic       MemRead,
					 MemWrite,
                     RegWrite,
					 AluOrMemToReg,
					 ResetCounter,
                     InPlace,
                     AluDisableFlags,
                     Type,
                     IsDone);

  // ALU operation
  // OPLUT opDef (.InstructionOpcode(mach_code[7:4]), .ALUOp(Aluop));
  assign Imm = mach_code[7:0];
  always_comb begin
    IsDone = 'b0;
    Aluop = mach_code[7:4];
    /* Aluop = 4'b0000; */
    MemRead = 'b0;
    ResetCounter = 'b0;
    MemWrite = 'b0;
    RegWrite = 'b1;
    MemRead = 'b0;
    Type = 'b0;
    InPlace = 'b0;
    AluDisableFlags = 'b0;
    AluOrMemToReg = 'b0;
    Value2 = mach_code[3:0];
    BranchType = 2'b00;
    if(mach_code[8])
      Type = 'b1
    else case (mach_code[7:4])
      4'b0001: begin // load
        MemRead = 'b1;
        AluOrMemToReg = 'b1;
      end
      4'b0010: begin // store
        MemWrite = 'b1;
        RegWrite = 'b0;
      end
      4'b0011: begin // mov
        InPlace = 'b1;
      end
      4'b0100: begin // add
        
      end
      4'b0101: begin // sub
        
      end
      4'b0110: begin // not
        InPlace = 'b1;
      end
      4'b0111: begin // xor
        
      end
      4'b1000: begin // lsh
        InPlace = 'b1;
      end
      4'b1001: begin // rsh
        InPlace = 'b1;
      end
      4'b1010: begin // done
        IsDone = 'b1;
      end
      4'b1011: begin // jnc
        RegWrite = 'b0;
        BranchType = 2'b01;
      end
      4'b1100: begin // jz
        RegWrite = 'b0;
        BranchType = 2'b01;
      end
      4'b1101: begin // lj (ignored)
        RegWrite = 'b0;
      end
      4'b1101: begin // mark
        RegWrite = 'b0;
        ResetCounter = 'b1;
      end 
      4'b1101: begin // back
        RegWrite = 'b0;
        BranchType = 2'b10;
      end 
    endcase
  end

endmodule
