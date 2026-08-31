// example.c
asm ("lui x3, 0x00001");       // PC 0x00
asm ("movu x5, x0, 20");       // PC 0x04
asm ("movu x6, x0, 7");        // PC 0x08
asm ("movu x7, x0, 3");        // PC 0x0C
asm ("auipc x26, 0x0");        // PC 0x10
asm ("addi x17, x3, 8");       // PC 0x14
asm ("sw x5, 0(x3)");          // PC 0x18
asm ("sw x6, 4(x3)");          // PC 0x1C
asm ("lw x4, 0(x3)");          // PC 0x20
asm ("add x8, x5, x6");        // PC 0x24
asm ("sub x9, x5, x6");        // PC 0x28
asm ("and x10, x5, x6");       // PC 0x2C
asm ("slli x11, x5, 1");       // PC 0x30
asm ("sra x12, x9, x7");       // PC 0x34
asm ("xori x13, x6, 3");       // PC 0x38
asm ("addi x14, x0, 2");       // PC 0x3C
asm ("sltiu x15, x5, 100");    // PC 0x40
asm ("slt x27, x7, x6");       // PC 0x44
asm ("sltu x28, x7, x6");      // PC 0x48
asm ("bge x5, x6, 0x24");      // PC 0x4C, target 0x70, offset = 0x70 - 0x4C = 0x24
asm ("beq x14, x0, 0xB0");     // PC 0x50, target 0x100, offset = 0x100 - 0x50 = 0xB0
asm ("0x00000070:\n"
     "movu x16, x0, 2\n"       // PC 0x70
     "0x00000074:\n"
     "srt.cmp.st x17, x6, x5\n"       // PC 0x74
     "mac.ld.st x17, x17, 0x00000200, 2\n"  // PC 0x78
     "addi x16, x16, -1\n"            // PC 0x7C
     "beq x16, x0, 0x80\n"            // PC 0x80, target 0x100, offset = 0x100 - 0x80 = 0x80
     "bge x16, x0, -16");             // PC 0x84, target 0x74, offset = 0x74 - 0x84 = -16
asm ("0x00000100:\n"
     "ld.cmp.max x18, x17, x3\n"      // PC 0x100
     "sub.abs x19, x4, x6\n"          // PC 0x104
     "avg.flr x20, x19, 5\n"          // PC 0x108
     "srch.bit.ptrn x21, x5, x12\n"   // PC 0x10C
     "sel.part x22, x19, 0\n"         // PC 0x110
     "sel.cnd x23, x20, 0x00000140, 1\n"  // PC 0x114 (absolute address, not PC-relative)
     "jal x1, 0x8");                  // PC 0x118, target 0x120, offset = 0x120 - 0x118 = 0x8
asm ("0x00000120:\n"
     "addi x24, x3, 12\n"             // PC 0x120
     "srt.cmp.st x24, x5, x6\n"       // PC 0x124
     "ld.cmp.max x25, x24, x3\n"      // PC 0x128
     "jalr x31, 0x24(x1)");           // PC 0x12C (register-relative, not PC-relative)
asm ("0x00000140:\n"
     "sel.cnd x1, x1, 0x00000140, 0");  // PC 0x140 (absolute address, not PC-relative)
