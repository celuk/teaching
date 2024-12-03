`timescale 1ns / 1ps

module tb_indirim(

    );
    
    reg  [12:0] urun_fiyati;
    reg  [1:0]  pazarlik;
    reg  [2:0]  musteri_tipi;
    reg  [1:0]  musteri_davranisi;
    reg  [3:0]  urun_tipi;
    wire [19:0] indirimli_fiyat;
    
    indirim indirim_dut(
        .urun_fiyati(urun_fiyati), 
        .pazarlik(pazarlik), 
        .musteri_tipi(musteri_tipi),
        .musteri_davranisi(musteri_davranisi),
        .urun_tipi(urun_tipi),
        .indirimli_fiyat(indirimli_fiyat)
    );
    
    wire [19:0] indirimli_fiyat_test;
    indirim_test indirim_test_dut(
        .urun_fiyati(urun_fiyati), 
        .pazarlik(pazarlik), 
        .musteri_tipi(musteri_tipi),
        .musteri_davranisi(musteri_davranisi),
        .urun_tipi(urun_tipi),
        .indirimli_fiyat(indirimli_fiyat_test)
    );
    
    integer i, j, k, l, m;
    
    integer passes = 0;
    integer fails = 0;
    
    initial begin
        for(i = 0; i <= 13'b1_1111_1111_1111; i = i + 1) begin
            for(j = 0; j <= 2'b11; j = j + 1) begin
                for(k = 0; k <= 4'b100; k = k + 1) begin
                    for(l = 0; l <= 2'b10; l = l + 1) begin
                        for(m = 0; m <= 4'b1001; m = m + 1) begin
                            urun_fiyati = i;
                            pazarlik = j;
                            musteri_tipi = k;
                            musteri_davranisi = l;
                            urun_tipi = m;
                            #1;
                            
                            if (indirimli_fiyat == indirimli_fiyat_test) begin
                                passes = passes + 1;
                            end
                            else begin
                                fails = fails + 1;
                            end
                        end
                    end
                end
            end
        end
        
        $display("%d passes, %d fails\n", passes, fails);
        
        if(passes == 4915200) $display("ALL PASSED!\n");
        if(fails  == 4915200) $display("all failed!\n");
        
        $finish;
    end
    
endmodule

module indirim_test(
    input  [12:0] urun_fiyati,
    input  [1:0]  pazarlik,
    input  [2:0]  musteri_tipi,
    input  [1:0]  musteri_davranisi,
    input  [3:0]  urun_tipi,
    output [19:0] indirimli_fiyat
    );
    
    reg [39:0] tam_kisim;
    reg [39:0] kurusluk_kisim;
    
    reg [1:0] indirim_sayisi;
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

