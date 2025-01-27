`timescale 1ns / 1ps

module uretim(
    input saat,
    input reset,
    input [2:0] govde,
    input [2:0] ekran,
    input [2:0] batarya,
    input isletim_sistemi,
    input [9:0] kapasite,
    input bandrol,
    output reg kalite,
    output [2:0] maliyet,
    output [9:0] telefon_sayisi
    );
    
    wire bitti_montaj;
    wire bitti_kontrol;
    wire bitti_paketleme;

    wire montaja_uygun;
    wire [1:0] uretim_tipi;
    wire montaj_kalitesi;
    montaj montaj_dut(
        .saat(saat),
        .reset(reset),
        .basla(1'b1),
        .govde(govde),
        .ekran(ekran),
        .batarya(batarya),
        .bitti(bitti_montaj),
        .montaja_uygun(montaja_uygun),
        .uretim_tipi(uretim_tipi),
        .montaj_kalitesi(montaj_kalitesi)
    );

    reg isletim_sistemi1;
    wire kalite1;
    wire kontrol_sonucu;
    kontrol kontrol_dut(
        .saat(saat),
        .reset(reset),
        .basla(bitti_montaj),
        .montaja_uygun(montaja_uygun),
        .uretim_tipi(uretim_tipi),
        .montaj_kalitesi(montaj_kalitesi),
        .isletim_sistemi(isletim_sistemi1),
        .bitti(bitti_kontrol),
        .kalite(kalite1),
        .kontrol_sonucu(kontrol_sonucu)
    );

    reg [9:0] kapasite1;
    reg [9:0] kapasite2;
    reg bandrol1;
    reg bandrol2;
    paketleme paketleme_dut(
        .saat(saat),
        .reset(reset),
        .basla(bitti_kontrol),
        .kontrol_sonucu(kontrol_sonucu),
        .kapasite(kapasite2),
        .bandrol(bandrol2),
        .bitti(bitti_paketleme),
        .maliyet(maliyet),
        .telefon_sayisi(telefon_sayisi)
    );

    always @(posedge saat) begin
        if(reset) begin
            isletim_sistemi1 <= 0;
            kapasite1 <= 0;
            kapasite2 <= 0;
            bandrol1 <= 0;
            bandrol2 <= 0;

            kalite <= 0;
        end
        else begin
            isletim_sistemi1 <= isletim_sistemi;
            kapasite1 <= kapasite;
            kapasite2 <= kapasite1;
            bandrol1 <= bandrol;
            bandrol2 <= bandrol1;

            kalite <= kalite1;
        end
    end
    
endmodule
