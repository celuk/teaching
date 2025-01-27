`timescale 1ns / 1ps

module tb_takvim(

    );
    
    reg [3:0] yil;
    reg [10:0] gun;
    reg [9:0] saat;
    wire [4:0] yil_sonuc;
    wire [3:0] ay_sonuc;
    wire [2:0] haftanin_gunu_sonuc;
    wire artik_yil;
    
    takvim takvim_dut(
        .yil(yil),
        .gun(gun),
        .saat(saat),
        .yil_sonuc(yil_sonuc),
        .ay_sonuc(ay_sonuc),
        .haftanin_gunu_sonuc(haftanin_gunu_sonuc),
        .artik_yil(artik_yil)
    );
    
    integer passes = 0;
    integer fails = 0;
    
    initial begin
        yil = 3; gun = 1000; saat = 500; #1;
        if(yil_sonuc == 5 && ay_sonuc == 10 && haftanin_gunu_sonuc == 2 && artik_yil == 0) begin
            $display("TEST1 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test1 failed, yil: %d, ay: %d, haftanin_gunu: %d, artik_yil: %d", yil_sonuc, ay_sonuc, haftanin_gunu_sonuc, artik_yil);
            fails = fails + 1;
        end
        
        yil = 0; gun = 1; saat = 0; #1;
        if(yil_sonuc == 0 && ay_sonuc == 0 && haftanin_gunu_sonuc == 1 && artik_yil == 1) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test2 failed, yil: %d, ay: %d, haftanin_gunu: %d, artik_yil: %d", yil_sonuc, ay_sonuc, haftanin_gunu_sonuc, artik_yil);
            fails = fails + 1;
        end
        
        yil = 0; gun = 0; saat = 24; #1;
        if(yil_sonuc == 0 && ay_sonuc == 0 && haftanin_gunu_sonuc == 1 && artik_yil == 1) begin
            $display("TEST3 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test3 failed, yil: %d, ay: %d, haftanin_gunu: %d, artik_yil: %d", yil_sonuc, ay_sonuc, haftanin_gunu_sonuc, artik_yil);
            fails = fails + 1;
        end
        
        yil = 0; gun = 0; saat = 8; #1;
        if(yil_sonuc == 0 && ay_sonuc == 0 && haftanin_gunu_sonuc == 0 && artik_yil == 1) begin
            $display("TEST4 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test4 failed, yil: %d, ay: %d, haftanin_gunu: %d, artik_yil: %d", yil_sonuc, ay_sonuc, haftanin_gunu_sonuc, artik_yil);
            fails = fails + 1;
        end
        
        yil = 15; gun = 2047; saat = 1023; #1;
        if(yil_sonuc == 20 && ay_sonuc == 9 && haftanin_gunu_sonuc == 1 && artik_yil == 1) begin
            $display("TEST5 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test5 failed, yil: %d, ay: %d, haftanin_gunu: %d, artik_yil: %d", yil_sonuc, ay_sonuc, haftanin_gunu_sonuc, artik_yil);
            fails = fails + 1;
        end
        
        yil = 0; gun = 0; saat = 0; #1;
        if(yil_sonuc == 0 && ay_sonuc == 0 && haftanin_gunu_sonuc == 0 && artik_yil == 1) begin
            $display("TEST6 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test6 failed, yil: %d, ay: %d, haftanin_gunu: %d, artik_yil: %d", yil_sonuc, ay_sonuc, haftanin_gunu_sonuc, artik_yil);
            fails = fails + 1;
        end
        
        yil = 8; gun = 358; saat = 0; #1;
        if(yil_sonuc == 9 && ay_sonuc == 0 && haftanin_gunu_sonuc == 5 && artik_yil == 0) begin
            $display("TEST7 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test7 failed, yil: %d, ay: %d, haftanin_gunu: %d, artik_yil: %d", yil_sonuc, ay_sonuc, haftanin_gunu_sonuc, artik_yil);
            fails = fails + 1;
        end
        
        yil = 7; gun = 359; saat = 0; #1;
        if(yil_sonuc == 8 && ay_sonuc == 0 && haftanin_gunu_sonuc == 4 && artik_yil == 1) begin
            $display("TEST8 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test8 failed, yil: %d, ay: %d, haftanin_gunu: %d, artik_yil: %d", yil_sonuc, ay_sonuc, haftanin_gunu_sonuc, artik_yil);
            fails = fails + 1;
        end
        
        yil = 0; gun = 1500; saat = 17; #1;
        if(yil_sonuc == 4 && ay_sonuc == 2 && haftanin_gunu_sonuc == 2 && artik_yil == 1) begin
            $display("TEST9 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test9 failed, yil: %d, ay: %d, haftanin_gunu: %d, artik_yil: %d", yil_sonuc, ay_sonuc, haftanin_gunu_sonuc, artik_yil);
            fails = fails + 1;
        end
        
        yil = 1; gun = 2; saat = 1; #1;
        if(yil_sonuc == 1 && ay_sonuc == 0 && haftanin_gunu_sonuc == 4 && artik_yil == 0) begin
            $display("TEST10 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test10 failed, yil: %d, ay: %d, haftanin_gunu: %d, artik_yil: %d", yil_sonuc, ay_sonuc, haftanin_gunu_sonuc, artik_yil);
            fails = fails + 1;
        end
        
        $display("%d passes, %d fails\n", passes, fails);
        
        if(passes == 10) $display("ALL PASSED!\n");
        if(fails  == 10) $display("all failed!\n");
        
        $finish;
    end
    
endmodule

