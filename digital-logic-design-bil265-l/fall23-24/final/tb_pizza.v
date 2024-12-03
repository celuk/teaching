`timescale 1ns / 1ps

module tb_pizza(

    );
    
    reg saat;
    reg reset;
    reg [5:0] un_miktari;
    reg [7:0] su_miktari;
    reg [2:0] tuz_miktari;
    reg maya;
    reg sos;
    wire [1:0] kalinlik;
    wire secilen_malzeme;
    wire [3:0] malzeme_miktari;
    wire kabarik;
    wire tuzlu;
    wire [6:0] pizza_sayisi;
    
    pizza pizza_dut(
        .saat(saat),
        .reset(reset),
        .un_miktari(un_miktari),
        .su_miktari(su_miktari),
        .tuz_miktari(tuz_miktari),
        .maya(maya),
        .sos(sos),
        .kalinlik(kalinlik),
        .secilen_malzeme(secilen_malzeme),
        .malzeme_miktari(malzeme_miktari),
        .kabarik(kabarik),
        .tuzlu(tuzlu),
        .pizza_sayisi(pizza_sayisi)
    );
    
    always begin
        saat = ~saat; #0.5;
    end

    integer passes = 0;
    integer fails = 0;

    initial begin
        saat = 0;
        reset = 0;
        
        un_miktari = 63; su_miktari = 255; tuz_miktari = 4; maya = 1; sos = 1; #3;
        
        if(kalinlik == 2 && secilen_malzeme == 1 && malzeme_miktari == 7 && kabarik == 1 && tuzlu == 0 && pizza_sayisi == 1) begin
            $display("TEST1 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test1 failed, kalinlik: %d, secilen_malzeme: %d, malzeme_miktari: %d, kabarik: %d, tuzlu: %d, pizza_sayisi: %d", kalinlik, secilen_malzeme, malzeme_miktari, kabarik, tuzlu, pizza_sayisi);
            fails = fails + 1;
        end
        
        un_miktari = 63; su_miktari = 255; tuz_miktari = 4; maya = 1; sos = 1; #1;
        
        if(kalinlik == 2 && secilen_malzeme == 1 && malzeme_miktari == 7 && kabarik == 1 && tuzlu == 0 && pizza_sayisi == 2) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test2 failed, kalinlik: %d, secilen_malzeme: %d, malzeme_miktari: %d, kabarik: %d, tuzlu: %d, pizza_sayisi: %d", kalinlik, secilen_malzeme, malzeme_miktari, kabarik, tuzlu, pizza_sayisi);
            fails = fails + 1;
        end
        
        reset = 1;
        #55;
        reset = 0;
        
        un_miktari = 63; su_miktari = 255; tuz_miktari = 7; maya = 1; sos = 1; #300;
        
        if(kalinlik == 2 && secilen_malzeme == 1 && malzeme_miktari == 0 && kabarik == 0 && tuzlu == 1 && pizza_sayisi == 0) begin
            $display("TEST3 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test3 failed, kalinlik: %d, secilen_malzeme: %d, malzeme_miktari: %d, kabarik: %d, tuzlu: %d, pizza_sayisi: %d", kalinlik, secilen_malzeme, malzeme_miktari, kabarik, tuzlu, pizza_sayisi);
            fails = fails + 1;
        end
        
        reset = 1;
        #1;
        reset = 0;
        
        un_miktari = 63; su_miktari = 255; tuz_miktari = 5; maya = 1; sos = 1; #1;
        un_miktari = 43; su_miktari = 100; tuz_miktari = 3; maya = 0; sos = 1; #1;
        un_miktari = 43; su_miktari = 100; tuz_miktari = 1; maya = 1; sos = 0; #1;
        
        if(kalinlik == 2 && secilen_malzeme == 1 && malzeme_miktari == 0 && kabarik == 0 && tuzlu == 1 && pizza_sayisi == 0) begin
            $display("TEST4 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test4 failed, kalinlik: %d, secilen_malzeme: %d, malzeme_miktari: %d, kabarik: %d, tuzlu: %d, pizza_sayisi: %d", kalinlik, secilen_malzeme, malzeme_miktari, kabarik, tuzlu, pizza_sayisi);
            fails = fails + 1;
        end
        
        un_miktari = 23; su_miktari = 100; tuz_miktari = 2; maya = 1; sos = 1; #20;
        un_miktari = 55; su_miktari = 142; tuz_miktari = 3; maya = 0; sos = 0; #20;
        un_miktari = 15; su_miktari = 11; tuz_miktari = 6; maya = 1; sos = 0; #4;
        un_miktari = 20; su_miktari = 20; tuz_miktari = 0; maya = 1; sos = 1; #3;
        
        if(kalinlik == 0 && secilen_malzeme == 1 && malzeme_miktari == 7 && kabarik == 1 && tuzlu == 0 && pizza_sayisi == 43) begin
            $display("TEST5 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test5 failed, kalinlik: %d, secilen_malzeme: %d, malzeme_miktari: %d, kabarik: %d, tuzlu: %d, pizza_sayisi: %d", kalinlik, secilen_malzeme, malzeme_miktari, kabarik, tuzlu, pizza_sayisi);
            fails = fails + 1;
        end
        
        un_miktari = 50; su_miktari = 100; tuz_miktari = 0; maya = 1; sos = 1; #3;
        
        if(kalinlik == 1 && secilen_malzeme == 1 && malzeme_miktari == 7 && kabarik == 1 && tuzlu == 0 && pizza_sayisi == 46) begin
            $display("TEST6 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test6 failed, kalinlik: %d, secilen_malzeme: %d, malzeme_miktari: %d, kabarik: %d, tuzlu: %d, pizza_sayisi: %d", kalinlik, secilen_malzeme, malzeme_miktari, kabarik, tuzlu, pizza_sayisi);
            fails = fails + 1;
        end
        
        un_miktari = 40; su_miktari = 100; tuz_miktari = 0; maya = 0; sos = 1; #37;
        
        if(kalinlik == 1 && secilen_malzeme == 1 && malzeme_miktari == 7 && kabarik == 0 && tuzlu == 0 && pizza_sayisi == 83) begin
            $display("TEST7 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test7 failed, kalinlik: %d, secilen_malzeme: %d, malzeme_miktari: %d, kabarik: %d, tuzlu: %d, pizza_sayisi: %d", kalinlik, secilen_malzeme, malzeme_miktari, kabarik, tuzlu, pizza_sayisi);
            fails = fails + 1;
        end
        
        un_miktari = 17; su_miktari = 99; tuz_miktari = 0; maya = 0; sos = 0; #4;
        
        if(kalinlik == 0 && secilen_malzeme == 1 && malzeme_miktari == 6 && kabarik == 0 && tuzlu == 0 && pizza_sayisi == 87) begin
            $display("TEST8 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test8 failed, kalinlik: %d, secilen_malzeme: %d, malzeme_miktari: %d, kabarik: %d, tuzlu: %d, pizza_sayisi: %d", kalinlik, secilen_malzeme, malzeme_miktari, kabarik, tuzlu, pizza_sayisi);
            fails = fails + 1;
        end
        
        un_miktari = 1; su_miktari = 1; tuz_miktari = 1; maya = 1; sos = 1; #1;
        
        if(kalinlik == 0 && secilen_malzeme == 1 && malzeme_miktari == 6 && kabarik == 0 && tuzlu == 0 && pizza_sayisi == 88) begin
            $display("TEST9 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test9 failed, kalinlik: %d, secilen_malzeme: %d, malzeme_miktari: %d, kabarik: %d, tuzlu: %d, pizza_sayisi: %d", kalinlik, secilen_malzeme, malzeme_miktari, kabarik, tuzlu, pizza_sayisi);
            fails = fails + 1;
        end
        
        un_miktari = 12; su_miktari = 24; tuz_miktari = 4; maya = 1; sos = 0; #56;
        
        if(kalinlik == 0 && secilen_malzeme == 1 && malzeme_miktari == 6 && kabarik == 1 && tuzlu == 0 && pizza_sayisi == 100) begin
            $display("TEST10 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test10 failed, kalinlik: %d, secilen_malzeme: %d, malzeme_miktari: %d, kabarik: %d, tuzlu: %d, pizza_sayisi: %d", kalinlik, secilen_malzeme, malzeme_miktari, kabarik, tuzlu, pizza_sayisi);
            fails = fails + 1;
        end
        
        $display("%d passes, %d fails\n", passes, fails);
        
        if(passes == 10) $display("ALL PASSED!\n");
        if(fails  == 10) $display("all failed!\n");
        
        $finish;
    end
    
endmodule
