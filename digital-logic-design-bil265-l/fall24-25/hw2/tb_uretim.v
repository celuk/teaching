`timescale 1ns / 1ps

module tb_uretim(

    );

    reg saat;
    reg reset;
    reg [2:0] govde;
    reg [2:0] ekran;
    reg [2:0] batarya;
    reg isletim_sistemi;
    reg [9:0] kapasite;
    reg bandrol;
    wire kalite;
    wire [2:0] maliyet;
    wire [9:0] telefon_sayisi;

    uretim uretim_dut(
        .saat(saat),
        .reset(reset),
        .govde(govde),
        .ekran(ekran),
        .batarya(batarya),
        .isletim_sistemi(isletim_sistemi),
        .kapasite(kapasite),
        .bandrol(bandrol),
        .kalite(kalite),
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

        govde = 3'b001; ekran = 3'b010; batarya = 3'b100; isletim_sistemi = 1; kapasite = 512; bandrol = 1; #3;
        govde = 3'b011; ekran = 3'b011; batarya = 3'b011; isletim_sistemi = 0; kapasite = 1023; bandrol = 1; #1;
        if(kalite == 0 && maliyet == 2 && telefon_sayisi == 0) begin
            $display("TEST1 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test1 failed, kalite: %d, maliyet: %d, telefon_sayisi: %d", kalite, maliyet, telefon_sayisi);
            fails = fails + 1;
        end
        
        reset = 1;
        #55;
        reset = 0;
        
        govde = 3'b100; ekran = 3'b100; batarya = 3'b100; isletim_sistemi = 1; kapasite = 256; bandrol = 0; #300;
        if(kalite == 1 && maliyet == 0 && telefon_sayisi == 256) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test2 failed, kalite: %d, maliyet: %d, telefon_sayisi: %d", kalite, maliyet, telefon_sayisi);
            fails = fails + 1;
        end

        reset = 1;
        #1;
        reset = 0;
        
        govde = 3'b010; ekran = 3'b011; batarya = 3'b001; isletim_sistemi = 1; kapasite = 128; bandrol = 1; #1;
        govde = 3'b001; ekran = 3'b100; batarya = 3'b010; isletim_sistemi = 0; kapasite = 64; bandrol = 0; #1;
        govde = 3'b011; ekran = 3'b010; batarya = 3'b011; isletim_sistemi = 1; kapasite = 512; bandrol = 1; #1;
        if(kalite == 0 && maliyet == 6 && telefon_sayisi == 1) begin
            $display("TEST3 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test3 failed, kalite: %d, maliyet: %d, telefon_sayisi: %d", kalite, maliyet, telefon_sayisi);
            fails = fails + 1;
        end

        govde = 3'b100; ekran = 3'b011; batarya = 3'b001; isletim_sistemi = 1; kapasite = 32; bandrol = 1; #20;
        govde = 3'b010; ekran = 3'b001; batarya = 3'b100; isletim_sistemi = 0; kapasite = 256; bandrol = 0; #20;
        govde = 3'b001; ekran = 3'b100; batarya = 3'b010; isletim_sistemi = 1; kapasite = 128; bandrol = 1; #4;
        govde = 3'b011; ekran = 3'b010; batarya = 3'b001; isletim_sistemi = 0; kapasite = 64; bandrol = 0; #3;
        if(kalite == 0 && maliyet == 3 && telefon_sayisi == 1) begin
            $display("TEST4 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test4 failed, kalite: %d, maliyet: %d, telefon_sayisi: %d", kalite, maliyet, telefon_sayisi);
            fails = fails + 1;
        end

        govde = 3'b110; ekran = 3'b101; batarya = 3'b111; isletim_sistemi = 0; kapasite = 1023; bandrol = 1; #56;
        if(kalite == 1 && maliyet == 2 && telefon_sayisi == 57) begin
            $display("TEST5 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test5 failed, kalite: %d, maliyet: %d, telefon_sayisi: %d", kalite, maliyet, telefon_sayisi);
            fails = fails + 1;
        end

        $display("%d passes, %d fails\n", passes, fails);
        
        if(passes == 5) $display("ALL PASSED!\n");
        if(fails  == 5) $display("all failed!\n");
        
        $finish;
    end
    
endmodule
