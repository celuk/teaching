asm ("lui x5, 0x2"); // PC 0x0
asm ("addi x6, x5, 512"); // PC 0x04
asm ("auipc x7, 0"); // PC 0x08
asm ("degil.yukle x8, x0, 2046"); // PC 0x0C
asm ("ori x9, x8, 255"); // PC 0x10
asm ("sw x9, 0(x6)"); // PC 0x14
asm ("lw x10, 0(x6)"); // PC 0x18
asm ("add x11, x10, x7"); // PC 0x1C
asm ("sub x12, x11, x5"); // PC 0x20
asm ("xor x13, x12, x9"); // PC 0x24
asm ("sra x14, x13, x7"); // PC 0x28
asm ("srli x15, x14, 2"); // PC 0x2C
asm ("slt x16, x15, x13"); // PC 0x30
asm ("sltu x17, x16, x7"); // PC 0x34
asm ("slti x18, x17, 5"); // PC 0x38
asm ("bit.cevir x19, x18, 1"); // PC 0x3C
asm ("yuk.ve.yaz x6, x6, x19"); // PC 0x40
asm ("bne x16, x17, 0x000001BC"); // PC 0x44, target 0x200, offset = 0x200 - 0x44 = 0x1BC
asm ("blt x18, x19, 0x000007B8"); // PC 0x48, target 0x800, offset = 0x800 - 0x48 = 0x7B8
asm ("dortkat.atla x20, 0x00000080"); // PC 0x4C
asm ("0x00000200:\n"
                "sinir.knt x18, x17, 0x10, 1\n" // PC 0x200
                "jalr x21, 0(x5)"); // PC 0x204, target 0x2000, x5 = 0x2000 (register-relative, not PC-relative)
asm ("0x00000800:\n"
                "jal x1, 0x00000000"); // PC 0x800, target 0x800, offset = 0x800 - 0x800 = 0x0
asm ("0x00002000:\n"
                "sinir.knt x22, x6, 0x20, 3\n" // PC 0x2000
                "jal x1, -0x00001804"); // PC 0x2004, target 0x800, offset = 0x800 - 0x2004 = -0x1804
