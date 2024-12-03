`timescale 1ns / 1ps

`define ADRES         63:32
`define BUYRUK        31:0

// farkli bir program verecekseniz vereceginiz programdaki statik buyruk sayisina gore degistirin
`define BUYRUK_SAYISI 13

module tb_ornek();

    reg saat;
    reg reset;
    reg [31:0] buyruk;
    wire [31:0] program_sayaci;
    wire [1023:0] yazmaclar;

    // modul ismini "kasirga" yerine soyadiniz olarak degistirmeniz lazim
    kasirga test(
        .saat(saat),
        .reset(reset),
        .buyruk(buyruk),
        .program_sayaci(program_sayaci),
        .yazmaclar(yazmaclar)
    );

    always begin
        saat = !saat;
        #5;
    end

    wire [31:0] yazmaclar_w [31:0];
    genvar i;
    generate 
        for (i = 0; i < 32; i = i + 1) begin
            assign yazmaclar_w[i] = yazmaclar[i*32 +: 32];
        end
    endgenerate

    reg [63:0] buyruk_bellegi [`BUYRUK_SAYISI-1 : 0];

    // farkli bir program verecekseniz BUYRUK_SAYISI degiskenini degistirip asagidakine benzer sekilde verebilirsiniz
    // ornek programdaki gibi farkli etiketleriniz varsa etiket adresini dogru vermeye dikkat edin
    initial begin
        // program sayacı ilk buyruk icin 00000000'dan basliyor
        buyruk_bellegi[0 ][`ADRES] = 32'h0000_0000; buyruk_bellegi[0 ][`BUYRUK] = 32'hf7_52_10_01; // tasi x5, x0, 17
        buyruk_bellegi[1 ][`ADRES] = 32'h0000_0004; buyruk_bellegi[1 ][`BUYRUK] = 32'h77_53_30_0f; // tasi x6, x0, 243
        buyruk_bellegi[2 ][`ADRES] = 32'h0000_0008; buyruk_bellegi[2 ][`BUYRUK] = 32'hf7_43_03_07; // sifrele x7, x6, 112
        buyruk_bellegi[3 ][`ADRES] = 32'h0000_000c; buyruk_bellegi[3 ][`BUYRUK] = 32'h77_93_72_84; // carp.cikar x6, x5, x7
        buyruk_bellegi[4 ][`ADRES] = 32'h0000_0010; buyruk_bellegi[4 ][`BUYRUK] = 32'h77_04_73_00; // kareal.topla x8, x6, x7
        buyruk_bellegi[5 ][`ADRES] = 32'h0000_0014; buyruk_bellegi[5 ][`BUYRUK] = 32'hf7_24_54_d5; // bitsay x9, x8, 1
        buyruk_bellegi[6 ][`ADRES] = 32'h0000_0018; buyruk_bellegi[6 ][`BUYRUK] = 32'h77_25_54_55; // bitsay x10, x8, 0
        buyruk_bellegi[7 ][`ADRES] = 32'h0000_001c; buyruk_bellegi[7 ][`BUYRUK] = 32'hff_17_1f_60; // ikikat.atla x15, 0x000f1e00
        // 0x001e3c00:
        buyruk_bellegi[8 ][`ADRES] = 32'h001e_3c00; buyruk_bellegi[8 ][`BUYRUK] = 32'h77_13_a3_84; // carp.cikar x6, x6, x10
        buyruk_bellegi[9 ][`ADRES] = 32'h001e_3c04; buyruk_bellegi[9 ][`BUYRUK] = 32'h7f_7a_64_90; // sec.dallan x8, x6, 0x00000114
        buyruk_bellegi[10][`ADRES] = 32'h001e_3c08; buyruk_bellegi[10][`BUYRUK] = 32'h77_03_a3_00; // kareal.topla x6, x6, x10
        buyruk_bellegi[11][`ADRES] = 32'h001e_3c0c; buyruk_bellegi[11][`BUYRUK] = 32'hff_17_1f_60; // ikikat.atla x15, 0x000f1e00
        // 0x00000114:
        buyruk_bellegi[12][`ADRES] = 32'h0000_0114; buyruk_bellegi[12][`BUYRUK] = 32'h7f_fa_10_10; // sec.dallan x1, x1, 0x00000114, 0
    end

    integer j;
    initial begin
        saat = 0;

        reset = 1;
        #100;

        // program baslangicinda ilk buyruk getiriliyor
        reset = 0;
        buyruk = buyruk_bellegi[0][`BUYRUK]; #10;

        $display("Program Sayaci: 0x00000000");
        $display("Buyruk: 0x%x", buyruk);
        $display("YAZMAC DEGERLERI");
        $display("x0:  %d", yazmaclar_w[0 ]);
        $display("x1:  %d", yazmaclar_w[1 ]);
        $display("x2:  %d", yazmaclar_w[2 ]);
        $display("x3:  %d", yazmaclar_w[3 ]);
        $display("x4:  %d", yazmaclar_w[4 ]);
        $display("x5:  %d", yazmaclar_w[5 ]);
        $display("x6:  %d", yazmaclar_w[6 ]);
        $display("x7:  %d", yazmaclar_w[7 ]);
        $display("x8:  %d", yazmaclar_w[8 ]);
        $display("x9:  %d", yazmaclar_w[9 ]);
        $display("x10: %d", yazmaclar_w[10]);
        $display("x11: %d", yazmaclar_w[11]);
        $display("x12: %d", yazmaclar_w[12]);
        $display("x13: %d", yazmaclar_w[13]);
        $display("x14: %d", yazmaclar_w[14]);
        $display("x15: %d", yazmaclar_w[15]);
        $display("x16: %d", yazmaclar_w[16]);
        $display("x17: %d", yazmaclar_w[17]);
        $display("x18: %d", yazmaclar_w[18]);
        $display("x19: %d", yazmaclar_w[19]);
        $display("x20: %d", yazmaclar_w[20]);
        $display("x21: %d", yazmaclar_w[21]);
        $display("x22: %d", yazmaclar_w[22]);
        $display("x23: %d", yazmaclar_w[23]);
        $display("x24: %d", yazmaclar_w[24]);
        $display("x25: %d", yazmaclar_w[25]);
        $display("x26: %d", yazmaclar_w[26]);
        $display("x27: %d", yazmaclar_w[27]);
        $display("x28: %d", yazmaclar_w[28]);
        $display("x29: %d", yazmaclar_w[29]);
        $display("x30: %d", yazmaclar_w[30]);
        $display("x31: %d\n", yazmaclar_w[31]);
        $display("Program Sayaci: 0x%x", program_sayaci);

        // programin devami
        // ilk buyruk getirildikten sonraki program sayaci 4 olmali
        for(j = 0; j < `BUYRUK_SAYISI; j = j+1) begin
            // bir sonraki buyrugun program sayaci ile buyruk getiriliyor
            if(program_sayaci == buyruk_bellegi[j][`ADRES]) begin
                buyruk = buyruk_bellegi[j][`BUYRUK]; #10;

                // atlama ya da dallanma buyruguysa adresi tekrar kontrol et, cunku geriye gitmis olabilir
                if(buyruk[30:24] == 7'b1111111) begin
                    j = 0;
                end

                $display("Buyruk: 0x%x", buyruk);
                $display("YAZMAC DEGERLERI");
                $display("x0:  %d", yazmaclar_w[0 ]);
                $display("x1:  %d", yazmaclar_w[1 ]);
                $display("x2:  %d", yazmaclar_w[2 ]);
                $display("x3:  %d", yazmaclar_w[3 ]);
                $display("x4:  %d", yazmaclar_w[4 ]);
                $display("x5:  %d", yazmaclar_w[5 ]);
                $display("x6:  %d", yazmaclar_w[6 ]);
                $display("x7:  %d", yazmaclar_w[7 ]);
                $display("x8:  %d", yazmaclar_w[8 ]);
                $display("x9:  %d", yazmaclar_w[9 ]);
                $display("x10: %d", yazmaclar_w[10]);
                $display("x11: %d", yazmaclar_w[11]);
                $display("x12: %d", yazmaclar_w[12]);
                $display("x13: %d", yazmaclar_w[13]);
                $display("x14: %d", yazmaclar_w[14]);
                $display("x15: %d", yazmaclar_w[15]);
                $display("x16: %d", yazmaclar_w[16]);
                $display("x17: %d", yazmaclar_w[17]);
                $display("x18: %d", yazmaclar_w[18]);
                $display("x19: %d", yazmaclar_w[19]);
                $display("x20: %d", yazmaclar_w[20]);
                $display("x21: %d", yazmaclar_w[21]);
                $display("x22: %d", yazmaclar_w[22]);
                $display("x23: %d", yazmaclar_w[23]);
                $display("x24: %d", yazmaclar_w[24]);
                $display("x25: %d", yazmaclar_w[25]);
                $display("x26: %d", yazmaclar_w[26]);
                $display("x27: %d", yazmaclar_w[27]);
                $display("x28: %d", yazmaclar_w[28]);
                $display("x29: %d", yazmaclar_w[29]);
                $display("x30: %d", yazmaclar_w[30]);
                $display("x31: %d\n", yazmaclar_w[31]);
                $display("Program Sayaci: 0x%x", program_sayaci);
            end
        end

        // programin sonunda yazmaclar ve program sayaci degerleri ekrana bastiriliyor
        $display("Son Buyruk Getirildikten Sonraki Program Sayaci: 0x%x", program_sayaci);
        $display("YAZMAC DEGERLERI");
        $display("x0:  %d", yazmaclar_w[0 ]);
        $display("x1:  %d", yazmaclar_w[1 ]);
        $display("x2:  %d", yazmaclar_w[2 ]);
        $display("x3:  %d", yazmaclar_w[3 ]);
        $display("x4:  %d", yazmaclar_w[4 ]);
        $display("x5:  %d", yazmaclar_w[5 ]);
        $display("x6:  %d", yazmaclar_w[6 ]);
        $display("x7:  %d", yazmaclar_w[7 ]);
        $display("x8:  %d", yazmaclar_w[8 ]);
        $display("x9:  %d", yazmaclar_w[9 ]);
        $display("x10: %d", yazmaclar_w[10]);
        $display("x11: %d", yazmaclar_w[11]);
        $display("x12: %d", yazmaclar_w[12]);
        $display("x13: %d", yazmaclar_w[13]);
        $display("x14: %d", yazmaclar_w[14]);
        $display("x15: %d", yazmaclar_w[15]);
        $display("x16: %d", yazmaclar_w[16]);
        $display("x17: %d", yazmaclar_w[17]);
        $display("x18: %d", yazmaclar_w[18]);
        $display("x19: %d", yazmaclar_w[19]);
        $display("x20: %d", yazmaclar_w[20]);
        $display("x21: %d", yazmaclar_w[21]);
        $display("x22: %d", yazmaclar_w[22]);
        $display("x23: %d", yazmaclar_w[23]);
        $display("x24: %d", yazmaclar_w[24]);
        $display("x25: %d", yazmaclar_w[25]);
        $display("x26: %d", yazmaclar_w[26]);
        $display("x27: %d", yazmaclar_w[27]);
        $display("x28: %d", yazmaclar_w[28]);
        $display("x29: %d", yazmaclar_w[29]);
        $display("x30: %d", yazmaclar_w[30]);
        $display("x31: %d", yazmaclar_w[31]);

        $finish;
    end
endmodule

/*

BU ORNEK PROGRAM ICIN SON CIKTI SU SEKILDE OLMALI:
(Vivado'da Tcl Console'da gorebilirsiniz)

Son Buyruk Getirildikten Sonraki Program Sayaci: 0x00000118
YAZMAC DEGERLERI
x0:           0
x1:           0
x2:           0
x3:           0
x4:           0
x5:          17
x6:   418103156
x7:         131
x8:     4901261
x9:          11
x10:         21
x11:          0
x12:          0
x13:          0
x14:          0
x15:    1981456
x16:          0
x17:          0
x18:          0
x19:          0
x20:          0
x21:          0
x22:          0
x23:          0
x24:          0
x25:          0
x26:          0
x27:          0
x28:          0
x29:          0
x30:          0
x31:          0

*/
