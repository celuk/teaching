`timescale 1ns / 1ps

module tb_garip_sifreleme(

    );
    
    localparam BIT = 4;
    
    reg saat;
    reg reset;
    reg basla;
    reg mod;
    reg [BIT-1:0] veri;
    reg [2:0] secim;
    
    wire bit_cikisi;
    wire gecerli;
    
    garip_sifreleme #(.BIT(BIT)) garip_sifreleme_dut(
        .saat(saat),
        .reset(reset),
        .basla(basla),
        .mod(mod),
        .veri(veri),
        .secim(secim),
        .bit_cikisi(bit_cikisi),
        .gecerli(gecerli)
    );
    
    always begin
        saat = ~saat; #0.5;
    end
    
    reg [BIT-1:0] sifrelenmis_veri;
    integer i;
    
    integer passes = 0;
    integer fails = 0;
    
    initial begin
        saat = 0;
        reset = 1;
        #1;
        reset = 0;
        
        basla = 1; mod = 1; veri = 13; secim = 6; #1; basla = 0;
        while(!gecerli) #1;
        for(i = 0; i < BIT; i=i+1) begin
            sifrelenmis_veri[i] = bit_cikisi;
            #1; 
        end
        
        if(gecerli == 0 && sifrelenmis_veri == 0) begin
            $display("TEST1 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test1 failed, gecerli: %d, sifrelenmis_veri: %d", gecerli, sifrelenmis_veri);
            fails = fails + 1;
        end
        
        reset = 1;
        #55;
        reset = 0;
        
        basla = 1; mod = 1; veri = 11; secim = 7; #1; basla = 0;
        while(!gecerli) #1;
        if(bit_cikisi == 0) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test2 failed, bit_cikisi: %d", bit_cikisi);
            fails = fails + 1;
        end
        #1;
        if(bit_cikisi == 0) begin
            $display("TEST3 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test3 failed, bit_cikisi: %d", bit_cikisi);
            fails = fails + 1;
        end
        for(i = 1; i < BIT; i=i+1) begin
            sifrelenmis_veri[i] = bit_cikisi;
            #1;
        end
        if(gecerli == 0 && sifrelenmis_veri == 4) begin
            $display("TEST4 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test4 failed, gecerli: %d, sifrelenmis_veri: %d", gecerli, sifrelenmis_veri);
            fails = fails + 1;
        end
        
        #10;
        basla = 1; mod = 0; veri = 6; secim = 3; #1; basla = 0;
        while(!gecerli) #1;
        for(i = 0; i < BIT; i=i+1) begin
            sifrelenmis_veri[i] = bit_cikisi;
            #1; 
        end
        
        if(gecerli == 0 && sifrelenmis_veri == 9) begin
            $display("TEST5 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test5 failed, gecerli: %d, sifrelenmis_veri: %d", gecerli, sifrelenmis_veri);
            fails = fails + 1;
        end
        
        $display("%d passes, %d fails\n", passes, fails);
        
        if(passes == 5) $display("ALL PASSED!\n");
        if(fails  == 5) $display("all failed!\n");
        
        $finish;
    end
    
endmodule

