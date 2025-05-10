`timescale 1ns / 1ps

module tb_kapisma(

    );
    
    reg [5:0] sag_adimlar;
    reg [5:0] asagi_adimlar;
    reg [3:0] sayi;

    wire [1:0] kazanan;
    wire [4:0] toplam_puan;
    kapisma kapisma_dut(
        .sag_adimlar(sag_adimlar),
        .asagi_adimlar(asagi_adimlar),
        .sayi(sayi),
        .kazanan(kazanan),
        .toplam_puan(toplam_puan)
    );

    wire [1:0] kazanan_test;
    wire [4:0] toplam_puan_test;
    kapisma_test kapisma_test_dut(
        .sag_adimlar(sag_adimlar),
        .asagi_adimlar(asagi_adimlar),
        .sayi(sayi),
        .kazanan(kazanan_test),
        .toplam_puan(toplam_puan_test)
    );
    
    integer i;
    integer j;
    integer k;
    
    integer passes = 0;
    integer fails = 0;
    
    initial begin
        for(i=0; i<64; i=i+1) begin
            sag_adimlar = i;
            for(j=0; j<64; j=j+1) begin
                asagi_adimlar = j;
                for(k=1; k<=9; k=k+1) begin
                    sayi = k; #1;
                    if(kazanan == kazanan_test && toplam_puan == toplam_puan_test) begin
                        passes = passes + 1;
                    end
                    else begin
                        fails = fails + 1;
                    end
                end
            end
        end
        
        $display("\n%d passes, %d fails\n", passes, fails);
        
        if(passes == 36864) $display("ALL PASSED!\n");
        if(fails  == 36864) $display("all failed!\n");
        
        $finish;
    end
    
endmodule

module kapisma_test(
    input [5:0] sag_adimlar,
    input [5:0] asagi_adimlar,
    input [3:0] sayi,
    output reg [1:0] kazanan,
    output reg [4:0] toplam_puan
    );

    wire [3:0] sayi_tahmin1;
    wire tahmin_dogru1;
    tahmin oyuncu1(
        .sag_adim(sag_adimlar[5:4]),
        .asagi_adim(asagi_adimlar[5:4]),
        .sayi(sayi),
        .sayi_tahmin(sayi_tahmin1),
        .tahmin_dogru(tahmin_dogru1)
    );

    wire [3:0] sayi_tahmin2;
    wire tahmin_dogru2;
    tahmin oyuncu2(
        .sag_adim(sag_adimlar[3:2]),
        .asagi_adim(asagi_adimlar[3:2]),
        .sayi(sayi),
        .sayi_tahmin(sayi_tahmin2),
        .tahmin_dogru(tahmin_dogru2)
    );

    wire [3:0] sayi_tahmin3;
    wire tahmin_dogru3;
    tahmin oyuncu3(
        .sag_adim(sag_adimlar[1:0]),
        .asagi_adim(asagi_adimlar[1:0]),
        .sayi(sayi),
        .sayi_tahmin(sayi_tahmin3),
        .tahmin_dogru(tahmin_dogru3)
    );

    reg [4:0] pozitif_toplam;
    reg [4:0] negatif_toplam;

    always @* begin
        kazanan = 0;
        toplam_puan = 0;
        pozitif_toplam = 0;
        negatif_toplam = 0;

        if(tahmin_dogru1) begin
            kazanan = 1;
        end
        else if(tahmin_dogru3) begin
            kazanan = 3;
        end
        else if(tahmin_dogru2) begin
            kazanan = 2;
        end

        if(tahmin_dogru1) begin
            pozitif_toplam = pozitif_toplam + sayi_tahmin1;
        end
        else begin
            negatif_toplam = negatif_toplam + sayi_tahmin1;
        end

        if(tahmin_dogru3) begin
            pozitif_toplam = pozitif_toplam + sayi_tahmin3;
        end
        else begin
            negatif_toplam = negatif_toplam + sayi_tahmin3;
        end

        if(tahmin_dogru2) begin
            pozitif_toplam = pozitif_toplam + sayi_tahmin2;
        end
        else begin
            negatif_toplam = negatif_toplam + sayi_tahmin2;
        end

        if(pozitif_toplam > negatif_toplam) begin
            toplam_puan = pozitif_toplam - negatif_toplam;
        end
        else begin
            toplam_puan = 0;
        end
    end
endmodule
