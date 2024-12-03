`timescale 1ns / 1ps

module istasyon #(parameter ARAC_SAYISI = 200)(
    input saat,
    input reset,
    input [1:0] islem,
    output reg amorti = 0,
    output reg [4:0] amorti_gunu = 0
    );
    
    localparam YAKIT = 0,
               LASTIK = 1,
               YIKAMA = 2,
               MARKET = 3;
               
    localparam YAKIT_KAR = 250,
               LASTIK_KAR = 0,
               YIKAMA_KAR = 50,
               MARKET_KAR = 30;
    
    reg [4:0] gun = 0, gun_sonraki = 0;
    reg [$clog2(7500*ARAC_SAYISI)-1:0] toplam_kar = 0, toplam_kar_sonraki = 0; // max kar = 7500 * ARAC_SAYISI
    reg [1:0] son_islem = 0, son_islem_sonraki = 0;
    reg amorti_sonraki = 0;
    reg [4:0] amorti_gunu_sonraki = 0;
    
    reg bitti = 0, bitti_sonraki = 0;
    
    always @* begin
        amorti_sonraki = amorti;
        amorti_gunu_sonraki = amorti_gunu;
        bitti_sonraki = bitti;
    
        if(son_islem == YIKAMA) begin
            toplam_kar_sonraki = toplam_kar + ARAC_SAYISI * YAKIT_KAR;
            son_islem_sonraki = YAKIT;
        end
        else begin
            case(islem)
                YAKIT:  toplam_kar_sonraki = toplam_kar + ARAC_SAYISI * YAKIT_KAR;
                LASTIK: toplam_kar_sonraki = toplam_kar + ARAC_SAYISI * LASTIK_KAR;
                YIKAMA: toplam_kar_sonraki = toplam_kar + ARAC_SAYISI * YIKAMA_KAR;
                MARKET: toplam_kar_sonraki = toplam_kar + ARAC_SAYISI * MARKET_KAR; 
            endcase
            son_islem_sonraki = islem;
        end
        
        // normalde böyle olmaması gerekiyor ama
        // odevden iki sekilde de anlasilabilir 
        // o yuzden son islem, islem girisine gore de alinabilir
        // son_islem_sonraki = islem;
        
        gun_sonraki = gun + 1;
        
        if(toplam_kar_sonraki >= 200000 && !bitti_sonraki && gun_sonraki <= 30) begin
            amorti_sonraki = 1;
            amorti_gunu_sonraki = gun_sonraki;
            bitti_sonraki = 1;
        end
    end
    
    always @(posedge saat) begin
        if(reset) begin
            gun <= 0;
            toplam_kar <= 0;
            son_islem <= 0;
            amorti <= 0;
            amorti_gunu <= 0;
            bitti <= 0;
        end
        else begin
            gun <= gun_sonraki;
            toplam_kar <= toplam_kar_sonraki;
            son_islem <= son_islem_sonraki;
            amorti <= amorti_sonraki;
            amorti_gunu <= amorti_gunu_sonraki;
            bitti <= bitti_sonraki;
        end
    end
    
endmodule
