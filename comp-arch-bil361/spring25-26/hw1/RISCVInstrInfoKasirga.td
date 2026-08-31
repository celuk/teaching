let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
def DEGIL_YUKLE : RVInst<(outs GPR:$rd), (ins GPR:$rs1, simm12:$imm12),
"degil.yukle", "$rd, $rs1, $imm12", [], InstFormatOther>, Sched<[]>
{
  bits<12> imm12;
  bits<5> rs1;
  bits<5> rd;
  let Inst{31-20} = imm12;
  let Inst{19-15} = rs1;
  let Inst{14-12} = 0b011;
  let Inst{11-7} = rd;
  let Inst{6-0} = 0b1110111;
}

let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
def YUK_VE_YAZ : RVInst<(outs GPR:$rd), (ins GPR:$rs1, GPR:$rs2),
"yuk.ve.yaz", "$rd, $rs1, $rs2", [], InstFormatOther>, Sched<[]>
{
  bits<5> rs2;
  bits<5> rs1;
  bits<5> rd;
  let Inst{31-25} = 0b0100010;
  let Inst{24-20} = rs2;
  let Inst{19-15} = rs1;
  let Inst{14-12} = 0b101;
  let Inst{11-7} = rd;
  let Inst{6-0} = 0b1110111;
}

// bu disassemblydeki offseti duzeltiyor, yerine simm21_lsb0_jal de kullanilabilirdi cok onemli degil
def simm21_lsb0_jal_custom : Operand<OtherVT> {
  let ParserMatchClass = Simm21Lsb0JALAsmOperand;
  let PrintMethod = "printOperand"; // "printBranchOperand";
  let EncoderMethod = "getImmOpValueAsr1";
  let DecoderMethod = "decodeSImmOperandAndLsl1<21>";
  let MCOperandPredicate = [{
    int64_t Imm;
    if (MCOp.evaluateAsConstantImm(Imm))
      return isShiftedInt<20, 1>(Imm);
    return MCOp.isBareSymbolRef();
  }];
  let OperandType = "OPERAND_IMMEDIATE";
}

let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
def DORTKAT_ATLA : RVInst<(outs GPR:$rd), (ins simm21_lsb0_jal_custom:$imm20),
"dortkat.atla", "$rd, $imm20", [], InstFormatOther>, Sched<[]>
{
  bits<20> imm20;
  bits<5> rd;

  let Inst{31} = imm20{19};
  let Inst{30-21} = imm20{9-0};
  let Inst{20} = imm20{10};
  let Inst{19-12} = imm20{18-11};
  let Inst{11-7} = rd;
  let Inst{6-0} = 0b1111111;
}

let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
def BIT_CEVIR : RVInst<(outs GPR:$rd), (ins GPR:$rs1, uimm1:$s1),
"bit.cevir", "$rd, $rs1, $s1", [], InstFormatOther>, Sched<[]>
{
  bits<5> rd;
  bits<5> rs1;
  bits<1> s1;
  
  let Inst{31} = s1;
  let Inst{30-20} = 0b00101010101;
  let Inst{19-15} = rs1;
  let Inst{14-12} = 0b010;
  let Inst{11-7} = rd;
  let Inst{6-0} = 0b1110111;
}

let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
def SINIR_KNT : RVInst<(outs), (ins GPR:$rs1, GPR:$rs2, uimm2:$s2, simm12:$imm),
"sinir.knt", "$rs1, $rs2, $imm, $s2", [], InstFormatOther>, Sched<[]>
{
  bits<12> imm;
  bits<5>  rs2;
  bits<5>  rs1;
  bits<2>  s2;

  let Inst{31-30} = s2;
  let Inst{29-25} = imm{9-5};
  let Inst{24-20} = rs2;
  let Inst{19-15} = rs1;
  let Inst{14-12} = 0b111;
  let Inst{11-7}  = {imm{4-1}, imm{10}};
  let Inst{6-0}   = 0b1110111;
}
