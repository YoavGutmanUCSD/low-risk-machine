module DUT (
  input        Clk,
		       Reset,
  output logic Done);
  
  wire [8:0] Instruction;
  wire [7:0] OperandOut,
             AccOut,
             Result,
             ValueOut,
             SelectedResult,
             Immediate,
             TotalJump,
             NextInstruction,
             WriteData,
             CounterValue;
  wire [3:0] ALUOp,
             Value2;
  wire [1:0] BranchType;
  wire       RegWrite,
             InPlace,
             MemWrite,
             Type,
             ResetCounter,
             Done,
             AluOrMemToReg;
  // TODO: finish 1 bit wires and carry, zero registers
  reg        Carry,
             Zero;



  Ctrl ControlUnit (
    .mach_code(Instruction),
    .Imm(Immediate),
    .Aluop(ALUOp),
    .Value2(Value2),
    .BranchType(BranchType),
    .MemRead(),
    .MemWrite(MemWrite),
    .RegWrite(RegWrite),
    .AluOrMemToReg(AluOrMemToReg),
    .ResetCounter(ResetCounter),
    .InPlace(InPlace),
    .AluDisableFlags(),
    .Type(Type),
    .IsDone(Done));
  ProgCtr PC (
    .Clk(Clk),
    .Reset(Reset),
    .BranchType(BranchType),
    .Jump(TotalJump),
    .PC(NextInstruction));
  InstROM InstructionMemory (
    .PC(NextInstruction),
    .mach_code(Instruction));
  RegFile RegisterFile (
    .Clk(Clk),
    .WriteEnable(RegWrite),
    .InPlace(InPlace),
    .AddressIn(Value2),
    .WriteData(WriteData),
    .AccOut(AccOut),
    .OperandOut(ValueOut));
  ALU Alu (
    .op(ALUOp),
    .CarryIn(Carry),
    .Carry(Carry),
    .ZeroIn(Zero),
    .Zero(Zero),
    .AccIn(AccOut),
    .OperandIn(OperandOut),
    .Rslt(Result)); 
  DMem DataMemory (
    .Clk(Clk),
    .WriteEnable(MemWrite),
    .AddressIn(Value2),
    .ValueOut(ValueOut));
  BranchSelect branchSelect (
    .BranchType(BranchType),
    .CounterValue(CounterValue),
    .ImmediateValue({4'b0000,Value2}) // 4->8bit
  );
  CounterArray counterArray(
    .rst(ResetCounter),
    .select(Value2),
    .clk(Clk),
    .rstAll(Reset),
    .Value(CounterValue)
  );

endmodule
