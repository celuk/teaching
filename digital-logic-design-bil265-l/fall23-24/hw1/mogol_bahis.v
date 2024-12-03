`timescale 1ns / 1ps

module mogol_bahis(
    input  saat,
    input  reset,
    input  [9:0] beyaz_at_hizlar,
    input  [9:0] siyah_at_hizlar,
    input  [9:0] boz_at_hizlar,
    input  [9:0] beyaz_jokey_komutlar,
    input  [9:0] siyah_jokey_komutlar,
    input  [9:0] boz_jokey_komutlar,
    input  [2:0] beyaz_at_seyirci,
    input  [2:0] siyah_at_seyirci,
    input  [2:0] boz_at_seyirci,
    input  [1:0] tahmin_edilen_at,
    input  [6:0] yatirilan_para,
    output reg [13:0] bakiye = 0
    );
    
    wire [1:0] kazanan_at;
    mogol_derbisi md(
        .beyaz_at_hizlar(beyaz_at_hizlar),
        .siyah_at_hizlar(siyah_at_hizlar),
        .boz_at_hizlar(boz_at_hizlar),
        .beyaz_jokey_komutlar(beyaz_jokey_komutlar),
        .siyah_jokey_komutlar(siyah_jokey_komutlar),
        .boz_jokey_komutlar(boz_jokey_komutlar),
        .beyaz_at_seyirci(beyaz_at_seyirci),
        .siyah_at_seyirci(siyah_at_seyirci),
        .boz_at_seyirci(boz_at_seyirci),
        .kazanan_at(kazanan_at)
    );
    
    reg [13:0] bakiye_sonraki = 0;
    
    reg [3:0] derbi = 0, derbi_sonraki = 0;
    reg son_tahmin = 0, son_tahmin_sonraki = 0;
    
    
    always @* begin
        bakiye_sonraki = bakiye;
        son_tahmin_sonraki = 0;
        
        if(derbi < 10) begin
            if(tahmin_edilen_at == kazanan_at) begin
                son_tahmin_sonraki = 1;
                
                if(son_tahmin) begin
                    bakiye_sonraki = bakiye + yatirilan_para*3;
                end
                else begin
                    bakiye_sonraki = bakiye + yatirilan_para*2;
                end
            end
            else begin
                bakiye_sonraki = bakiye - yatirilan_para*4;
            end
            
            derbi_sonraki = derbi + 1;
        end
    end
    
    always @(posedge saat) begin
        if(reset) begin
            derbi <= 0;
            son_tahmin <= 0;
            bakiye <= 0;
        end
        else begin
            derbi <= derbi_sonraki;
            son_tahmin <= son_tahmin_sonraki;
            bakiye <= bakiye_sonraki;
        end
    end
    
endmodule
