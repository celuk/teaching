`timescale 1ns / 1ps

module tb_kontrol(

    );

    reg saat;
    reg reset;
    reg basla;
    reg montaja_uygun;
    reg [1:0] uretim_tipi;
    reg montaj_kalitesi;
    reg isletim_sistemi;
    wire bitti;
    wire kalite;
    wire kontrol_sonucu;

    kontrol kontrol_dut(
        .saat(saat),
        .reset(reset),
        .basla(basla),
        .montaja_uygun(montaja_uygun),
        .uretim_tipi(uretim_tipi),
        .montaj_kalitesi(montaj_kalitesi),
        .isletim_sistemi(isletim_sistemi),
        .bitti(bitti),
        .kalite(kalite),
        .kontrol_sonucu(kontrol_sonucu)
    );

    always begin
        saat = ~saat; #0.5;
    end

    integer passes = 0;
    integer fails = 0;

    initial begin
        saat = 0;
        reset = 1;
        #1;
        reset = 0;

        basla = 1; montaja_uygun = 1; uretim_tipi = 0; montaj_kalitesi = 0; isletim_sistemi = 0; #1;
        if(kalite == 0 && kontrol_sonucu == 0 && bitti == 1) begin
            $display("TEST1 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test1 failed, kalite: %d, kontrol_sonucu: %d, bitti: %d", kalite, kontrol_sonucu, bitti);
            fails = fails + 1;
        end
        
        reset = 1;
        #55;
        reset = 0;
        
        basla = 1; montaja_uygun = 0; uretim_tipi = 2; montaj_kalitesi = 1; isletim_sistemi = 0; #1;
        if(kontrol_sonucu == 0 && bitti == 1) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test2 failed, kalite: %d, kontrol_sonucu: %d, bitti: %d", kalite, kontrol_sonucu, bitti);
            fails = fails + 1;
        end
        
        basla = 0; montaja_uygun = 1; uretim_tipi = 0; montaj_kalitesi = 1; isletim_sistemi = 1; #1;
        if(bitti == 0) begin
            $display("TEST3 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test3 failed, kalite: %d, kontrol_sonucu: %d, bitti: %d", kalite, kontrol_sonucu, bitti);
            fails = fails + 1;
        end

        basla = 1; montaja_uygun = 1; uretim_tipi = 2; montaj_kalitesi = 0; isletim_sistemi = 1; #1;
        if(kalite == 0 && kontrol_sonucu == 1 && bitti == 1) begin
            $display("TEST4 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test4 failed, kalite: %d, kontrol_sonucu: %d, bitti: %d", kalite, kontrol_sonucu, bitti);
            fails = fails + 1;
        end

        basla = 1; montaja_uygun = 1; uretim_tipi = 2; montaj_kalitesi = 1; isletim_sistemi = 1; #1;
        if(kalite == 1 && kontrol_sonucu == 1 && bitti == 1) begin
            $display("TEST5 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test5 failed, kalite: %d, kontrol_sonucu: %d, bitti: %d", kalite, kontrol_sonucu, bitti);
            fails = fails + 1;
        end

        $display("%d passes, %d fails\n", passes, fails);
        
        if(passes == 5) $display("ALL PASSED!\n");
        if(fails  == 5) $display("all failed!\n");
        
        $finish;
    end
    
endmodule
