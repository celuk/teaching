`timescale 1ns / 1ps

module tb_paketleme(

    );

    reg saat;
    reg reset;
    reg basla;
    reg kontrol_sonucu;
    reg [9:0] kapasite;
    reg bandrol;
    wire bitti;
    wire [2:0] maliyet;
    wire [9:0] telefon_sayisi;

    paketleme paketleme_dut(
        .saat(saat),
        .reset(reset),
        .basla(basla),
        .kontrol_sonucu(kontrol_sonucu),
        .kapasite(kapasite),
        .bandrol(bandrol),
        .bitti(bitti),
        .maliyet(maliyet),
        .telefon_sayisi(telefon_sayisi)
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

        basla = 1; kontrol_sonucu = 0; kapasite = 0; bandrol = 0; #1;
        if(maliyet == 0 && telefon_sayisi == 0 && bitti == 1) begin
            $display("TEST1 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test1 failed, maliyet: %d, telefon_sayisi: %d, bitti: %d", maliyet, telefon_sayisi, bitti);
            fails = fails + 1;
        end
        
        reset = 1;
        #55;
        reset = 0;
        
        basla = 1; kontrol_sonucu = 1; kapasite = 81; bandrol = 1; #5;
        if(maliyet == 6 && telefon_sayisi == 5 && bitti == 1) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test2 failed, maliyet: %d, telefon_sayisi: %d, bitti: %d", maliyet, telefon_sayisi, bitti);
            fails = fails + 1;
        end

        basla = 0; kontrol_sonucu = 1; kapasite = 204; bandrol = 1; #2;
        if(bitti == 0) begin
            $display("TEST3 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test3 failed, maliyet: %d, telefon_sayisi: %d, bitti: %d", maliyet, telefon_sayisi, bitti);
            fails = fails + 1;
        end

        basla = 1; kontrol_sonucu = 1; kapasite = 1023; bandrol = 0; #1500;
        basla = 1; kontrol_sonucu = 1; kapasite = 5; bandrol = 1; #2;
        basla = 1; kontrol_sonucu = 1; kapasite = 40; bandrol = 0; #50;
        if(telefon_sayisi == 40 && bitti == 1) begin
            $display("TEST4 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test4 failed, maliyet: %d, telefon_sayisi: %d, bitti: %d", maliyet, telefon_sayisi, bitti);
            fails = fails + 1;
        end

        basla = 1; kontrol_sonucu = 1; kapasite = 100; bandrol = 1; #200;
        basla = 1; kontrol_sonucu = 1; kapasite = 199; bandrol = 1; #98;
        if(maliyet == 6 && telefon_sayisi == 198 && bitti == 1) begin
            $display("TEST5 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test5 failed, maliyet: %d, telefon_sayisi: %d, bitti: %d", maliyet, telefon_sayisi, bitti);
            fails = fails + 1;
        end

        $display("%d passes, %d fails\n", passes, fails);
        
        if(passes == 5) $display("ALL PASSED!\n");
        if(fails  == 5) $display("all failed!\n");
        
        $finish;
    end
    
endmodule
