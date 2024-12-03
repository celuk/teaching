`timescale 1ns / 1ps

module sifreleme #(parameter BIT = 4)(
    input saat,
    input reset,
    input basla,
    input mod,
    input [BIT-1:0] veri,
    input [2:0] secim,
    
    output reg bit_cikisi,
    output reg gecerli
    );
    
    reg [63:0] sifreler [0:7];
    
    reg bit_cikisi_sonraki;
    reg gecerli_sonraki;
    
    // BIT en fazla 64 olabilir, o zaman 6 bit
    reg [5:0] sayac;
    reg [5:0] sayac_sonraki;
    
    reg [BIT-1:0] sifrelenmis_veri;
    reg [BIT-1:0] sifrelenmis_veri_sonraki;
    
    reg isleme_devam;
    reg isleme_devam_sonraki;
    
    initial begin
        sifreler[0] = 64'hBABA_1453_DEDE_1071;
        sifreler[1] = 64'hACAB_0909_BACA_0707;
        sifreler[2] = 64'hADAB_0606_DADA_0505;
        sifreler[3] = 64'hAAAA_0000_FFFF_5555;
        sifreler[4] = 64'hCAAA_0101_CAAA_0101;
        sifreler[5] = 64'hAACA_0606_AACA_0606;
        sifreler[6] = 64'hCAAA_1717_CAAA_1717;
        sifreler[7] = 64'hAAAA_0000_FFFF_5555;
    end
    
    always @* begin
        bit_cikisi_sonraki = 0;
        gecerli_sonraki = 0;
        sayac_sonraki = sayac;
        sifrelenmis_veri_sonraki = sifrelenmis_veri;
        isleme_devam_sonraki = isleme_devam;
        
        if(~isleme_devam) begin
            if(basla) begin
                if(mod) begin
                    sifrelenmis_veri_sonraki = veri ^ sifreler[secim][BIT-1:0];
                    sifrelenmis_veri_sonraki = {sifrelenmis_veri_sonraki[BIT-3:0], sifrelenmis_veri_sonraki[BIT-1:BIT-2]};
                end
                else begin
                    sifrelenmis_veri_sonraki = veri ~^ sifreler[secim][BIT-1:0];
                    sifrelenmis_veri_sonraki = {sifrelenmis_veri_sonraki[1:0], sifrelenmis_veri_sonraki[BIT-1:2]};
                end
                sayac_sonraki = 0;
                isleme_devam_sonraki = 1;
            end
        end
        else begin // isleme_devam
            bit_cikisi_sonraki = sifrelenmis_veri[sayac];
            gecerli_sonraki = 1;
            sayac_sonraki = sayac + 1;
            
            if(sayac == BIT-1) begin
                isleme_devam_sonraki = 0;
            end
        end
    end
    
    always@(posedge saat) begin
        if(reset) begin
            bit_cikisi <= 0;
            gecerli <= 0;
            sayac <= 0;
            sifrelenmis_veri <= 0;
            isleme_devam <= 0;
        end
        else begin
            bit_cikisi <= bit_cikisi_sonraki;
            gecerli <= gecerli_sonraki;
            sayac <= sayac_sonraki;
            sifrelenmis_veri <= sifrelenmis_veri_sonraki;
            isleme_devam <= isleme_devam_sonraki;
        end
    end
endmodule
