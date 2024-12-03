let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
def KAREAL_TOPLA : RVInst<(outs GPR:$rd), (ins GPR:$rs1, GPR:$rs2),
"kareal.topla", "$rd, $rs1, $rs2", [], InstFormatOther>, Sched<[]>
{
bits<5> rs2;
bits<5> rs1;
bits<5> rd;
let Inst{31-25} = 0b0000000;
let Inst{24-20} = rs2;
let Inst{19-15} = rs1;
let Inst{14-12} = 0b000;
let Inst{11-7} = rd;
let Opcode = RISCVOpcode<0b1110111>.Value;
}

let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
def CARP_CIKAR : RVInst<(outs GPR:$rd), (ins GPR:$rs1, GPR:$rs2),
"carp.cikar", "$rd, $rs1, $rs2", [], InstFormatOther>, Sched<[]>
{
bits<5> rs2;
bits<5> rs1;
bits<5> rd;
let Inst{31-25} = 0b1000010;
let Inst{24-20} = rs2;
let Inst{19-15} = rs1;
let Inst{14-12} = 0b001;
let Inst{11-7} = rd;
let Opcode = RISCVOpcode<0b1110111>.Value;
}

let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
def SIFRELE : RVInst<(outs GPR:$rd), (ins GPR:$rs1, simm12:$imm12),
"sifrele", "$rd, $rs1, $imm12", [], InstFormatOther>, Sched<[]>
{
bits<12> imm12;
bits<5> rs1;
bits<5> rd;

let Inst{31-20} = imm12;
let Inst{19-15} = rs1;
let Inst{14-12} = 0b100;
let Inst{11-7} = rd;
let Opcode = RISCVOpcode<0b1110111>.Value;
}

let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
def TASI : RVInst<(outs GPR:$rd), (ins GPR:$rs1, simm12:$imm12),
"tasi", "$rd, $rs1, $imm12", [], InstFormatOther>, Sched<[]>
{
bits<12> imm12;
bits<5> rs1;
bits<5> rd;

let Inst{31-20} = imm12;
let Inst{19-15} = rs1;
let Inst{14-12} = 0b101;
let Inst{11-7} = rd;
let Opcode = RISCVOpcode<0b1110111>.Value;
}

let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
def IKIKAT_ATLA : RVInst<(outs GPR:$rd), (ins simm21_lsb0_jal:$imm20),
"ikikat.atla", "$rd, $imm20", [], InstFormatOther>, Sched<[]>
{
bits<20> imm20;
bits<5> rd;

let Inst{31} = imm20{19};
let Inst{30-21} = imm20{9-0};
let Inst{20} = imm20{10};
let Inst{19-12} = imm20{18-11};
let Inst{11-7} = rd;
let Opcode = RISCVOpcode<0b1111111>.Value;
}

let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
def BITSAY : RVInst<(outs GPR:$rd), (ins GPR:$rs1, simm12:$s1),
"bitsay", "$rd, $rs1, $s1", [], InstFormatOther>, Sched<[]>
{
bits<1> s1;
bits<5> rs1;
bits<5> rd;

let Inst{31} = s1;
let Inst{30-20} = 0b10101010101;
let Inst{19-15} = rs1;
let Inst{14-12} = 0b010;
let Inst{11-7} = rd;
let Opcode = RISCVOpcode<0b1110111>.Value;
}

let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
def SEC_DALLAN : RVInst<(outs), (ins GPR:$rs1, GPR:$rs2, simm13_lsb0:$imm10, simm12:$s2),
"sec.dallan", "$rs1, $rs2, $imm10, $s2", [], InstFormatOther>, Sched<[]>
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
let Opcode = RISCVOpcode<0b1111111>.Value;
}



