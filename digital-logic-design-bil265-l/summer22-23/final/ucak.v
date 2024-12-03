`timescale 1ns / 1ps

module ucak(
    input  saat,
    input  reset,
    input  basla,
    input  o_yolcu,
    input  g_kimlik,
    output reg kalkis = 0,
    output reg bitti = 0
    );
    
    reg [5:0] o_yolcu_sayisi = 0; // max. 50, 50'den sonra hep 1 zaten
    reg [5:0] o_yolcu_sayisi_sonraki = 0;
    
    reg kalkis_sonraki = 0;
    reg bitti_sonraki = 0;
    
    always @* begin
        kalkis_sonraki = kalkis;
        bitti_sonraki = 0;
        o_yolcu_sayisi_sonraki = o_yolcu_sayisi;
        
        if(basla) begin
            if(o_yolcu && g_kimlik && o_yolcu_sayisi < 50) begin
                o_yolcu_sayisi_sonraki = o_yolcu_sayisi + 1;
            end
            
            if(o_yolcu_sayisi_sonraki >= 50) begin
                kalkis_sonraki = 1;
            end
            
            bitti_sonraki = 1;
        end
    end
    
    always @(posedge saat) begin
        if(reset) begin
            o_yolcu_sayisi <= 0;
            kalkis <= 0;
            bitti <= 0;
        end
        else begin
            o_yolcu_sayisi <= o_yolcu_sayisi_sonraki;
            kalkis <= kalkis_sonraki;
            bitti <= bitti_sonraki;
        end
    end
    
endmodule
