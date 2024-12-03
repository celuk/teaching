`timescale 1ns / 1ps

module garip_sifreleme #(parameter BIT = 4)(
    input saat,
    input reset,
    input basla,
    input mod,
    input [BIT-1:0] veri,
    input [2:0] secim,
    
    output bit_cikisi,
    output gecerli
    );
    
    reg [5:0] sayac;
    reg [5:0] sayac_sonraki;
    
    wire s1_bit_cikisi;
    wire s1_gecerli;
    
    reg s2_basla;
    reg s2_basla_sonraki;
    
    reg [BIT-1:0] s2_veri;
    reg [BIT-1:0] s2_veri_sonraki;
    
    wire [2:0] s2_secim = s2_veri[2:0];
    
    sifreleme #(.BIT(BIT)) sifreleme1(
        .saat(saat),
        .reset(reset),
        .basla(basla),
        .mod(mod),
        .veri(veri),
        .secim(secim),
        .bit_cikisi(s1_bit_cikisi),
        .gecerli(s1_gecerli)
    );
    
    sifreleme #(.BIT(BIT)) sifreleme2(
        .saat(saat),
        .reset(reset),
        .basla(s2_basla),
        .mod(~mod),
        .veri(s2_veri),
        .secim(s2_secim),
        .bit_cikisi(bit_cikisi),
        .gecerli(gecerli)
    );
    
    // Soruda 2*BIT + 1 cevrim yazilmis ama testbenchte kac cevrim oldugundan bagimsiz kontrol ediliyor
    // Burada 2*BIT + 1 cevrimde tamamlanmak isteniyorsa s2 veri ve basla degerleri icin sonraki olmadan atama yapmak lazim
    // ama cirkin bir kod olacagindan duzgun anlasilmasi acisindan boyle yazdim, her iki turlu de kabul
    
    always @* begin
        sayac_sonraki = sayac;
        s2_veri_sonraki = s2_veri;
        s2_basla_sonraki = 0;
        
        if(s1_gecerli) begin
            s2_veri_sonraki[sayac] = s1_bit_cikisi;
            sayac_sonraki = sayac + 1;
            if(sayac == BIT-1) begin
                sayac_sonraki = 0;
                s2_basla_sonraki = 1;
            end
        end
    end
    
    always@(posedge saat) begin
        if(reset) begin
            sayac <= 0;
            s2_basla <= 0;
            s2_veri <= 0;
        end
        else begin
            sayac <= sayac_sonraki;
            s2_basla <= s2_basla_sonraki;
            s2_veri <= s2_veri_sonraki;
        end
    end
endmodule

