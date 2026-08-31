`timescale 1ns / 1ps

`define ADDRESS       63:32
`define INSTRUCTION   31:0

// farkli bir program verecekseniz vereceginiz programdaki statik buyruk sayisina gore degistirin
`define INSTRUCTION_COUNT 25

module tb_islemci();

    reg clk;
    reg rst;
    reg [31:0] inst;
    wire [31:0] pc;
    wire [1023:0] regs;
    wire data_mem_we;
    wire [31:0] data_mem_addr;
    wire [31:0] data_mem_wdata;
    wire [31:0] data_mem_rdata;

    wire [31:0] inst_le = {inst[7:0], inst[15:8], inst[23:16], inst[31:24]};

    // modul ismini "islemci" yerine soyadiniz olarak degistirmeniz lazim
    islemci uut (
        .saat(clk),
        .reset(rst),
        .buyruk(inst),
        .program_sayaci(pc),
        .yazmaclar(regs),
        .vb_yaz(data_mem_we),
        .vb_adres(data_mem_addr),
        .vb_yaz_veri(data_mem_wdata),
        .vb_oku_veri(data_mem_rdata)
    );

    always begin
        clk = !clk;
        #0.5;
    end

    localparam DATA_MEM_SIZE = 4096; // 16384 bytes

    reg [31:0] data_memory [0:DATA_MEM_SIZE-1];

    integer k;
    initial begin
        for (k = 0; k < DATA_MEM_SIZE; k = k + 1) begin
            data_memory[k] = 32'b0;
        end
    end

    assign data_mem_rdata = data_memory[data_mem_addr[31:2]];

    always @(posedge clk) begin
        if (data_mem_we) begin
            data_memory[data_mem_addr[31:2]] <= data_mem_wdata;
        end
    end

    wire [31:0] regs_w [31:0];
    genvar i;
    generate 
        for (i = 0; i < 32; i = i + 1) begin
            assign regs_w[i] = regs[i*32 +: 32];
        end
    endgenerate

    reg [63:0] instruction_memory [`INSTRUCTION_COUNT-1 : 0];

    // farkli bir program verecekseniz INSTRUCTION_COUNT degiskenini degistirip asagidakine benzer sekilde verebilirsiniz
    // ornek programdaki gibi farkli etiketleriniz varsa etiket adresini dogru vermeye dikkat edin
    initial begin
        // program counter starts from 0x0 for the first inst
        instruction_memory[0 ][`ADDRESS] = 32'h0000_0000; instruction_memory[0 ][`INSTRUCTION] = 32'hb7_22_00_00; // PC 0x0000: lui x5, 0x2
        instruction_memory[1 ][`ADDRESS] = 32'h0000_0004; instruction_memory[1 ][`INSTRUCTION] = 32'h13_83_02_20; // PC 0x0004: addi x6, x5, 0x200
        instruction_memory[2 ][`ADDRESS] = 32'h0000_0008; instruction_memory[2 ][`INSTRUCTION] = 32'h97_03_00_00; // PC 0x0008: auipc x7, 0x0
        instruction_memory[3 ][`ADDRESS] = 32'h0000_000c; instruction_memory[3 ][`INSTRUCTION] = 32'h77_34_e0_7f; // PC 0x000c: degil.yukle x8, x0, 0x7fe
        instruction_memory[4 ][`ADDRESS] = 32'h0000_0010; instruction_memory[4 ][`INSTRUCTION] = 32'h93_64_f4_0f; // PC 0x0010: ori x9, x8, 0xff
        instruction_memory[5 ][`ADDRESS] = 32'h0000_0014; instruction_memory[5 ][`INSTRUCTION] = 32'h23_20_93_00; // PC 0x0014: sw x9, 0x0(x6)
        instruction_memory[6 ][`ADDRESS] = 32'h0000_0018; instruction_memory[6 ][`INSTRUCTION] = 32'h03_25_03_00; // PC 0x0018: lw x10, 0x0(x6)
        instruction_memory[7 ][`ADDRESS] = 32'h0000_001c; instruction_memory[7 ][`INSTRUCTION] = 32'hb3_05_75_00; // PC 0x001c: add x11, x10, x7
        instruction_memory[8 ][`ADDRESS] = 32'h0000_0020; instruction_memory[8 ][`INSTRUCTION] = 32'h33_86_55_40; // PC 0x0020: sub x12, x11, x5
        instruction_memory[9 ][`ADDRESS] = 32'h0000_0024; instruction_memory[9 ][`INSTRUCTION] = 32'hb3_46_96_00; // PC 0x0024: xor x13, x12, x9
        instruction_memory[10][`ADDRESS] = 32'h0000_0028; instruction_memory[10][`INSTRUCTION] = 32'h33_d7_76_40; // PC 0x0028: sra x14, x13, x7
        instruction_memory[11][`ADDRESS] = 32'h0000_002c; instruction_memory[11][`INSTRUCTION] = 32'h93_57_27_00; // PC 0x002c: srli x15, x14, 0x2
        instruction_memory[12][`ADDRESS] = 32'h0000_0030; instruction_memory[12][`INSTRUCTION] = 32'h33_a8_d7_00; // PC 0x0030: slt x16, x15, x13
        instruction_memory[13][`ADDRESS] = 32'h0000_0034; instruction_memory[13][`INSTRUCTION] = 32'hb3_38_78_00; // PC 0x0034: sltu x17, x16, x7
        instruction_memory[14][`ADDRESS] = 32'h0000_0038; instruction_memory[14][`INSTRUCTION] = 32'h13_a9_58_00; // PC 0x0038: slti x18, x17, 0x5
        instruction_memory[15][`ADDRESS] = 32'h0000_003c; instruction_memory[15][`INSTRUCTION] = 32'hf7_29_59_95; // PC 0x003c: bit.cevir x19, x18, 0x1
        instruction_memory[16][`ADDRESS] = 32'h0000_0040; instruction_memory[16][`INSTRUCTION] = 32'h77_53_33_45; // PC 0x0040: yuk.ve.yaz x6, x6, x19
        instruction_memory[17][`ADDRESS] = 32'h0000_0044; instruction_memory[17][`INSTRUCTION] = 32'h63_1e_18_1b; // PC 0x0044: bne x16, x17, 0x200
        instruction_memory[18][`ADDRESS] = 32'h0000_0048; instruction_memory[18][`INSTRUCTION] = 32'h63_4c_39_7b; // PC 0x0048: blt x18, x19, 0x800
        instruction_memory[19][`ADDRESS] = 32'h0000_004c; instruction_memory[19][`INSTRUCTION] = 32'h7f_0a_00_08; // PC 0x004c: dortkat.atla x20, 0x80
        instruction_memory[20][`ADDRESS] = 32'h0000_0200; instruction_memory[20][`INSTRUCTION] = 32'h77_78_19_41; // PC 0x0200: sinir.knt x18, x17, 0x10, 1
        instruction_memory[21][`ADDRESS] = 32'h0000_0204; instruction_memory[21][`INSTRUCTION] = 32'he7_8a_02_00; // PC 0x0204: jalr x21, 0(x5)
        instruction_memory[22][`ADDRESS] = 32'h0000_0800; instruction_memory[22][`INSTRUCTION] = 32'hef_00_00_00; // PC 0x0800: jal x1, 0x0
        instruction_memory[23][`ADDRESS] = 32'h0000_2000; instruction_memory[23][`INSTRUCTION] = 32'h77_70_6b_c2; // PC 0x2000: sinir.knt x22, x6, 0x20, 3
        instruction_memory[24][`ADDRESS] = 32'h0000_2004; instruction_memory[24][`INSTRUCTION] = 32'hef_e0_cf_ff; // PC 0x2004: jal x1, -0x1804
    end

    integer j;
    reg [31:0] pc_before;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_islemci);

        clk = 0;

        data_memory['h10 >> 2]  = 32'h000000ff;
        data_memory['h20 >> 2]  = 32'h00002200;
        data_memory['h2200 >> 2]  = 32'h000000aa;

        rst = 1;
        #10;

        // program baslangicinda ilk buyruk getiriliyor
        rst = 0;

        // program akisi
        for(j = 0; j < `INSTRUCTION_COUNT; j = j+1) begin
            // bir sonraki buyrugun program sayaci ile buyruk getiriliyor
            if(pc == instruction_memory[j][`ADDRESS]) begin
                pc_before = pc;
                $display("Program Sayaci: 0x%x", pc);
                inst = instruction_memory[j][`INSTRUCTION]; #1;

                // atlama ya da dallanma buyruguysa adresi tekrar kontrol et, cunku geriye gitmis olabilir
                if(inst_le[6:0] == 7'b1101111 || // JAL
                   inst_le[6:0] == 7'b1100111 || // JALR
                   inst_le[6:0] == 7'b1100011 || // BNE, BLT
                   (inst_le[6:0] == 7'b1111111) // DORTKAT.ATLA
                )
                begin
                    if ((pc != (pc_before + 32'd4)) && (pc != pc_before)) begin
                        j = -1;
                    end
                end

                $display("Buyruk: 0x%x", inst_le);
                $display("x0:  0x%0h", regs_w[0 ]);
                $display("x1:  0x%0h", regs_w[1 ]);
                $display("x2:  0x%0h", regs_w[2 ]);
                $display("x3:  0x%0h", regs_w[3 ]);
                $display("x4:  0x%0h", regs_w[4 ]);
                $display("x5:  0x%0h", regs_w[5 ]);
                $display("x6:  0x%0h", regs_w[6 ]);
                $display("x7:  0x%0h", regs_w[7 ]);
                $display("x8:  0x%0h", regs_w[8 ]);
                $display("x9:  0x%0h", regs_w[9 ]);
                $display("x10: 0x%0h", regs_w[10]);
                $display("x11: 0x%0h", regs_w[11]);
                $display("x12: 0x%0h", regs_w[12]);
                $display("x13: 0x%0h", regs_w[13]);
                $display("x14: 0x%0h", regs_w[14]);
                $display("x15: 0x%0h", regs_w[15]);
                $display("x16: 0x%0h", regs_w[16]);
                $display("x17: 0x%0h", regs_w[17]);
                $display("x18: 0x%0h", regs_w[18]);
                $display("x19: 0x%0h", regs_w[19]);
                $display("x20: 0x%0h", regs_w[20]);
                $display("x21: 0x%0h", regs_w[21]);
                $display("x22: 0x%0h", regs_w[22]);
                $display("x23: 0x%0h", regs_w[23]);
                $display("x24: 0x%0h", regs_w[24]);
                $display("x25: 0x%0h", regs_w[25]);
                $display("x26: 0x%0h", regs_w[26]);
                $display("x27: 0x%0h", regs_w[27]);
                $display("x28: 0x%0h", regs_w[28]);
                $display("x29: 0x%0h", regs_w[29]);
                $display("x30: 0x%0h", regs_w[30]);
                $display("x31: 0x%0h", regs_w[31]);
                $display("VeriBellegi[0x10]: 0x%0h", data_memory['h10 >> 2]);
                $display("VeriBellegi[0x20]: 0x%0h", data_memory['h20 >> 2]);
                $display("VeriBellegi[0x2200]: 0x%0h", data_memory['h2200 >> 2]);
                $display("---------------------------------------------------\n");
            end
        end

        $finish;
    end
endmodule
