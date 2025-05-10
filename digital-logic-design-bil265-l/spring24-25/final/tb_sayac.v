`timescale 1ns / 1ps

module tb_sayac(

    );

    reg saat;
    reg reset;
    reg basla;
    reg [7:0] baslangic_degeri;
    reg yon;
    reg [2:0] miktar;
    wire [7:0] sonuc;
    wire hazir;
    wire mesgul;
    wire [2:0] cikis_miktar;
    wire cikis_yon;

    sayac sayac_dut (
        .saat(saat),
        .reset(reset),
        .basla(basla),
        .baslangic_degeri(baslangic_degeri),
        .yon(yon),
        .miktar(miktar),
        .sonuc(sonuc),
        .hazir(hazir),
        .mesgul(mesgul),
        .cikis_miktar(cikis_miktar),
        .cikis_yon(cikis_yon)
    );

    wire [7:0] sonuc_test;
    wire hazir_test;
    wire mesgul_test;
    wire [2:0] cikis_miktar_test;
    wire cikis_yon_test;
    sayac_test sayac_test_dut (
        .saat(saat),
        .reset(reset),
        .basla(basla),
        .baslangic_degeri(baslangic_degeri),
        .yon(yon),
        .miktar(miktar),
        .sonuc(sonuc_test),
        .hazir(hazir_test),
        .mesgul(mesgul_test),
        .cikis_miktar(cikis_miktar_test),
        .cikis_yon(cikis_yon_test)
    );

    always begin
        #0.5 saat = ~saat;
    end

    integer corrects = 0;
    integer total_corrects = 0;

    integer passes = 0;
    integer fails = 0;

    initial begin
        saat = 0;
        reset = 1;
        #1;
        reset = 0;

        corrects = 0;
        baslangic_degeri = 0;
        yon = 1;
        miktar = 3;
        basla = 1; #1; //$display("sonuc: %d, hazir: %d, mesgul: %d", sonuc, hazir, mesgul);
        basla = 0;
        while(mesgul) begin
            if(sonuc == sonuc_test && hazir == hazir_test) begin
                corrects = corrects + 1;
            end
            #1; //$display("sonuc: %d, hazir: %d, mesgul: %d", sonuc, hazir, mesgul);
        end
        if(sonuc == 255 && hazir == 0 && mesgul == 0) begin
            $display("TEST1 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test1 failed, sonuc: %d, hazir: %d, mesgul: %d, corrects: %d", sonuc, hazir, mesgul, corrects);
            fails = fails + 1;
        end
        total_corrects = total_corrects + corrects;

        reset = 1;
        #1;
        reset = 0;

        corrects = 0;
        baslangic_degeri = 250;
        yon = 0;
        miktar = 7;
        basla = 1; #1; //$display("sonuc: %d, hazir: %d, mesgul: %d", sonuc, hazir, mesgul);
        basla = 0;
        while(mesgul) begin
            if(sonuc == sonuc_test && hazir == hazir_test) begin
                corrects = corrects + 1;
            end
            #1; //$display("sonuc: %d, hazir: %d, mesgul: %d", sonuc, hazir, mesgul);
        end
        if(sonuc == 3 && hazir == 0 && mesgul == 0) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test2 failed, sonuc: %d, hazir: %d, mesgul: %d, corrects: %d", sonuc, hazir, mesgul, corrects);
            fails = fails + 1;
        end
        total_corrects = total_corrects + corrects;

        reset = 1;
        #1;
        reset = 0;

        corrects = 0;
        baslangic_degeri = 105;
        yon = 1;
        miktar = 4;
        basla = 1; #1; //$display("sonuc: %d, hazir: %d, mesgul: %d", sonuc, hazir, mesgul);
        basla = 0;
        while(mesgul) begin
            if(sonuc == sonuc_test && hazir == hazir_test) begin
                corrects = corrects + 1;
            end
            #1; //$display("sonuc: %d, hazir: %d, mesgul: %d", sonuc, hazir, mesgul);
        end
        if(sonuc == 253 && hazir == 0 && mesgul == 0) begin
            $display("TEST3 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test3 failed, sonuc: %d, hazir: %d, mesgul: %d, corrects: %d", sonuc, hazir, mesgul, corrects);
            fails = fails + 1;
        end
        total_corrects = total_corrects + corrects;

        reset = 1;
        #1;
        reset = 0;

        corrects = 0;
        baslangic_degeri = 50;
        yon = 1;
        miktar = 1;
        basla = 1; #1; //$display("sonuc: %d, hazir: %d, mesgul: %d", sonuc, hazir, mesgul);
        basla = 0;
        while(mesgul) begin
            if(sonuc == sonuc_test && hazir == hazir_test) begin
                corrects = corrects + 1;
            end
            #1; //$display("sonuc: %d, hazir: %d, mesgul: %d", sonuc, hazir, mesgul);
        end
        if(sonuc == 255 && hazir == 0 && mesgul == 0) begin
            $display("TEST4 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test4 failed, sonuc: %d, hazir: %d, mesgul: %d, corrects: %d", sonuc, hazir, mesgul, corrects);
            fails = fails + 1;
        end
        total_corrects = total_corrects + corrects;

        corrects = 0;
        baslangic_degeri = 50;
        yon = 0;
        miktar = 0;
        basla = 1; #1; //$display("sonuc: %d, hazir: %d, mesgul: %d", sonuc, hazir, mesgul);
        basla = 0;
        while(mesgul) begin
            if(sonuc == sonuc_test && hazir == hazir_test) begin
                corrects = corrects + 1;
            end
            #1; //$display("sonuc: %d, hazir: %d, mesgul: %d", sonuc, hazir, mesgul);
        end
        if(sonuc == 50 && hazir == 0 && mesgul == 0) begin
            $display("TEST5 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test5 failed, sonuc: %d, hazir: %d, mesgul: %d, corrects: %d", sonuc, hazir, mesgul, corrects);
            fails = fails + 1;
        end
        total_corrects = total_corrects + corrects;

        corrects = 0;
        baslangic_degeri = 50;
        yon = 0;
        miktar = 1;
        basla = 1; #1; //$display("sonuc: %d, hazir: %d, mesgul: %d", sonuc, hazir, mesgul);
        basla = 0;
        while(mesgul) begin
            if(sonuc == sonuc_test && hazir == hazir_test) begin
                corrects = corrects + 1;
            end
            #1; //$display("sonuc: %d, hazir: %d, mesgul: %d", sonuc, hazir, mesgul);
        end
        if(sonuc == 0 && hazir == 0 && mesgul == 0) begin
            $display("TEST6 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test6 failed, sonuc: %d, hazir: %d, mesgul: %d, corrects: %d", sonuc, hazir, mesgul, corrects);
            fails = fails + 1;
        end
        total_corrects = total_corrects + corrects;

        $display("%d passes, %d fails, %d corrects\n", passes, fails, total_corrects);
        
        if(passes == 6 && total_corrects == 692) $display("ALL PASSED!\n");
        if(fails  == 6) $display("all failed!\n");

        $finish;
    end

endmodule

module sayac_test(
    input saat,
    input reset,
    input basla,
    input [7:0] baslangic_degeri,
    input yon,
    input [2:0] miktar,
    output reg [7:0] sonuc,
    output reg hazir,
    output reg mesgul,
    output [2:0] cikis_miktar,
    output cikis_yon
    );

    assign cikis_miktar = miktar;
    assign cikis_yon = yon;

    reg [7:0] sonuc_sonraki;
    reg hazir_sonraki;
    reg mesgul_sonraki;

    reg sayac_yon_sonraki;
    reg sayac_yon;

    always @* begin
        sonuc_sonraki = sonuc;
        hazir_sonraki = 0;
        mesgul_sonraki = 0;
        sayac_yon_sonraki = sayac_yon;

        if(~mesgul) begin
            if(basla) begin
                mesgul_sonraki = 1;
                
                sonuc_sonraki = baslangic_degeri;

                sayac_yon_sonraki = yon;

                if(miktar == 0) begin
                    hazir_sonraki = 1;
                end

                if(yon) begin
                    if((baslangic_degeri + miktar) > 255) begin
                        hazir_sonraki = 1;
                    end
                end
                else begin
                    if (baslangic_degeri < miktar) begin
                        hazir_sonraki = 1;
                    end
                end
            end
        end
        else begin // sayma islemi
            // 1 cevrim sonra mesgulu 0 yapmak için
            if(miktar == 0 
               || (yon && ((baslangic_degeri + miktar) > 255))
               || (~yon && (baslangic_degeri < miktar))
               || (yon && sayac_yon && ((sonuc + miktar) > 255)) // sinir kosullari
               || (yon && ~sayac_yon && ((sonuc + miktar - 1) > 255))
               || (~yon && sayac_yon && ((sonuc+1) < miktar))
               || (~yon && ~sayac_yon && (sonuc < miktar))) begin
                mesgul_sonraki = 0;
            end
            else begin
                mesgul_sonraki = 1;
                
                if(yon) begin
                    if(sayac_yon) begin
                        sonuc_sonraki = sonuc + miktar;

                        if (miktar == 1 && ((sonuc_sonraki + miktar) > 255)) begin
                            hazir_sonraki = 1;
                        end
                        else if((sonuc_sonraki + miktar - 1) > 255) begin // 1 azalip miktar artip asmiyorsa
                            hazir_sonraki = 1;
                        end
                    end
                    else begin
                        sonuc_sonraki = sonuc - 1;

                        if((sonuc_sonraki + miktar) > 255) begin
                            hazir_sonraki = 1;
                        end
                    end
                end
                else begin
                    if(sayac_yon) begin
                        sonuc_sonraki = sonuc + 1;

                        if (sonuc_sonraki < miktar) begin
                            hazir_sonraki = 1;
                        end
                    end
                    else begin
                        sonuc_sonraki = sonuc - miktar;

                        if (miktar == 1 && (sonuc_sonraki < miktar)) begin
                            hazir_sonraki = 1;
                        end
                        else if (sonuc_sonraki + 1 < miktar) begin // 1 artip miktar azalip asmiyorsa
                            hazir_sonraki = 1;
                        end
                    end
                end

                if(miktar == 1) begin
                    sayac_yon_sonraki = sayac_yon;
                end
                else begin
                    sayac_yon_sonraki = ~sayac_yon; // ...-ileri-geri-ileri-...
                end
            end
        end
    end

    always @(posedge saat) begin
        if(reset) begin
            sonuc <= 0;
            hazir <= 0;
            mesgul <= 0;
            sayac_yon <= 0;
        end
        else begin
            sonuc <= sonuc_sonraki;
            hazir <= hazir_sonraki;
            mesgul <= mesgul_sonraki;
            sayac_yon <= sayac_yon_sonraki;
        end
    end
    
endmodule
