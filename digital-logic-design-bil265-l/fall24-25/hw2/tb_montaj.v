`timescale 1ns / 1ps

module tb_montaj(

    );

    reg saat;
    reg reset;
    reg basla;
    reg [2:0] govde;
    reg [2:0] ekran;
    reg [2:0] batarya;
    wire bitti;
    wire montaja_uygun;
    wire [1:0] uretim_tipi;
    wire montaj_kalitesi;

    montaj montaj_dut(
        .saat(saat),
        .reset(reset),
        .basla(basla),
        .govde(govde),
        .ekran(ekran),
        .batarya(batarya),
        .bitti(bitti),
        .montaja_uygun(montaja_uygun),
        .uretim_tipi(uretim_tipi),
        .montaj_kalitesi(montaj_kalitesi)
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

        basla = 1; govde = 3'b001; ekran = 3'b001; batarya = 3'b001; #1;
        if(montaja_uygun == 1 && uretim_tipi == 0 && montaj_kalitesi == 1 && bitti == 1) begin
            $display("TEST1 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test1 failed, montaja_uygun: %d, uretim_tipi: %d, montaj_kalitesi: %d, bitti: %d", montaja_uygun, uretim_tipi, montaj_kalitesi, bitti);
            fails = fails + 1;
        end
        
        reset = 1;
        #55;
        reset = 0;
        
        basla = 1; govde = 3'b011; ekran = 3'b101; batarya = 3'b110; #1;
        if(montaja_uygun == 1 && uretim_tipi == 2 && montaj_kalitesi == 0 && bitti == 1) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test2 failed, montaja_uygun: %d, uretim_tipi: %d, montaj_kalitesi: %d, bitti: %d", montaja_uygun, uretim_tipi, montaj_kalitesi, bitti);
            fails = fails + 1;
        end

        basla = 0; govde = 3'b111; ekran = 3'b001; batarya = 3'b010; #1;
        if(bitti == 0) begin
            $display("TEST3 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test3 failed, montaja_uygun: %d, uretim_tipi: %d, montaj_kalitesi: %d, bitti: %d", montaja_uygun, uretim_tipi, montaj_kalitesi, bitti);
            fails = fails + 1;
        end

        basla = 1; govde = 3'b001; ekran = 3'b010; batarya = 3'b100; #1;
        if(montaja_uygun == 0 && bitti == 1) begin
            $display("TEST4 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test4 failed, montaja_uygun: %d, uretim_tipi: %d, montaj_kalitesi: %d, bitti: %d", montaja_uygun, uretim_tipi, montaj_kalitesi, bitti);
            fails = fails + 1;
        end

        basla = 1; govde = 3'b101; ekran = 3'b100; batarya = 3'b111; #1;
        if(montaja_uygun == 1 && uretim_tipi == 2 && montaj_kalitesi == 1 && bitti == 1) begin
            $display("TEST5 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test5 failed, montaja_uygun: %d, uretim_tipi: %d, montaj_kalitesi: %d, bitti: %d", montaja_uygun, uretim_tipi, montaj_kalitesi, bitti);
            fails = fails + 1;
        end
        
        $display("%d passes, %d fails\n", passes, fails);
        
        if(passes == 5) $display("ALL PASSED!\n");
        if(fails  == 5) $display("all failed!\n");
        
        $finish;
    end

endmodule
