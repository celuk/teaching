`timescale 1ns / 1ps

module islemci(
    input saat,
    input reset,
    input [31:0] buyruk,
    output reg [31:0] program_sayaci,
    output [1023:0] yazmaclar
);

    // yazmaclar kolay ayrim icin bu sekilde baglaniyor
    reg [31:0] yazmaclar_r [31:0];
    genvar i;
    generate 
        for (i = 0; i < 32; i = i + 1) begin
            assign yazmaclar[i*32 +: 32] = yazmaclar_r[i];
        end
    endgenerate

    // baslangicta program sayaci ve yazmaclar sifirlaniyor
    integer j;
    initial begin
        program_sayaci = 32'h00000000;
        for (j=0; j < 32; j = j+1) begin
            yazmaclar_r[j] = 32'h00000000;
        end
    end

    // kucugu basta ve bayt bayt geliyor
    wire [31:0] buyruk_w;
    assign buyruk_w = {buyruk[7:0], buyruk[15:8], buyruk[23:16], buyruk[31:24]};

    // buyruktan gelen is ve islev kodlari
    wire [6:0] opcode;
    wire [2:0] funct3;
    wire [6:0] funct7;
    assign opcode = buyruk_w[6:0];
    assign funct3 = buyruk_w[14:12];
    assign funct7 = buyruk_w[31:25];

    // buyruktan gelen yazmac adresleri
    wire [4:0] rd_adres;
    wire [4:0] rs1_adres;
    wire [4:0] rs2_adres;
    assign rd_adres = buyruk_w[11:7];
    assign rs1_adres = buyruk_w[19:15];
    assign rs2_adres = buyruk_w[24:20];

    // sadece saatte yazmak iyi bir pratik değil
    // normalde tümlesik devre kismi ayrilip saatte sadece atama yapilmasi gerekir
    always @(posedge saat) begin
        // resette program sayaci ve yazmaclar sifirlaniyor
        if(reset) begin   
            program_sayaci = 32'h00000000;
            for (j=0; j < 32; j = j+1) begin
                yazmaclar_r[j] = 32'h00000000;
            end
        end
        else begin
            // KAREAL.TOPLA
            if(opcode == 7'b1110111 && funct3 == 3'b000 && funct7 == 7'b0000000) begin
                yazmaclar_r[rd_adres] <= yazmaclar_r[rs1_adres] * yazmaclar_r[rs1_adres] +
                                         yazmaclar_r[rs2_adres] * yazmaclar_r[rs2_adres];
                program_sayaci <= program_sayaci + 4;
            end
            // CARP.CIKAR
            else if(opcode == 7'b1110111 && funct3 == 3'b001 && funct7 == 7'b1000010) begin
                yazmaclar_r[rd_adres] <= yazmaclar_r[rs1_adres] * yazmaclar_r[rs2_adres] -
                                         yazmaclar_r[rs1_adres];
                program_sayaci <= program_sayaci + 4;
            end
            // SIFRELE
            else if(opcode == 7'b1110111 && funct3 == 3'b100) begin
                yazmaclar_r[rd_adres] <= yazmaclar_r[rs1_adres] ^ {{20{buyruk_w[31]}}, buyruk_w[31:20]};
                program_sayaci <= program_sayaci + 4;
            end
            // TASI
            else if(opcode == 7'b1110111 && funct3 == 3'b101) begin
                yazmaclar_r[rd_adres] <= {{20{1'b0}}, buyruk_w[31:20]};
                program_sayaci <= program_sayaci + 4;
            end
            // BITSAY
            else if(opcode == 7'b1110111 && funct3 == 3'b010 && buyruk_w[30:20] == 11'b10101010101) begin
                yazmaclar_r[rd_adres] <= bitsay(buyruk_w[31], yazmaclar_r[rs1_adres]);
                program_sayaci <= program_sayaci + 4;
            end
            // SEC.DALLAN
            else if(opcode == 7'b1111111 && funct3 == 3'b111) begin
                case(buyruk_w[31:30])
                    // NOP GIBI
                    2'b00: begin
                        program_sayaci <= program_sayaci + 4;
                    end
                    // BEQ GIBI
                    2'b01: begin
                        if(yazmaclar_r[rs1_adres] == yazmaclar_r[rs2_adres])
                            program_sayaci <= {{21{buyruk_w[7]}}, buyruk_w[7], buyruk_w[29:25], buyruk_w[11:8], 1'b0};
                        else
                            program_sayaci <= program_sayaci + 4;
                    end
                    // BLT GIBI
                    2'b10: begin
                        if($signed(yazmaclar_r[rs1_adres]) < $signed(yazmaclar_r[rs2_adres]))
                            program_sayaci <= {{21{buyruk_w[7]}}, buyruk_w[7], buyruk_w[29:25], buyruk_w[11:8], 1'b0};
                        else
                            program_sayaci <= program_sayaci + 4;
                    end
                    // BGE GIBI
                    2'b11: begin
                        if($signed(yazmaclar_r[rs1_adres]) >= $signed(yazmaclar_r[rs2_adres]))
                            program_sayaci <= {{21{buyruk_w[7]}}, buyruk_w[7], buyruk_w[29:25], buyruk_w[11:8], 1'b0};
                        else
                            program_sayaci <= program_sayaci + 4;
                    end
                endcase
            end
            // IKIKAT.ATLA
            else if(opcode == 7'b1111111) begin
                yazmaclar_r[rd_adres] <= program_sayaci + 4;
                program_sayaci <= {{10{buyruk_w[31]}}, buyruk_w[31], buyruk_w[19:12], buyruk_w[20], buyruk_w[30:21], 1'b0, 1'b0};
            end
        end

        // RISCV mimarisinde x0 yazmaci her zaman 0
        yazmaclar_r[0] <= 0;
    end

    // bit sayma islemi icin bir fonksiyon
    integer k;
    reg [31:0] bir_sayisi = 0;
    function [31:0] bitsay;
        input s1;
        input [31:0] deger;
        begin
            bir_sayisi = 0;
            for(k = 0; k < 32; k = k+1) begin
                if(deger[k])begin
                    bir_sayisi = bir_sayisi + 1;
                end
            end
            if (s1)
                bitsay = bir_sayisi;
            else
                bitsay = 32 - bir_sayisi;
        end
    endfunction
endmodule
