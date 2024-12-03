`timescale 1ns / 1ps

module penguenler(
    input saat,
    input reset,
    input [14:0] avlanan_balik,
    
    output bitti,
    output reg [6:0] en_kisa,
    output reg [6:0] en_uzun,
    output reg [6:0] ortalama,
    
    output reg [2:0] hizli_penguen,
    output reg [2:0] yavas_penguen
    );
    
    wire p1_bitti;
    wire [6:0] p1_bitme_sure;
    penguen p1(saat,reset,avlanan_balik[2:0],p1_bitti,p1_bitme_sure);
    
    wire p2_bitti;
    wire [6:0] p2_bitme_sure;
    penguen p2(saat,reset,avlanan_balik[5:3],p2_bitti,p2_bitme_sure);
  
    wire p3_bitti;
    wire [6:0] p3_bitme_sure;
    penguen p3(saat,reset,avlanan_balik[8:6],p3_bitti,p3_bitme_sure);
    
    wire p4_bitti;
    wire [6:0] p4_bitme_sure;
    penguen p4(saat,reset,avlanan_balik[11:9],p4_bitti,p4_bitme_sure);
    
    wire p5_bitti;
    wire [6:0] p5_bitme_sure;
    penguen p5(saat,reset,avlanan_balik[14:12],p5_bitti,p5_bitme_sure);
    
    assign bitti = p1_bitti & p2_bitti & p3_bitti & p4_bitti & p5_bitti;
    
    always @* begin
        if(bitti) begin
            if(p5_bitme_sure >= p4_bitme_sure && p5_bitme_sure >= p3_bitme_sure && p5_bitme_sure >= p2_bitme_sure && p5_bitme_sure >= p1_bitme_sure) begin
                en_uzun = p5_bitme_sure;
                yavas_penguen = 3'd5;
            end
            else if (p4_bitme_sure >= p3_bitme_sure && p4_bitme_sure >= p2_bitme_sure && p4_bitme_sure >= p1_bitme_sure) begin
                en_uzun = p4_bitme_sure;
                yavas_penguen = 3'd4;
            end
            else if (p3_bitme_sure >= p2_bitme_sure && p3_bitme_sure >= p1_bitme_sure) begin
                en_uzun = p3_bitme_sure;
                yavas_penguen = 3'd3;
            end
            else if (p2_bitme_sure >= p1_bitme_sure) begin
                en_uzun = p2_bitme_sure;
                yavas_penguen = 3'd2;
            end
            else begin
                en_uzun = p1_bitme_sure;
                yavas_penguen = 3'd1;
            end
            
            if(p5_bitme_sure <= p4_bitme_sure && p5_bitme_sure <= p3_bitme_sure && p5_bitme_sure <= p2_bitme_sure && p5_bitme_sure <= p1_bitme_sure) begin
                en_kisa = p5_bitme_sure;
                hizli_penguen = 3'd5;
            end
            else if (p4_bitme_sure <= p3_bitme_sure && p4_bitme_sure <= p2_bitme_sure && p4_bitme_sure <= p1_bitme_sure) begin
                en_kisa = p4_bitme_sure;
                hizli_penguen = 3'd4;
            end
            else if (p3_bitme_sure <= p2_bitme_sure && p3_bitme_sure <= p1_bitme_sure) begin
                en_kisa = p3_bitme_sure;
                hizli_penguen = 3'd3;
            end
            else if (p2_bitme_sure <= p1_bitme_sure) begin
                en_kisa = p2_bitme_sure;
                hizli_penguen = 3'd2;
            end
            else begin
                en_kisa = p1_bitme_sure;
                hizli_penguen = 3'd1;
            end
            ortalama = ((p1_bitme_sure + p2_bitme_sure + p3_bitme_sure + p4_bitme_sure + p5_bitme_sure) - ((p1_bitme_sure + p2_bitme_sure + p3_bitme_sure + p4_bitme_sure + p5_bitme_sure) %5))/5;
        end
    end
    
    always@(posedge saat) begin
        if(reset) begin
            en_kisa = 0;
            en_uzun = 0;
            ortalama = 0;
    
            hizli_penguen = 0;
            yavas_penguen = 0;
        end
    end
endmodule
