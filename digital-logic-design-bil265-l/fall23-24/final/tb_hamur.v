`timescale 1ns / 1ps

module tb_hamur(

    );
    
    reg saat;
    reg reset;
    reg basla;
    reg [5:0] un_miktari;
    reg [7:0] su_miktari;
    reg [2:0] tuz_miktari;
    reg maya;
    wire [1:0] kalinlik;
    wire mayali;
    wire tuzlu;
    wire bitti;
    
    hamur hamur_dut(
        .saat(saat),
        .reset(reset),
        .basla(basla),
        .un_miktari(un_miktari),
        .su_miktari(su_miktari),
        .tuz_miktari(tuz_miktari),
        .maya(maya),
        .kalinlik(kalinlik),
        .mayali(mayali),
        .tuzlu(tuzlu),
        .bitti(bitti)
    );
    
    always begin
        saat = ~saat; #0.5;
    end

    integer passes = 0;
    integer fails = 0;

    initial begin
        saat = 0;
        reset = 0;
        
        basla = 1; un_miktari = 63; su_miktari = 255; tuz_miktari = 7; maya = 1; #1;
        
        if(kalinlik == 2 && mayali == 1 && tuzlu == 1 && bitti == 1) begin
            $display("TEST1 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test1 failed, kalinlik: %d, mayali: %d, tuzlu: %d, bitti: %d", kalinlik, mayali, tuzlu, bitti);
            fails = fails + 1;
        end
        
        reset = 1;
        #55;
        reset = 0;
        
        basla = 1; un_miktari = 63; su_miktari = 255; tuz_miktari = 4; maya = 1; #1;
        
        if(kalinlik == 2 && mayali == 1 && tuzlu == 0 && bitti == 1) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test2 failed, kalinlik: %d, mayali: %d, tuzlu: %d, bitti: %d", kalinlik, mayali, tuzlu, bitti);
            fails = fails + 1;
        end
        
        basla = 0; un_miktari = 1; su_miktari = 1; tuz_miktari = 3; maya = 0; #1;
        
        if(bitti == 0) begin
            $display("TEST3 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test3 failed, kalinlik: %d, mayali: %d, tuzlu: %d, bitti: %d", kalinlik, mayali, tuzlu, bitti);
            fails = fails + 1;
        end
        
        basla = 1; un_miktari = 1; su_miktari = 2; tuz_miktari = 3; maya = 0; #1;
        
        if(kalinlik == 0 && mayali == 0 && tuzlu == 0 && bitti == 1) begin
            $display("TEST4 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test4 failed, kalinlik: %d, mayali: %d, tuzlu: %d, bitti: %d", kalinlik, mayali, tuzlu, bitti);
            fails = fails + 1;
        end
        
        reset = 1;
        #1;
        reset = 0;
        
        basla = 0; un_miktari = 25; su_miktari = 142; tuz_miktari = 2; maya = 1; #1;
        
        if(bitti == 0) begin
            $display("TEST5 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test5 failed, kalinlik: %d, mayali: %d, tuzlu: %d, bitti: %d", kalinlik, mayali, tuzlu, bitti);
            fails = fails + 1;
        end
        
        basla = 1; un_miktari = 25; su_miktari = 142; tuz_miktari = 2; maya = 1; #1;
        
        if(kalinlik == 0 && mayali == 1 && tuzlu == 0 && bitti == 1) begin
            $display("TEST6 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test6 failed, kalinlik: %d, mayali: %d, tuzlu: %d, bitti: %d", kalinlik, mayali, tuzlu, bitti);
            fails = fails + 1;
        end
        
        basla = 1; un_miktari = 17; su_miktari = 99; tuz_miktari = 0; maya = 0; #1;
        
        if(kalinlik == 0 && mayali == 0 && tuzlu == 0 && bitti == 1) begin
            $display("TEST7 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test7 failed, kalinlik: %d, mayali: %d, tuzlu: %d, bitti: %d", kalinlik, mayali, tuzlu, bitti);
            fails = fails + 1;
        end
        
        basla = 1; un_miktari = 50; su_miktari = 101; tuz_miktari = 5; maya = 1; #1;
        
        if(kalinlik == 1 && mayali == 1 && tuzlu == 1 && bitti == 1) begin
            $display("TEST8 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test8 failed, kalinlik: %d, mayali: %d, tuzlu: %d, bitti: %d", kalinlik, mayali, tuzlu, bitti);
            fails = fails + 1;
        end
        
        basla = 1; un_miktari = 43; su_miktari = 100; tuz_miktari = 2; maya = 1; #1;
        
        if(kalinlik == 0 && mayali == 1 && tuzlu == 0 && bitti == 1) begin
            $display("TEST9 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test9 failed, kalinlik: %d, mayali: %d, tuzlu: %d, bitti: %d", kalinlik, mayali, tuzlu, bitti);
            fails = fails + 1;
        end
        
        basla = 1; un_miktari = 43; su_miktari = 100; tuz_miktari = 0; maya = 0; #1;
        
        if(kalinlik == 1 && mayali == 0 && tuzlu == 0 && bitti == 1) begin
            $display("TEST10 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test10 failed, kalinlik: %d, mayali: %d, tuzlu: %d, bitti: %d", kalinlik, mayali, tuzlu, bitti);
            fails = fails + 1;
        end
        
        $display("%d passes, %d fails\n", passes, fails);
        
        if(passes == 10) $display("ALL PASSED!\n");
        if(fails  == 10) $display("all failed!\n");
        
        $finish;
    end
    
endmodule
