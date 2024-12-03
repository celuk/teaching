`timescale 1ns / 1ps

module tb_kahve_yap(

    );

    reg saat;
    reg reset;
    reg [3:0] cekirdekler;
    reg [1:0] boyut;
    reg [7:0] su_miktari;
    reg [6:0] hedef_sicaklik;
    reg filtrele;
    reg filtre_tipi;
    wire [14:0] sure;
    wire bosalt;
    wire [4:0] kahve_sayisi;
    
    kahve_yap #(.DERECE(18)) kahve_yap_dut(
        .saat(saat),
        .reset(reset),
        .cekirdekler(cekirdekler),
        .boyut(boyut),
        .su_miktari(su_miktari),
        .hedef_sicaklik(hedef_sicaklik),
        .filtrele(filtrele),
        .filtre_tipi(filtre_tipi),
        .sure(sure),
        .bosalt(bosalt),
        .kahve_sayisi(kahve_sayisi)
    );
    
    always begin
        saat = ~saat; #0.5;
    end

    integer passes = 0;
    integer fails = 0;
    
    initial begin
        saat = 0;
        reset = 1; #13;
        reset = 0;
        
        cekirdekler = 15; boyut = 2; su_miktari = 255; hedef_sicaklik = 127; filtrele = 1; filtre_tipi = 1; #5;
        
        if(sure == 27812 && kahve_sayisi == 3 && bosalt == 0) begin
            $display("TEST1 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test1 failed, sure: %d, kahve_sayisi: %d, bosalt: %d", sure, kahve_sayisi, bosalt);
            fails = fails + 1;
        end
        
        cekirdekler = 14; boyut = 1; su_miktari = 254; hedef_sicaklik = 27; filtrele = 1; filtre_tipi = 1; #1;
        
        // eger demle cok cevrimliyse buradaki ife bunu koyun
        //if(sure == 27812 && kahve_sayisi == 3 && bosalt == 0) begin
        if(sure == 27812 && kahve_sayisi == 6 && bosalt == 0) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test2 failed, sure: %d, kahve_sayisi: %d, bosalt: %d", sure, kahve_sayisi, bosalt);
            fails = fails + 1;
        end
        
        cekirdekler = 13; boyut = 0; su_miktari = 55; hedef_sicaklik = 126; filtrele = 1; filtre_tipi = 1; #2;
        
        // eger demle cok cevrimliyse buradaki ife bunu koyun
        //if(sure == 27812 && kahve_sayisi == 6 && bosalt == 0) begin
        if(sure == 27812 && kahve_sayisi == 12 && bosalt == 0) begin
            $display("TEST3 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test3 failed, sure: %d, kahve_sayisi: %d, bosalt: %d", sure, kahve_sayisi, bosalt);
            fails = fails + 1;
        end
        
        cekirdekler = 12; boyut = 2; su_miktari = 255; hedef_sicaklik = 127; filtrele = 1; filtre_tipi = 1; #2;
        
        // eger demle cok cevrimliyse buradaki ife bunu koyun
        //if(sure == 2307 && kahve_sayisi == 6 && bosalt == 0) begin
        if(sure == 2307 && kahve_sayisi == 18 && bosalt == 0) begin
            $display("TEST4 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test4 failed, sure: %d, kahve_sayisi: %d, bosalt: %d", sure, kahve_sayisi, bosalt);
            fails = fails + 1;
        end
        
        cekirdekler = 11; boyut = 1; su_miktari = 255; hedef_sicaklik = 127; filtrele = 1; filtre_tipi = 0; #1;
        
        // eger demle cok cevrimliyse buradaki ife bunu koyun
        //if(sure == 5966 && kahve_sayisi == 9 && bosalt == 0) begin
        if(sure == 5966 && kahve_sayisi == 21 && bosalt == 0) begin
            $display("TEST5 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test5 failed, sure: %d, kahve_sayisi: %d, bosalt: %d", sure, kahve_sayisi, bosalt);
            fails = fails + 1;
        end
        
        reset = 1;
        #55;
        reset = 0;
        
        cekirdekler = 1; boyut = 0; su_miktari = 5; hedef_sicaklik = 30; filtrele = 1; filtre_tipi = 0; #394;
        
        // eger demle cok cevrimliyse buradaki ife bunu koyun
        //if(sure == 62 && kahve_sayisi == 0 && bosalt == 0) begin
        if(sure == 62 && kahve_sayisi == 0 && bosalt == 1) begin
            $display("TEST6 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test6 failed, sure: %d, kahve_sayisi: %d, bosalt: %d", sure, kahve_sayisi, bosalt);
            fails = fails + 1;
        end
        
        reset = 1;
        #1;
        reset = 0;
        
        cekirdekler = 12; boyut = 0; su_miktari = 120; hedef_sicaklik = 100; filtrele = 0; filtre_tipi = 0; #75;
        cekirdekler = 8; boyut = 0; su_miktari = 210; hedef_sicaklik = 100; filtrele = 1; filtre_tipi = 1; #1;
        cekirdekler = 3; boyut = 0; su_miktari = 10; hedef_sicaklik = 100; filtrele = 1; filtre_tipi = 0; #1;
        
        // eger demle cok cevrimliyse buradaki ife bunu koyun
        //if(sure == 9864 && kahve_sayisi == 0 && bosalt == 1) begin
        if(sure == 9864 && kahve_sayisi == 23 && bosalt == 0) begin
            $display("TEST7 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test7 failed, sure: %d, kahve_sayisi: %d, bosalt: %d", sure, kahve_sayisi, bosalt);
            fails = fails + 1;
        end
        
        cekirdekler = 14; boyut = 2; su_miktari = 20; hedef_sicaklik = 100; filtrele = 1; filtre_tipi = 0; #50;
        cekirdekler = 14; boyut = 2; su_miktari = 20; hedef_sicaklik = 100; filtrele = 1; filtre_tipi = 0; #50;
        cekirdekler = 14; boyut = 2; su_miktari = 20; hedef_sicaklik = 100; filtrele = 1; filtre_tipi = 0; #4;
        cekirdekler = 14; boyut = 2; su_miktari = 20; hedef_sicaklik = 100; filtrele = 1; filtre_tipi = 0; #3;
        
        // eger demle cok cevrimliyse buradaki ife bunu koyun
        //if(sure == 1655 && kahve_sayisi == 20 && bosalt == 0) begin
        if(sure == 1655 && kahve_sayisi == 4 && bosalt == 0) begin
            $display("TEST8 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test8 failed, sure: %d, kahve_sayisi: %d, bosalt: %d", sure, kahve_sayisi, bosalt);
            fails = fails + 1;
        end
        
        cekirdekler = 8; boyut = 1; su_miktari = 250; hedef_sicaklik = 5; filtrele = 1; filtre_tipi = 0; #10;
        
        // eger demle cok cevrimliyse buradaki ife bunu koyun
        //if(sure == 0 && kahve_sayisi == 24 && bosalt == 0) begin
        if(sure == 0 && kahve_sayisi == 12 && bosalt == 0) begin
            $display("TEST9 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test9 failed, sure: %d, kahve_sayisi: %d, bosalt: %d", sure, kahve_sayisi, bosalt);
            fails = fails + 1;
        end
        
        cekirdekler = 9; boyut = 0; su_miktari = 120; hedef_sicaklik = 120; filtrele = 0; filtre_tipi = 0; #42;
        
        // eger demle cok cevrimliyse buradaki ife bunu koyun
        //if(sure == 12258 && kahve_sayisi == 12 && bosalt == 0) begin
        if(sure == 12258 && kahve_sayisi == 0 && bosalt == 1) begin
            $display("TEST10 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test10 failed, sure: %d, kahve_sayisi: %d, bosalt: %d", sure, kahve_sayisi, bosalt);
            fails = fails + 1;
        end
        
        $display("%d passes, %d fails\n", passes, fails);
        
        if(passes == 10) $display("ALL PASSED!\n");
        if(fails  == 10) $display("all failed!\n");
        
        $finish;
    end

endmodule
