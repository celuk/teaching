`timescale 1ns / 1ps

module tb_mogol_bahis(

    );
    
    reg  saat;
    reg  reset;
    reg  [9:0] beyaz_at_hizlar;
    reg  [9:0] siyah_at_hizlar;
    reg  [9:0] boz_at_hizlar;
    reg  [9:0] beyaz_jokey_komutlar;
    reg  [9:0] siyah_jokey_komutlar;
    reg  [9:0] boz_jokey_komutlar;
    reg  [2:0] beyaz_at_seyirci;
    reg  [2:0] siyah_at_seyirci;
    reg  [2:0] boz_at_seyirci;
    reg  [1:0] tahmin_edilen_at;
    reg  [6:0] yatirilan_para;
    wire [13:0] bakiye;
    
    mogol_bahis mogol_bahis_dut(
        .saat(saat),
        .reset(reset),
        .beyaz_at_hizlar(beyaz_at_hizlar),
        .siyah_at_hizlar(siyah_at_hizlar),
        .boz_at_hizlar(boz_at_hizlar),
        .beyaz_jokey_komutlar(beyaz_jokey_komutlar),
        .siyah_jokey_komutlar(siyah_jokey_komutlar),
        .boz_jokey_komutlar(boz_jokey_komutlar),
        .beyaz_at_seyirci(beyaz_at_seyirci),
        .siyah_at_seyirci(siyah_at_seyirci),
        .boz_at_seyirci(boz_at_seyirci),
        .tahmin_edilen_at(tahmin_edilen_at),
        .yatirilan_para(yatirilan_para),
        .bakiye(bakiye)
    );
    
    always begin
        saat = ~saat; #0.5;
    end
    
    integer passes = 0;
    integer fails = 0;
    
    initial begin
        saat = 0;
        reset = 1;
        #5;
        reset = 0;
        
        beyaz_at_hizlar = 1023; siyah_at_hizlar = 1023; boz_at_hizlar = 1023;
        beyaz_jokey_komutlar = 1023; siyah_jokey_komutlar = 1023; boz_jokey_komutlar = 1023;
        beyaz_at_seyirci = 7; siyah_at_seyirci = 7; boz_at_seyirci = 7;
        tahmin_edilen_at = 0; yatirilan_para = 127; #9;
        
        if($signed(bakiye) == 3302) begin
           $display("TEST1 PASSED");
           passes = passes + 1;
        end
        else begin
            $display("test1 failed, bakiye: %d", $signed(bakiye));
            fails = fails + 1;
        end
       
        #1;
       
        if($signed(bakiye) == 3683) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test2 failed, bakiye: %d", $signed(bakiye));
            fails = fails + 1;
        end
       
        #1;
        
        if($signed(bakiye) == 3683) begin
            $display("TEST3 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test3 failed, bakiye: %d", $signed(bakiye));
            fails = fails + 1;
        end
        
        reset = 1;
        #41;
        reset = 0;
       
        beyaz_at_hizlar = 1023; siyah_at_hizlar = 1023; boz_at_hizlar = 1023;
        beyaz_jokey_komutlar = 1023; siyah_jokey_komutlar = 1023; boz_jokey_komutlar = 1023;
        beyaz_at_seyirci = 7; siyah_at_seyirci = 7; boz_at_seyirci = 7;
        tahmin_edilen_at = 0; yatirilan_para = 127; #2; 
        tahmin_edilen_at = 3; #1; 
        tahmin_edilen_at = 0; #2;
        tahmin_edilen_at = 2; yatirilan_para = 10; #1;
        tahmin_edilen_at = 0; #1;
        tahmin_edilen_at = 1; yatirilan_para = 55; #134;
         
        if($signed(bakiye) == 82) begin
            $display("TEST4 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test4 failed, bakiye: %d", $signed(bakiye));
            fails = fails + 1;
        end
        
        reset = 1;
        #1;
        reset = 0;
       
        beyaz_at_hizlar = 12; siyah_at_hizlar = 256; boz_at_hizlar = 785;
        beyaz_jokey_komutlar = 23; siyah_jokey_komutlar = 44; boz_jokey_komutlar = 999;
        beyaz_at_seyirci = 1; siyah_at_seyirci = 0; boz_at_seyirci = 2;
        tahmin_edilen_at = 1; yatirilan_para = 67; #1; 
        tahmin_edilen_at = 0; #1;
        tahmin_edilen_at = 3; #1;
        tahmin_edilen_at = 2; yatirilan_para = 42; #5;
        tahmin_edilen_at = 1; yatirilan_para = 12; #113;
         
        if($signed(bakiye) == -312) begin
            $display("TEST5 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test5 failed, bakiye: %d", $signed(bakiye));
            fails = fails + 1;
        end
        
        reset = 1;
        #1;
        reset = 0;
       
        beyaz_at_hizlar = 0; siyah_at_hizlar = 0; boz_at_hizlar = 0;
        beyaz_jokey_komutlar = 0; siyah_jokey_komutlar = 0; boz_jokey_komutlar = 0;
        beyaz_at_seyirci = 0; siyah_at_seyirci = 0; boz_at_seyirci = 0;
        tahmin_edilen_at = 1; yatirilan_para = 127; #11;
         
        if($signed(bakiye) == -5080) begin
            $display("TEST6 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test6 failed, bakiye: %d", $signed(bakiye));
            fails = fails + 1;
        end
        
        if(passes == 6) $display("ALL PASSED!\n");
        if(fails  == 6) $display("all failed!\n");
        
        $finish;
    end
    
endmodule
