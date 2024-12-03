`timescale 1ns / 1ps

module bavul(
    input  saat,
    input  reset,
    input  basla,
    input  [5:0] agirlik,
    output reg [7:0] ucret = 0,
    output reg bitti = 0
    );
    
    reg [11:0] toplam_yuk = 0; // 50 yolcu icin max. 3150 --> 12 bit, 50'den sonra ucak kalkiyor zaten
    reg [11:0] toplam_yuk_sonraki = 0;
    
    reg [7:0] ucret_sonraki = 0;
    reg bitti_sonraki = 0;
    
    always @* begin
        ucret_sonraki = 0;
        bitti_sonraki = 0;
        toplam_yuk_sonraki = toplam_yuk;
        
        if(basla) begin
            toplam_yuk_sonraki = toplam_yuk + agirlik;
            
            if(toplam_yuk_sonraki < 60) begin
                ucret_sonraki = 45;
            end
            else begin
                ucret_sonraki = (agirlik*agirlik) / 20;
            end
            
            bitti_sonraki = 1;
        end
    end
    
    always @(posedge saat) begin
        if(reset) begin
            ucret <= 0;
            bitti <= 0;
            toplam_yuk <= 0;
        end
        else begin
            ucret <= ucret_sonraki;
            bitti <= bitti_sonraki;
            toplam_yuk <= toplam_yuk_sonraki;
        end
    end
    
endmodule
