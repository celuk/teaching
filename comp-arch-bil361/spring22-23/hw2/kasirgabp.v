`timescale 1ns / 1ps

/* 
 * TOBB Ekonomi ve Teknoloji Universitesi 
 * Bilgisayar Muhendisligi Bolumu 
 * BIL361 – Bilgisayar Mimarisi ve Organizasyonu 
 * 2022-2023 Ogretim Yili Bahar Donemi 
 * Odev 2 
 * 13.03.2023 
 */

// giris cikislari degistirmeyin
module kasirgabp(
	input saat,
	input reset, // tablolari ve yazmaclari sifirla
	input [31:0] buyruk_adresi, // yani aslinda program sayaci
	input onceki_buyruk_atladi, // genel gecmis yazmacinda tutmalisiniz, 1 --> atladi, 0 --> atlamadi
	output ongoru, // su andaki buyrugun dallanma ongorusu, 1 --> atlasin, 0 --> atlamasin
);
    
    // odevdeki gorselde verildigi sekilde
    // bunlari baslangicta 0'dan baslatin
    reg [2:0] genel_gecmis_yazmaci; // 3 bitlik genel gecmis yazmaci
    reg [1:0] cift_kutuplu_sayac_tablosu [7:0]; // 2 bitlik sayaclar, 8 satir cunku 3 bit xor yapilarak tabloya erisiliyor
    // 00 -> G.T, 01 -> Z.T, 10 -> Z.A, 11 -> G.A
 
    wire [2:0] ongoru_tablo_adresi; // cift kutuplu sayac_tablosunda erisilecek adres
    assign ongoru_tablo_adresi = genel_gecmis_yazmaci ^ buyruk_adresi[4:2];
    
    // TODO iclerini GShare dallanma öngörüsü yapacak sekilde doldurmaniz gerekiyor
    always@* begin
        
    end
    
    always@(posedge saat) begin
        if(reset) begin
           
        end
        else begin
            
        end
    end
endmodule
