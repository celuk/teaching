`timescale 1ns / 1ps

module indirim(
    input  [12:0] urun_fiyati,
    input  [1:0]  pazarlik,
    input  [2:0]  musteri_tipi,
    input  [1:0]  musteri_davranisi,
    input  [3:0]  urun_tipi,
    output [19:0] indirimli_fiyat // {13 bit tam, 7 bit kurus}
    );
    
    reg [39:0] tam_kisim;
    reg [39:0] kurusluk_kisim;
    
    reg [1:0] indirim_sayisi; // max. 4 tane indirim yapilabilir
    reg [6:0] indirim_carpanlari [3:0];
    
    reg [6:0] max_indirim_carpani;
    
    assign indirimli_fiyat = {tam_kisim[12:0], kurusluk_kisim[6:0]};
    
    integer i;
    
    always @* begin
        tam_kisim = urun_fiyati;
        kurusluk_kisim = 0;
        
        indirim_sayisi = 0;
        
        for(i = 0; i < 4; i = i + 1) begin
            indirim_carpanlari[i] = 100;
        end
        
        max_indirim_carpani = 100;
        
        if(!(urun_tipi == 0 || urun_tipi == 2)) begin
            case(pazarlik)
                1: begin
                    indirim_carpanlari[indirim_sayisi] = 97;
                    indirim_sayisi = indirim_sayisi + 1;
                end
                2: begin
                    indirim_carpanlari[indirim_sayisi] = 92;
                    indirim_sayisi = indirim_sayisi + 1;
                end
                3: begin
                    indirim_carpanlari[indirim_sayisi] = 81;
                    indirim_sayisi = indirim_sayisi + 1;
                end
                default: begin
                
                end
            endcase
            
            case(musteri_tipi)
                0: begin
                    indirim_carpanlari[indirim_sayisi] = 98;
                    indirim_sayisi = indirim_sayisi + 1;
                end
                1: begin
                    indirim_carpanlari[indirim_sayisi] = 90;
                    indirim_sayisi = indirim_sayisi + 1;
                end
                2: begin
                    indirim_carpanlari[indirim_sayisi] = 85;
                    indirim_sayisi = indirim_sayisi + 1;
                    indirim_carpanlari[indirim_sayisi] = 90;
                    indirim_sayisi = indirim_sayisi + 1;
                end
                4: begin
                    indirim_carpanlari[indirim_sayisi] = 99;
                    indirim_sayisi = indirim_sayisi + 1;
                end
                default: begin
                
                end
            endcase
            
            case(musteri_davranisi)
                2: begin
                    indirim_carpanlari[indirim_sayisi] = 95;
                    indirim_sayisi = indirim_sayisi + 1;
                end
                default: begin
                
                end
            endcase
        end
        
        if(musteri_davranisi == 0) begin
            if(!(urun_tipi == 0 || urun_tipi == 2)) begin
                max_indirim_carpani = indirim_carpanlari[0];
                
                for(i = 0; i < 4; i = i + 1) begin
                    if(max_indirim_carpani > indirim_carpanlari[i]) begin
                        max_indirim_carpani = indirim_carpanlari[i];
                    end
                end
            end
            
            tam_kisim = urun_fiyati * 110 * max_indirim_carpani / 10000;
            kurusluk_kisim = (urun_fiyati * 110 * max_indirim_carpani / 100) % 100;
            
        end
        else begin
            if(urun_tipi == 5 || urun_tipi == 8) begin
                if( ((indirim_carpanlari[0] * 
                      indirim_carpanlari[1] * 
                      indirim_carpanlari[2] * 
                      indirim_carpanlari[3]) 
                      / 1000000) < 75) begin
                    
                    indirim_carpanlari[0] = 75;
                    indirim_carpanlari[1] = 100;
                    indirim_carpanlari[2] = 100;
                    indirim_carpanlari[3] = 100;
                end
            end
            
            tam_kisim = urun_fiyati *
                        indirim_carpanlari[0] * 
                        indirim_carpanlari[1] * 
                        indirim_carpanlari[2] * 
                        indirim_carpanlari[3] / 100000000;
            
            kurusluk_kisim = (urun_fiyati *
                             indirim_carpanlari[0] * 
                             indirim_carpanlari[1] * 
                             indirim_carpanlari[2] * 
                             indirim_carpanlari[3] / 1000000) % 100;
        end

        if(tam_kisim >= 5000) begin
            tam_kisim = 5000;
            kurusluk_kisim = 0;
        end
    end
    
endmodule
