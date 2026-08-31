`timescale 1ns / 1ps

`define ADDRESS       63:32
`define INSTRUCTION   31:0

// if you are going to provide a different program, change it according to the static inst count in the program you will provide
`define INSTRUCTION_COUNT 39

module tb_processor();

    reg clk;
    reg rst;
    reg [31:0] inst;
    wire [31:0] pc;
    wire [1023:0] regs;
    wire data_mem_we;
    wire [31:0] data_mem_addr;
    wire [31:0] data_mem_wdata;
    wire [31:0] data_mem_rdata;
    wire [1:0] cur_stage;

    wire [31:0] inst_le = {inst[7:0], inst[15:8], inst[23:16], inst[31:24]};

    processor uut (
        .clk_i(clk),
        .rst_i(rst),
        .inst_i(inst),
        .pc_o(pc),
        .regs_o(regs),
        .data_mem_we_o(data_mem_we),
        .data_mem_addr_o(data_mem_addr),
        .data_mem_wdata_o(data_mem_wdata),
        .data_mem_rdata_i(data_mem_rdata),
        .cur_stage_o(cur_stage)
    );

    always begin
        clk = !clk;
        #0.5;
    end

    localparam DATA_MEM_SIZE = 2048; // 8192 bytes

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

    // if you are going to provide a different program, you can change the INSTRUCTION_COUNT variable and
    // provide hex codes and addresses in a similar way to the below
    // if you have different labels like in the example program, be careful to give the label address correctly
    initial begin
        // program counter starts from 0x0 for the first inst
        instruction_memory[0 ][`ADDRESS] = 32'h0000_0000; instruction_memory[0 ][`INSTRUCTION] = 32'hb7_11_00_00; // lui x3, 0x1
        instruction_memory[1 ][`ADDRESS] = 32'h0000_0004; instruction_memory[1 ][`INSTRUCTION] = 32'hf7_52_40_01; // movu x5, x0, 0x14
        instruction_memory[2 ][`ADDRESS] = 32'h0000_0008; instruction_memory[2 ][`INSTRUCTION] = 32'h77_53_70_00; // movu x6, x0, 0x7
        instruction_memory[3 ][`ADDRESS] = 32'h0000_000c; instruction_memory[3 ][`INSTRUCTION] = 32'hf7_53_30_00; // movu x7, x0, 0x3
        instruction_memory[4 ][`ADDRESS] = 32'h0000_0010; instruction_memory[4 ][`INSTRUCTION] = 32'h17_0d_00_00; // auipc x26, 0x0
        instruction_memory[5 ][`ADDRESS] = 32'h0000_0014; instruction_memory[5 ][`INSTRUCTION] = 32'h93_88_81_00; // addi x17, x3, 0x8
        instruction_memory[6 ][`ADDRESS] = 32'h0000_0018; instruction_memory[6 ][`INSTRUCTION] = 32'h23_a0_51_00; // sw x5, 0x0(x3)
        instruction_memory[7 ][`ADDRESS] = 32'h0000_001c; instruction_memory[7 ][`INSTRUCTION] = 32'h23_a2_61_00; // sw x6, 0x4(x3)
        instruction_memory[8 ][`ADDRESS] = 32'h0000_0020; instruction_memory[8 ][`INSTRUCTION] = 32'h03_a2_01_00; // lw x4, 0x0(x3)
        instruction_memory[9 ][`ADDRESS] = 32'h0000_0024; instruction_memory[9 ][`INSTRUCTION] = 32'h33_84_62_00; // add x8, x5, x6
        instruction_memory[10][`ADDRESS] = 32'h0000_0028; instruction_memory[10][`INSTRUCTION] = 32'hb3_84_62_40; // sub x9, x5, x6
        instruction_memory[11][`ADDRESS] = 32'h0000_002c; instruction_memory[11][`INSTRUCTION] = 32'h33_f5_62_00; // and x10, x5, x6
        instruction_memory[12][`ADDRESS] = 32'h0000_0030; instruction_memory[12][`INSTRUCTION] = 32'h93_95_12_00; // slli x11, x5, 0x1
        instruction_memory[13][`ADDRESS] = 32'h0000_0034; instruction_memory[13][`INSTRUCTION] = 32'h33_d6_74_40; // sra x12, x9, x7
        instruction_memory[14][`ADDRESS] = 32'h0000_0038; instruction_memory[14][`INSTRUCTION] = 32'h93_46_33_00; // xori x13, x6, 0x3
        instruction_memory[15][`ADDRESS] = 32'h0000_003c; instruction_memory[15][`INSTRUCTION] = 32'h13_07_20_00; // addi x14, x0, 0x2
        instruction_memory[16][`ADDRESS] = 32'h0000_0040; instruction_memory[16][`INSTRUCTION] = 32'h93_b7_42_06; // sltiu x15, x5, 0x64
        instruction_memory[17][`ADDRESS] = 32'h0000_0044; instruction_memory[17][`INSTRUCTION] = 32'hb3_ad_63_00; // slt x27, x7, x6
        instruction_memory[18][`ADDRESS] = 32'h0000_0048; instruction_memory[18][`INSTRUCTION] = 32'h33_be_63_00; // sltu x28, x7, x6
        instruction_memory[19][`ADDRESS] = 32'h0000_004c; instruction_memory[19][`INSTRUCTION] = 32'h63_d2_62_02; // bge x5, x6, 0x70
        instruction_memory[20][`ADDRESS] = 32'h0000_0050; instruction_memory[20][`INSTRUCTION] = 32'h63_08_07_0a; // beq x14, x0, 0x100
        instruction_memory[21][`ADDRESS] = 32'h0000_0070; instruction_memory[21][`INSTRUCTION] = 32'h77_58_20_00; // movu x16, x0, 0x2
        instruction_memory[22][`ADDRESS] = 32'h0000_0074; instruction_memory[22][`INSTRUCTION] = 32'hf7_18_53_04; // srt.cmp.st x17, x6, x5
        instruction_memory[23][`ADDRESS] = 32'h0000_0078; instruction_memory[23][`INSTRUCTION] = 32'h7f_f0_18_a1; // mac.ld.st x17, x17, 0x200, 0x2
        instruction_memory[24][`ADDRESS] = 32'h0000_007c; instruction_memory[24][`INSTRUCTION] = 32'h13_08_f8_ff; // addi x16, x16, -0x1
        instruction_memory[25][`ADDRESS] = 32'h0000_0080; instruction_memory[25][`INSTRUCTION] = 32'h63_00_08_08; // beq x16, x0, 0x100
        instruction_memory[26][`ADDRESS] = 32'h0000_0084; instruction_memory[26][`INSTRUCTION] = 32'he3_58_08_fe; // bge x16, x0, 0x74
        instruction_memory[27][`ADDRESS] = 32'h0000_0100; instruction_memory[27][`INSTRUCTION] = 32'h77_e9_38_08; // ld.cmp.max x18, x17, x3
        instruction_memory[28][`ADDRESS] = 32'h0000_0104; instruction_memory[28][`INSTRUCTION] = 32'hf7_09_62_00; // sub.abs x19, x4, x6
        instruction_memory[29][`ADDRESS] = 32'h0000_0108; instruction_memory[29][`INSTRUCTION] = 32'h77_ca_59_00; // avg.flr x20, x19, 0x5
        instruction_memory[30][`ADDRESS] = 32'h0000_010c; instruction_memory[30][`INSTRUCTION] = 32'hf7_fa_c2_10; // srch.bit.ptrn x21, x5, x12
        instruction_memory[31][`ADDRESS] = 32'h0000_0110; instruction_memory[31][`INSTRUCTION] = 32'h77_ab_59_55; // sel.part x22, x19, 0x0
        instruction_memory[32][`ADDRESS] = 32'h0000_0114; instruction_memory[32][`INSTRUCTION] = 32'h7f_80_4b_55; // sel.cnd x23, x20, 0x140, 1
        instruction_memory[33][`ADDRESS] = 32'h0000_0118; instruction_memory[33][`INSTRUCTION] = 32'hef_00_80_00; // jal x1, 0x120
        instruction_memory[34][`ADDRESS] = 32'h0000_0120; instruction_memory[34][`INSTRUCTION] = 32'h13_8c_c1_00; // addi x24, x3, 0xc
        instruction_memory[35][`ADDRESS] = 32'h0000_0124; instruction_memory[35][`INSTRUCTION] = 32'h77_9c_62_04; // srt.cmp.st x24, x5, x6
        instruction_memory[36][`ADDRESS] = 32'h0000_0128; instruction_memory[36][`INSTRUCTION] = 32'hf7_6c_3c_08; // ld.cmp.max x25, x24, x3
        instruction_memory[37][`ADDRESS] = 32'h0000_012c; instruction_memory[37][`INSTRUCTION] = 32'he7_8f_40_02; // jalr x31, 0x24(x1)
        instruction_memory[38][`ADDRESS] = 32'h0000_0140; instruction_memory[38][`INSTRUCTION] = 32'h7f_80_10_14; // sel.cnd x1, x1, 0x140, 0
    end

    integer j;
    initial begin
        //$dumpfile("dump.vcd");
        //$dumpvars(0, tb_processor);

        clk = 0;

        data_memory['h0 >> 2]    = 32'h000000ff;
        data_memory['h200 >> 2]  = 32'h000000aa;

        rst = 1;
        #10;

        // first instruction is fetched at the beginning of the program
        rst = 0;

        // program flow
        for(j = 0; j < `INSTRUCTION_COUNT; j = j+1) begin
            // instruction is fetched with the program counter of the next instruction
            if(pc == instruction_memory[j][`ADDRESS]) begin
                $display("Program Counter: 0x%x", pc);
                inst = instruction_memory[j][`INSTRUCTION]; #1;

                // if it is a jump or branch instruction, check the address again, because it might have gone back
                if(inst_le[6:0] == 7'b1101111 || // JAL
                   inst_le[6:0] == 7'b1100111 || // JALR
                   inst_le[6:0] == 7'b1100011 || // BEQ, BGE
                   (inst_le[14:12] == 3'b000 && inst_le[6:0] == 7'b1111111) // SEL.CND
                )
                begin
                    j = -1;
                end
                while(cur_stage != 2'b00) begin // wait until the instruction is retired
                    #1;
                end

                $display("Instruction: 0x%x", inst);
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
                $display("DataMem[0x0]:    0x%0h", data_memory['h0 >> 2]);
                $display("DataMem[0x200]:  0x%0h", data_memory['h200 >> 2]);
                $display("DataMem[0x1000]: 0x%0h", data_memory['h1000 >> 2]);
                $display("DataMem[0x1004]: 0x%0h", data_memory['h1004 >> 2]);
                $display("DataMem[0x1008]: 0x%0h", data_memory['h1008 >> 2]);
                $display("DataMem[0x100c]: 0x%0h", data_memory['h100c >> 2]);
                $display("DataMem[0x1010]: 0x%0h", data_memory['h1010 >> 2]);
                $display("---------------------------------------------------\n");
            end
        end

        $finish;
    end
endmodule
