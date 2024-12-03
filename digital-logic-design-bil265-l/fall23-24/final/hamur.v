`timescale 1ns / 1ps

module hamur(
    input saat,
    input reset,
    input basla,
    input [5:0] un_miktari,
    input [7:0] su_miktari,
    input [2:0] tuz_miktari,
    input maya,
    output reg [1:0] kalinlik = 0,
    output reg mayali = 0,
    output reg tuzlu = 0,
    output reg bitti = 0
    );
    
    reg [1:0] kalinlik_sonraki = 0;
    reg mayali_sonraki = 0;
    reg tuzlu_sonraki = 0;
    reg bitti_sonraki = 0;
    
    reg [13:0] agirlik = 0;
    
    always @* begin
        kalinlik_sonraki = 0;
        mayali_sonraki = 0;
        tuzlu_sonraki = 0;
        bitti_sonraki = 0;
        
        agirlik = 0;
        
        if(basla) begin
            agirlik = un_miktari * su_miktari + tuz_miktari;
            
            if(maya) begin
                mayali_sonraki = 1;
                
                if(agirlik >= 10000) begin
                    kalinlik_sonraki = 2;
                end
                else if(agirlik < 10000 && agirlik >= 5000) begin
                    kalinlik_sonraki = 1;
                end
                else begin
                    kalinlik_sonraki = 0;
                end
            end
            else begin
                mayali_sonraki = 0;
                
                if(agirlik >= 8000) begin
                    kalinlik_sonraki = 2;
                end
                else if(agirlik < 8000 && agirlik >= 4000) begin
                    kalinlik_sonraki = 1;
                end
                else begin
                    kalinlik_sonraki = 0;
                end
            end
            
            if(tuz_miktari >= 5) begin
                tuzlu_sonraki = 1;
            end
            
            bitti_sonraki = 1;
        end
    end
    
    always @(posedge saat) begin
        if(reset) begin
            kalinlik <= 0;
            mayali <= 0;
            tuzlu <= 0;
            bitti <= 0;
        end
        else begin
            kalinlik <= kalinlik_sonraki;
            mayali <= mayali_sonraki;
            tuzlu <= tuzlu_sonraki;
            bitti <= bitti_sonraki;
        end
    end
    
endmodule
