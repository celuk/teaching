`timescale 1ns / 1ps

module mogol_derbisi(
    input  [9:0] beyaz_at_hizlar,
    input  [9:0] siyah_at_hizlar,
    input  [9:0] boz_at_hizlar,
    input  [9:0] beyaz_jokey_komutlar,
    input  [9:0] siyah_jokey_komutlar,
    input  [9:0] boz_jokey_komutlar,
    input  [2:0] beyaz_at_seyirci,
    input  [2:0] siyah_at_seyirci,
    input  [2:0] boz_at_seyirci,
    output reg [1:0] kazanan_at = 0
    );
    
    wire [1:0] kazanan_atlar [4:0];
    at_yarisi tur1(
        .beyaz_at_hiz(beyaz_at_hizlar[9:8]),
        .siyah_at_hiz(siyah_at_hizlar[9:8]),
        .boz_at_hiz(boz_at_hizlar[9:8]),
        .beyaz_jokey_komut(beyaz_jokey_komutlar[9:8]),
        .siyah_jokey_komut(siyah_jokey_komutlar[9:8]),
        .boz_jokey_komut(boz_jokey_komutlar[9:8]),
        .kazanan_at(kazanan_atlar[0])
    );
    at_yarisi tur2(
        .beyaz_at_hiz(beyaz_at_hizlar[7:6]),
        .siyah_at_hiz(siyah_at_hizlar[7:6]),
        .boz_at_hiz(boz_at_hizlar[7:6]),
        .beyaz_jokey_komut(beyaz_jokey_komutlar[7:6]),
        .siyah_jokey_komut(siyah_jokey_komutlar[7:6]),
        .boz_jokey_komut(boz_jokey_komutlar[7:6]),
        .kazanan_at(kazanan_atlar[1])
    );
    at_yarisi tur3(
        .beyaz_at_hiz(beyaz_at_hizlar[5:4]),
        .siyah_at_hiz(siyah_at_hizlar[5:4]),
        .boz_at_hiz(boz_at_hizlar[5:4]),
        .beyaz_jokey_komut(beyaz_jokey_komutlar[5:4]),
        .siyah_jokey_komut(siyah_jokey_komutlar[5:4]),
        .boz_jokey_komut(boz_jokey_komutlar[5:4]),
        .kazanan_at(kazanan_atlar[2])
    );
    at_yarisi tur4(
        .beyaz_at_hiz(beyaz_at_hizlar[3:2]),
        .siyah_at_hiz(siyah_at_hizlar[3:2]),
        .boz_at_hiz(boz_at_hizlar[3:2]),
        .beyaz_jokey_komut(beyaz_jokey_komutlar[3:2]),
        .siyah_jokey_komut(siyah_jokey_komutlar[3:2]),
        .boz_jokey_komut(boz_jokey_komutlar[3:2]),
        .kazanan_at(kazanan_atlar[3])
    );
    at_yarisi tur5(
        .beyaz_at_hiz(beyaz_at_hizlar[1:0]),
        .siyah_at_hiz(siyah_at_hizlar[1:0]),
        .boz_at_hiz(boz_at_hizlar[1:0]),
        .beyaz_jokey_komut(beyaz_jokey_komutlar[1:0]),
        .siyah_jokey_komut(siyah_jokey_komutlar[1:0]),
        .boz_jokey_komut(boz_jokey_komutlar[1:0]),
        .kazanan_at(kazanan_atlar[4])
    );
    
    integer i = 0;
    
    reg [2:0] beyaz_say = 0;
    reg [2:0] siyah_say = 0;
    reg [2:0] boz_say = 0;
    
    reg [5:0] beyaz_toplam = 0; // max 49+5=54
    reg [4:0] siyah_toplam = 0; // max 14+5=19
    reg [3:0] boz_toplam = 0; // max 9+5=14
    
    always @* begin
        for(i=0; i<5; i=i+1) begin
            case(kazanan_atlar[i])
                2'b00: beyaz_say = beyaz_say+1;
                2'b01: siyah_say = siyah_say+1;
                2'b10: boz_say = boz_say+1;
            endcase
        end
        
        beyaz_toplam = beyaz_say + beyaz_at_seyirci*beyaz_at_seyirci;
        siyah_toplam = siyah_say + siyah_at_seyirci*2;
        boz_toplam = boz_say + boz_at_seyirci+2;
        
        if((beyaz_say >= 3) || (siyah_say >= 3) || (boz_say >= 3)) begin
            if(beyaz_toplam > siyah_toplam && beyaz_toplam > boz_toplam) begin
                kazanan_at = 2'b00;
            end
            else if(siyah_toplam > beyaz_toplam && siyah_toplam > boz_toplam) begin
                kazanan_at = 2'b01;
            end
            else if(boz_toplam > beyaz_toplam && boz_toplam > siyah_toplam) begin
                kazanan_at = 2'b10;
            end
            else begin
                kazanan_at = 2'b11;
            end
        end
        else begin
            kazanan_at = 2'b11;
        end
    end
    
endmodule
