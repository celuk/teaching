`timescale 1ns / 1ps

module sayac_boru(
    input saat,
    input reset,
    input [7:0] baslangic_degeri,
    input yon,
    input [2:0] miktar,
    output [7:0] sayac1_sonuc,
    output [7:0] sayac2_sonuc,
    output bitti
    );

    wire sayac1_hazir;
    wire [2:0] sayac1_cikis_miktar;
    wire sayac1_cikis_yon;
    sayac sayac1(
        .saat(saat),
        .reset(reset),
        .basla(1'b1),
        .baslangic_degeri(baslangic_degeri),
        .yon(yon),
        .miktar(miktar),
        .sonuc(sayac1_sonuc),
        .hazir(sayac1_hazir),
        .mesgul(), // onemsiz
        .cikis_miktar(sayac1_cikis_miktar),
        .cikis_yon(sayac1_cikis_yon)
    );

    reg sayac2_basla;
    reg [7:0] sayac2_baslangic_degeri;
    reg sayac2_yon;
    reg [2:0] sayac2_miktar;
    wire sayac2_mesgul;
    sayac sayac2(
        .saat(saat),
        .reset(reset),
        .basla(sayac2_basla && ~sayac1_hazir), // sayac1'in hazir oldugu cevrimden sonraki cevrim baslasin
        .baslangic_degeri(sayac2_baslangic_degeri),
        .yon(sayac2_yon),
        .miktar(sayac2_miktar),
        .sonuc(sayac2_sonuc),
        .hazir(bitti),
        .mesgul(sayac2_mesgul),
        .cikis_miktar(), // onemsiz
        .cikis_yon() // onemsiz
    );

    reg sayac1_hazir_tut;

    always @(posedge saat) begin
        if(reset) begin
            sayac2_basla <= 0;
            sayac2_baslangic_degeri <= 0;
            sayac2_yon <= 0;
            sayac2_miktar <= 0;
            sayac1_hazir_tut <= 0;
        end
        else begin
            sayac1_hazir_tut <= sayac2_basla ? 0 : (sayac1_hazir ? 1 : sayac1_hazir_tut);
            sayac2_basla <= ~sayac2_mesgul && sayac1_hazir_tut;
            sayac2_baslangic_degeri <= sayac1_hazir ? sayac1_sonuc : sayac2_baslangic_degeri;
            sayac2_yon <= sayac1_hazir ? ~sayac1_cikis_yon : sayac2_yon;
            sayac2_miktar <= sayac1_hazir ? 
                             (sayac1_cikis_miktar == 7 ? 7 : sayac1_cikis_miktar+1) : sayac2_miktar;
        end
    end
    
endmodule
