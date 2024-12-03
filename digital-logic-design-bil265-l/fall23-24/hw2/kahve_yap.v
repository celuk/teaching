`timescale 1ns / 1ps

module kahve_yap #(parameter DERECE = 20)(
    input saat,
    input reset,
    input [3:0] cekirdekler,
    input [1:0] boyut,
    input [7:0] su_miktari,
    input [6:0] hedef_sicaklik,
    input filtrele,
    input filtre_tipi,
    output reg [14:0] sure = 0,
    output bosalt,
    output [4:0] kahve_sayisi
    );

    wire bitti_ogut;
    wire bitti_demle;
    wire bitti_servis;
    
    wire [4:0] tanecikler;
    
    ogut ogt(
        .saat(saat),
        .reset(reset),
        .basla(1'b1),
        .cekirdekler(cekirdekler),
        .boyut(boyut),
        .bitti(bitti_ogut),
        .tanecikler(tanecikler)
    );
    
    reg [7:0] su_miktari1 = 0;
    reg [6:0] hedef_sicaklik1 = 0;
    
    wire demlendi;
    
    wire [14:0] sure1;
    
    demle #(.DERECE(DERECE)) dml(
        .saat(saat),
        .reset(reset),
        .basla(bitti_ogut),
        .tanecikler(tanecikler),
        .su_miktari(su_miktari1),
        .hedef_sicaklik(hedef_sicaklik1),
        .bitti(bitti_demle),
        .demlendi(demlendi),
        .sure(sure1)
    );
    
    reg filtrele1 = 0;
    reg filtre_tipi1 = 0;
    reg filtrele2 = 0;
    reg filtre_tipi2 = 0;
    reg filtrele3 = 0;
    reg filtre_tipi3 = 0;
    reg filtrele4 = 0;
    reg filtre_tipi4 = 0;
    
    servis srv(
        .saat(saat),
        .reset(reset),
        .basla(bitti_demle),
        .demlendi(demlendi),
        .filtrele(filtrele4),
        .filtre_tipi(filtre_tipi4),
        .bitti(bitti_servis),
        .bosalt(bosalt),
        .kahve_sayisi(kahve_sayisi)
    );

    always @(posedge saat) begin
        if(reset) begin
            su_miktari1 <= 0;
            hedef_sicaklik1 <= 0;
            
            sure <= 0;
            
            filtrele1 <= 0;
            filtre_tipi1 <= 0;
            filtrele2 <= 0;
            filtre_tipi2 <= 0;
            filtrele3 <= 0;
            filtre_tipi3 <= 0;
            filtrele4 <= 0;
            filtre_tipi4 <= 0;
        end
        else begin
            su_miktari1 <= su_miktari;
            hedef_sicaklik1 <= hedef_sicaklik;
            
            sure <= sure1;
            
            filtrele1 <= filtrele;
            filtre_tipi1 <= filtre_tipi;
            filtrele2 <= filtrele1;
            filtre_tipi2 <= filtre_tipi1;
            filtrele3 <= filtrele2;
            filtre_tipi3 <= filtre_tipi2;
            filtrele4 <= filtrele3;
            filtre_tipi4 <= filtre_tipi3;
        end
    end
    
endmodule
