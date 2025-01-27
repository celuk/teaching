`timescale 1ns / 1ps

module decoder #(parameter N = 30)(
    input clk,
    input rst,
    input basla,
    input mod,
    input [N-1:0] gelen_veri,
    output reg [N-1:0] cikan_veri,
    output reg bitti
    );

    reg [N-1:0] cikan_veri_sonraki;
    reg bitti_sonraki;

    reg verial_bitti;
    reg verial_bitti_sonraki;

    reg [2:0] sifrelenmis_veri [N/3-1:0];
    reg [2:0] sifrelenmis_veri_sonraki [N/3-1:0];

    reg verial_devam;
    reg verial_devam_sonraki;

    reg coz_devam;
    reg coz_devam_sonraki;

    reg [4:0] eleman_sayaci = N/3 - 1; // max 20 --> 5 bit, N=60
    reg [4:0] eleman_sayaci_sonraki;

    // cozme islemi icin su anki sifrelenmis karakterin sayisal degeri, bir sonraki karakterin sola kaydirma miktari olacak
    reg [2:0] kaydirma_miktari; // max 7 --> 3 bit
    reg [2:0] kaydirma_miktari_sonraki;

    integer i;

    always @* begin
        cikan_veri_sonraki = cikan_veri;
        bitti_sonraki = 0;
        verial_bitti_sonraki = 0;
        for(i=0; i<=(N/3-1); i=i+1) begin
            sifrelenmis_veri_sonraki[i] = sifrelenmis_veri[i];
        end
        verial_devam_sonraki = verial_devam;
        coz_devam_sonraki = coz_devam;
        eleman_sayaci_sonraki = eleman_sayaci;
        kaydirma_miktari_sonraki = 1;

        // VERI ALMA
        if(~verial_devam) begin
            if(basla) begin
                if(mod) begin
                    // ilk cevrimde sadece ilk elemani al, kalanini verial_devam kisminda al
                    sifrelenmis_veri_sonraki[eleman_sayaci] = gelen_veri[2:0];
                    eleman_sayaci_sonraki = eleman_sayaci - 1; // ilk eleman alindi
                    verial_devam_sonraki = 1;
                end
                else begin // mod == 0
                    // tek cevrimde hepsini ata
                    for(i=0; i<=(N/3-1); i=i+1) begin
                        sifrelenmis_veri_sonraki[i] = gelen_veri[(i*3)+:3];
                    end
                    verial_devam_sonraki = 0;
                    verial_bitti_sonraki = 1;
                    eleman_sayaci_sonraki = N/3 - 1; // cozme en anlamlidan basliyor
                end
            end
        end
        else if(verial_devam) begin
            eleman_sayaci_sonraki = eleman_sayaci - 1;

            sifrelenmis_veri_sonraki[eleman_sayaci] = gelen_veri[2:0];
            
            if(eleman_sayaci == 0) begin
                verial_devam_sonraki = 0;
                verial_bitti_sonraki = 1;
                eleman_sayaci_sonraki = N/3 - 1; // cozme en anlamlidan basliyor
            end
        end

        // COZME
        if(verial_bitti && ~coz_devam) begin
            kaydirma_miktari_sonraki = sifrelenmis_veri[eleman_sayaci];

            if(sifrelenmis_veri[eleman_sayaci] >= 1) begin
                cikan_veri_sonraki[(eleman_sayaci*3)+:3] = sifrelenmis_veri[eleman_sayaci] - 1;
            end
            else begin
                cikan_veri_sonraki[(eleman_sayaci*3)+:3] = 3'b111;
            end

            eleman_sayaci_sonraki = eleman_sayaci - 1; // ilk eleman cozuldu
            coz_devam_sonraki = 1;
        end
        else if(coz_devam) begin
            eleman_sayaci_sonraki = eleman_sayaci - 1;

            kaydirma_miktari_sonraki = sifrelenmis_veri[eleman_sayaci];

            if(sifrelenmis_veri[eleman_sayaci][2:0] >= kaydirma_miktari) begin
                cikan_veri_sonraki[(eleman_sayaci*3)+:3] = sifrelenmis_veri[eleman_sayaci] - kaydirma_miktari;
            end
            else begin
                cikan_veri_sonraki[(eleman_sayaci*3)+:3] = sifrelenmis_veri[eleman_sayaci] + (3'b111 - kaydirma_miktari) + 1;
            end
            
            if(eleman_sayaci == 0) begin
                coz_devam_sonraki = 0;
                bitti_sonraki = 1;
                eleman_sayaci_sonraki = N/3 - 1;
            end
        end
    end

    always @(posedge clk) begin
        if(rst) begin
            cikan_veri <= 0;
            bitti <= 0;

            verial_bitti <= 0;

            for(i=0; i<=(N/3-1); i=i+1) begin
                sifrelenmis_veri[i] <= 0;
            end

            verial_devam <= 0;
            coz_devam <= 0;

            eleman_sayaci <= N/3 - 1;

            kaydirma_miktari <= 1;
        end
        else begin
            cikan_veri <= cikan_veri_sonraki;
            bitti <= bitti_sonraki;

            verial_bitti <= verial_bitti_sonraki;

            for(i=0; i<=(N/3-1); i=i+1) begin
                sifrelenmis_veri[i] <= sifrelenmis_veri_sonraki[i];
            end

            verial_devam <= verial_devam_sonraki;
            coz_devam <= coz_devam_sonraki;

            eleman_sayaci <= eleman_sayaci_sonraki;

            kaydirma_miktari <= kaydirma_miktari_sonraki;
        end
    end

endmodule
