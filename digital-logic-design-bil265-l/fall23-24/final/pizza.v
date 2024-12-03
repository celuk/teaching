`timescale 1ns / 1ps

module pizza(
    input saat,
    input reset,
    input [5:0] un_miktari,
    input [7:0] su_miktari,
    input [2:0] tuz_miktari,
    input maya,
    input sos,
    output reg [1:0] kalinlik = 0,
    output reg secilen_malzeme = 0,
    output reg [3:0] malzeme_miktari = 0,
    output kabarik,
    output tuzlu,
    output [6:0] pizza_sayisi
    );
    
    wire bitti_hamur;
    wire bitti_malzeme;
    wire bitti_pisir;
    
    wire [1:0] kalinlik1;
    reg [1:0] kalinlik2 = 0;
    
    wire mayali;
    
    wire tuzlu1;
    
    hamur hmr(
        .saat(saat),
        .reset(reset),
        .basla(1'b1),
        .un_miktari(un_miktari),
        .su_miktari(su_miktari),
        .tuz_miktari(tuz_miktari),
        .maya(maya),
        .kalinlik(kalinlik1),
        .mayali(mayali),
        .tuzlu(tuzlu1),
        .bitti(bitti_hamur)
    );
    
    reg sos1 = 0;
    
    wire tuzlu2;
    
    wire secilen_malzeme1;
    wire [3:0] malzeme_miktari1;
    
    malzeme mlzm(
        .saat(saat),
        .reset(reset),
        .basla(bitti_hamur),
        .sos(sos1),
        .tuzlu(tuzlu1),
        .secilen_malzeme(secilen_malzeme1),
        .malzeme_miktari(malzeme_miktari1),
        .cikis_tuzlu(tuzlu2),
        .bitti(bitti_malzeme)
    );
    
    reg mayali1 = 0;
    
    pisir psr(
        .saat(saat),
        .reset(reset),
        .basla(bitti_malzeme),
        .mayali(mayali1),
        .tuzlu(tuzlu2),
        .kabarik(kabarik),
        .cikis_tuzlu(tuzlu),
        .pizza_sayisi(pizza_sayisi),
        .bitti(bitti_pisir)
    );
    
    always @(posedge saat) begin
        if(reset) begin
            kalinlik2 <= 0;
            mayali1 <= 0;
            sos1 <= 0;
        
            kalinlik <= 0;
            secilen_malzeme <= 0;
            malzeme_miktari <= 0;
        end
        else begin
            kalinlik2 <= kalinlik1;
            kalinlik <= kalinlik2;
        
            mayali1 <= mayali;
        
            sos1 <= sos;
            
            secilen_malzeme <= secilen_malzeme1;
            malzeme_miktari <= malzeme_miktari1;
        end
    end
    
endmodule
