`timescale 1ns / 1ps

module pisir(
    input saat,
    input reset,
    input basla,
    input mayali,
    input tuzlu,
    output reg kabarik = 0,
    output reg cikis_tuzlu = 0,
    output reg [6:0] pizza_sayisi = 0,
    output reg bitti = 0
    );
    
    reg kabarik_sonraki = 0;
    reg cikis_tuzlu_sonraki = 0;
    reg [6:0] pizza_sayisi_sonraki = 0;
    reg bitti_sonraki = 0;
    
    always @* begin
        kabarik_sonraki = 0;
        cikis_tuzlu_sonraki = 0;
        pizza_sayisi_sonraki = pizza_sayisi;
        bitti_sonraki = 0;
        
        
        if(basla) begin
            if(tuzlu) begin
                cikis_tuzlu_sonraki = 1;
            end
            else begin
                if(mayali) begin
                    kabarik_sonraki = 1;
                end
                
                if(pizza_sayisi < 100) begin
                    pizza_sayisi_sonraki = pizza_sayisi + 1;
                end
            end
            
            bitti_sonraki = 1;
        end
    end
    
    always @(posedge saat) begin
        if(reset) begin
            kabarik <= 0;
            cikis_tuzlu <= 0;
            pizza_sayisi <= 0;
            bitti <= 0;
        end
        else begin
            kabarik <= kabarik_sonraki;
            cikis_tuzlu <= cikis_tuzlu_sonraki;
            pizza_sayisi <= pizza_sayisi_sonraki;
            bitti <= bitti_sonraki;
        end
    end
    
endmodule
