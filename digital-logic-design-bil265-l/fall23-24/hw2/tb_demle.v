`timescale 1ns / 1ps

module tb_demle(

    );
    
    reg saat;
    reg reset;
    reg basla;
    reg [4:0] tanecikler;
    reg [7:0] su_miktari;
    reg [6:0] hedef_sicaklik;
    wire bitti;
    wire demlendi;
    wire [14:0] sure;

    demle #(.DERECE(30)) demle_dut(
        .saat(saat),
        .reset(reset),
        .basla(basla),
        .tanecikler(tanecikler),
        .su_miktari(su_miktari),
        .hedef_sicaklik(hedef_sicaklik),
        .bitti(bitti),
        .demlendi(demlendi),
        .sure(sure)
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
        
        basla = 1; tanecikler = 7; su_miktari = 145; hedef_sicaklik = 99; #1;
        
        if(bitti == 0) begin
            $display("TEST1 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test1 failed, sure: %d, demlendi: %d, bitti: %d", sure, demlendi, bitti);
            fails = fails + 1;
        end
        
        basla = 1; tanecikler = 7; su_miktari = 144; hedef_sicaklik = 35; #2;
        
        if(sure == 10012 && demlendi == 1 && bitti == 1) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test2 failed, sure: %d, demlendi: %d, bitti: %d", sure, demlendi, bitti);
            fails = fails + 1;
        end
        
        basla = 1; tanecikler = 3; su_miktari = 255; hedef_sicaklik = 127; #8;
        basla = 1; tanecikler = 15; su_miktari = 20; hedef_sicaklik = 100; #4;
        
        if(sure == 1415 && demlendi == 1 && bitti == 1) begin
            $display("TEST3 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test3 failed, sure: %d, demlendi: %d, bitti: %d", sure, demlendi, bitti);
            fails = fails + 1;
        end
        
        basla = 1; tanecikler = 11; su_miktari = 55; hedef_sicaklik = 7; #10;
        basla = 1; tanecikler = 13; su_miktari = 10; hedef_sicaklik = 50; #2;
        
        if(demlendi == 0 && bitti == 1) begin
            $display("TEST4 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test4 failed, sure: %d, demlendi: %d, bitti: %d", sure, demlendi, bitti);
            fails = fails + 1;
        end
        
        basla = 1; tanecikler = 5; su_miktari = 62; hedef_sicaklik = 121; #8;
        basla = 0; tanecikler = 5; su_miktari = 25; hedef_sicaklik = 102; #2;
        
        // eger cok cevrimliyse buradaki ife bunu koyun
        //if(bitti == 0) begin
        if(sure == 5647 && demlendi == 1 && bitti == 1) begin
            $display("TEST5 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test5 failed, sure: %d, demlendi: %d, bitti: %d", sure, demlendi, bitti);
            fails = fails + 1;
        end
        
        basla = 1; tanecikler = 1; su_miktari = 2; hedef_sicaklik = 89; #1;
        
        if(bitti == 0) begin
            $display("TEST6 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test6 failed, sure: %d, demlendi: %d, bitti: %d", sure, demlendi, bitti);
            fails = fails + 1;
        end
        
        reset = 1;
        #55;
        reset = 0;
        
        basla = 1; tanecikler = 15; su_miktari = 255; hedef_sicaklik = 127; #9;
        basla = 0; tanecikler = 15; su_miktari = 255; hedef_sicaklik = 127; #1;
        basla = 1; tanecikler = 1; su_miktari = 1; hedef_sicaklik = 30; #2;
        
        
        if(bitti == 0) begin
            $display("TEST7 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test7 failed, sure: %d, demlendi: %d, bitti: %d", sure, demlendi, bitti);
            fails = fails + 1;
        end
        
        reset = 1;
        #1;
        reset = 0;
        
        basla = 0; tanecikler = 15; su_miktari = 20; hedef_sicaklik = 100; #3;
        
        if(bitti == 0) begin
            $display("TEST8 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test8 failed, sure: %d, demlendi: %d, bitti: %d", sure, demlendi, bitti);
            fails = fails + 1;
        end
        
        basla = 1; tanecikler = 15; su_miktari = 20; hedef_sicaklik = 18; #18;
        
        if(sure == 0 && demlendi == 0 && bitti == 1) begin
            $display("TEST9 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test9 failed, sure: %d, demlendi: %d, bitti: %d", sure, demlendi, bitti);
            fails = fails + 1;
        end
        
        basla = 1; tanecikler = 15; su_miktari = 20; hedef_sicaklik = 48; #23;
        
        // eger cok cevrimliyse buradaki ife bunu koyun
        //if(bitti == 0) begin
        if(sure == 375 && demlendi == 1 && bitti == 1) begin
            $display("TEST10 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test10 failed, sure: %d, demlendi: %d, bitti: %d", sure, demlendi, bitti);
            fails = fails + 1;
        end
        
        $display("%d passes, %d fails\n", passes, fails);
        
        if(passes == 10) $display("ALL PASSED!\n");
        if(fails  == 10) $display("all failed!\n");
        
        $finish;
    end

endmodule
