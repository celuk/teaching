let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
def SUB_ABS : RVInst<(outs GPR:$rd), (ins GPR:$rs1, GPR:$rs2),
"sub.abs", "$rd, $rs1, $rs2", [], InstFormatOther>, Sched<[]>
{
  bits<5> rs2;
  bits<5> rs1;
  bits<5> rd;
  let Inst{31-25} = 0b0000000;
  let Inst{24-20} = rs2;
  let Inst{19-15} = rs1;
  let Inst{14-12} = 0b000;
  let Inst{11-7} = rd;
  let Inst{6-0} = 0b1110111;
}

let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
def AVG_FLR : RVInst<(outs GPR:$rd), (ins GPR:$rs1, simm12:$imm12),
"avg.flr", "$rd, $rs1, $imm12", [], InstFormatOther>, Sched<[]>
{
  bits<12> imm12;
  bits<5> rs1;
  bits<5> rd;
  let Inst{31-20} = imm12;
  let Inst{19-15} = rs1;
  let Inst{14-12} = 0b100;
  let Inst{11-7} = rd;
  let Inst{6-0} = 0b1110111;
}

let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
def MOVU : RVInst<(outs GPR:$rd), (ins GPR:$rs1, simm12:$imm12),
"movu", "$rd, $rs1, $imm12", [], InstFormatOther>, Sched<[]>
{
  bits<12> imm12;
  bits<5> rs1;
  bits<5> rd;
  let Inst{31-20} = imm12;
  let Inst{19-15} = rs1;
  let Inst{14-12} = 0b101;
  let Inst{11-7} = rd;
  let Inst{6-0} = 0b1110111;
}

let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
def SRT_CMP_ST : RVInst<(outs GPR:$rd), (ins GPR:$rs1, GPR:$rs2),
"srt.cmp.st", "$rd, $rs1, $rs2", [], InstFormatOther>, Sched<[]>
{
  bits<5> rs2;
  bits<5> rs1;
  bits<5> rd;
  let Inst{31-25} = 0b0000010;
  let Inst{24-20} = rs2;
  let Inst{19-15} = rs1;
  let Inst{14-12} = 0b001;
  let Inst{11-7} = rd;
  let Inst{6-0} = 0b1110111;
}

let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
def LD_CMP_MAX : RVInst<(outs GPR:$rd), (ins GPR:$rs1, GPR:$rs2),
"ld.cmp.max", "$rd, $rs1, $rs2", [], InstFormatOther>, Sched<[]>
{
  bits<5> rs2;
  bits<5> rs1;
  bits<5> rd;
  let Inst{31-25} = 0b0000100;
  let Inst{24-20} = rs2;
  let Inst{19-15} = rs1;
  let Inst{14-12} = 0b110;
  let Inst{11-7} = rd;
  let Inst{6-0} = 0b1110111;
}

let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
def SRCH_BIT_PTRN : RVInst<(outs GPR:$rd), (ins GPR:$rs1, GPR:$rs2),
"srch.bit.ptrn", "$rd, $rs1, $rs2", [], InstFormatOther>, Sched<[]>
{
  bits<5> rs2;
  bits<5> rs1;
  bits<5> rd;
  let Inst{31-25} = 0b0001000;
  let Inst{24-20} = rs2;
  let Inst{19-15} = rs1;
  let Inst{14-12} = 0b111;
  let Inst{11-7} = rd;
  let Inst{6-0} = 0b1110111;
}

let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
def SEL_PART : RVInst<(outs GPR:$rd), (ins GPR:$rs1, simm12:$s1),
"sel.part", "$rd, $rs1, $s1", [], InstFormatOther>, Sched<[]>
{
  bits<1> s1;
  bits<5> rs1;
  bits<5> rd;
  let Inst{31} = s1;
  let Inst{30-20} = 0b10101010101;
  let Inst{19-15} = rs1;
  let Inst{14-12} = 0b010;
  let Inst{11-7} = rd;
  let Inst{6-0} = 0b1110111;
}

let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
def SEL_CND : RVInst<(outs), (ins GPR:$rs1, GPR:$rs2, simm13_lsb0:$imm10, simm12:$s2),
"sel.cnd", "$rs1, $rs2, $imm10, $s2", [], InstFormatOther>, Sched<[]>
{
  bits<2> s2;
  bits<10> imm10;
  bits<5> rs2;
  bits<5> rs1;
  let Inst{31-30} = s2;
  let Inst{29-25} = imm10{8-4};
  let Inst{24-20} = rs2;
  let Inst{19-15} = rs1;
  let Inst{14-12} = 0b000;
  let Inst{11-8} = imm10{3-0};
  let Inst{7} = imm10{9};
  let Inst{6-0} = 0b1111111;
}

let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
def MAC_LD_ST : RVInst<(outs), (ins GPR:$rs1, GPR:$rs2, simm13_lsb0:$imm10, simm12:$s2),
"mac.ld.st", "$rs1, $rs2, $imm10, $s2", [], InstFormatOther>, Sched<[]>
{
  bits<2> s2;
  bits<10> imm10;
  bits<5> rs2;
  bits<5> rs1;
  let Inst{31-30} = s2;
  let Inst{29-25} = imm10{8-4};
  let Inst{24-20} = rs2;
  let Inst{19-15} = rs1;
  let Inst{14-12} = 0b111;
  let Inst{11-8} = imm10{3-0};
  let Inst{7} = imm10{9};
  let Inst{6-0} = 0b1111111;
}
