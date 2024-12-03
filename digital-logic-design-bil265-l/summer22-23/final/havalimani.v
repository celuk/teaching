`timescale 1ns / 1ps

module havalimani #(parameter BIT = 6)(
    input  saat,
    input  reset,
    input  [BIT-1:0] kimlik_no,
    input  uyruk,
    input  [5:0] agirlik,
    input  [8:0] bakiye,
    output kalkis,
    output reg [8:0] k_bakiye = 0
    );

    wire bitti_kimlik;
    wire bitti_bavul;
    wire bitti_odeme;
    wire bitti_ucak;
    
    reg ilk_cevrim = 1;
    
    reg g_kimlik1 = 0;
    reg g_kimlik2 = 0;
    wire g_kimlik;
    kimlik #(.BIT(BIT)) kmlk(
        .saat(saat),
        .reset(reset),
        .basla(ilk_cevrim ? 1'b1 : bitti_ucak),
        .kimlik_no(kimlik_no),
        .uyruk(uyruk),
        .gecerli(g_kimlik),
        .bitti(bitti_kimlik)
    );
    
    reg [5:0] agirlik1 = 0;
    wire [7:0] ucret;
    bavul bvl(
        .saat(saat),
        .reset(reset),
        .basla(bitti_kimlik),
        .agirlik(agirlik1),
        .ucret(ucret),
        .bitti(bitti_bavul)
    );
    
    reg [8:0] bakiye1 = 0;
    reg [8:0] bakiye2 = 0;
    wire onay;
    wire [8:0] k_bakiye1;
    odeme odm(
        .saat(saat),
        .reset(reset),
        .basla(bitti_bavul),
        .ucret(ucret),
        .bakiye(bakiye2),
        .onay(onay),
        .k_bakiye(k_bakiye1),
        .bitti(bitti_odeme)
    );
    
    ucak uk(
        .saat(saat),
        .reset(reset),
        .basla(bitti_odeme),
        .o_yolcu(onay),
        .g_kimlik(g_kimlik2),
        .kalkis(kalkis),
        .bitti(bitti_ucak)
    );
    
    always @(posedge saat) begin
        if(reset) begin
            g_kimlik1 <= 0;
            g_kimlik2 <= 0;
            agirlik1 <= 0;
            bakiye1 <= 0;
            bakiye2 <= 0;
            k_bakiye <= 0;
            
            ilk_cevrim <= 1;
        end
        else begin
            // g_kimlik 2 cevrim bekletiliyor
            g_kimlik1 <= g_kimlik;
            g_kimlik2 <= g_kimlik1;
            
            // agirlik 1 cevrim bekletiliyor
            agirlik1 <= agirlik;
            
            // bakiye 2 cevrim bekletiliyor
            bakiye1 <= bakiye;
            bakiye2 <= bakiye1;
            
            // k_bakiye 1 cevrim bekletiliyor
            k_bakiye <= k_bakiye1;
            
            ilk_cevrim <= 0;
        end
    end
    
endmodule
