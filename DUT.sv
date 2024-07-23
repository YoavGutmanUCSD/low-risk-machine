`include "ALU.sv"
`include "BranchSelect.sv"
`include "CounterArray.sv"
`include "Counter.sv"
`include "Ctrl.sv"
`include "DMem.sv"
`include "InstROM.sv"
`include "ProgCtr.sv"
`include "RegFile.sv"

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
             AluOrMemToReg;
  // TODO: finish 1 bit wires and carry, zero registers
  reg        Carry,
             Zero;

  assign WriteData = Type ? Immediate : AluOrMemToReg ? ValueOut : Result;


  Ctrl ControlUnit (
    .mach_code(Instruction),
    .start(Reset),
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
    .OperandOut(OperandOut));
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
    .AddressIn(OperandOut),
    .WriteData(AccOut),
    .ValueOut(ValueOut));
  BranchSelect branchSelect (
    .BranchType(BranchType),
    .CounterValue(CounterValue),
    .ImmediateValue({4'b0000,Value2}), // 4->8bit
    .Carry(Carry),
    .Zero(Zero),
    .JumpValue(TotalJump)
  );
  CounterArray counterArray(
    .rst(ResetCounter),
    .select(Value2),
    .clk(Clk),
    .rstAll(Reset),
    .Value(CounterValue)
  );

endmodule
