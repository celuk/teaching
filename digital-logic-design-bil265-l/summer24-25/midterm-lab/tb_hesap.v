`timescale 1ns / 1ps

module tb_hesap(

    );

    reg [3:0] sayi;
    wire asal;
    wire tek;
    wire kat4;
    wire tamkare;
    
    hesap hesap_dut(
        .sayi(sayi),
        .asal(asal),
        .tek(tek),
        .kat4(kat4),
        .tamkare(tamkare)
    );
    
    reg asal_ans [15:0];
    reg tek_ans [15:0];
    reg kat4_ans [15:0];
    reg tamkare_ans [15:0];
    
    integer i;
    integer passes = 0;
    integer fails = 0;
    
    initial begin
        asal_ans[0 ] = 0; tek_ans[0 ] = 0; kat4_ans[0 ] = 1; tamkare_ans[0 ] = 0;
        asal_ans[1 ] = 0; tek_ans[1 ] = 1; kat4_ans[1 ] = 0; tamkare_ans[1 ] = 1;
        asal_ans[2 ] = 1; tek_ans[2 ] = 0; kat4_ans[2 ] = 0; tamkare_ans[2 ] = 0;
        asal_ans[3 ] = 1; tek_ans[3 ] = 1; kat4_ans[3 ] = 0; tamkare_ans[3 ] = 0;
        asal_ans[4 ] = 0; tek_ans[4 ] = 0; kat4_ans[4 ] = 1; tamkare_ans[4 ] = 1;
        asal_ans[5 ] = 1; tek_ans[5 ] = 1; kat4_ans[5 ] = 0; tamkare_ans[5 ] = 0;
        asal_ans[6 ] = 0; tek_ans[6 ] = 0; kat4_ans[6 ] = 0; tamkare_ans[6 ] = 0;
        asal_ans[7 ] = 1; tek_ans[7 ] = 1; kat4_ans[7 ] = 0; tamkare_ans[7 ] = 0;
        asal_ans[8 ] = 0; tek_ans[8 ] = 0; kat4_ans[8 ] = 1; tamkare_ans[8 ] = 0;
        asal_ans[9 ] = 0; tek_ans[9 ] = 1; kat4_ans[9 ] = 0; tamkare_ans[9 ] = 1;
        asal_ans[10] = 0; tek_ans[10] = 0; kat4_ans[10] = 0; tamkare_ans[10] = 0;
        asal_ans[11] = 1; tek_ans[11] = 1; kat4_ans[11] = 0; tamkare_ans[11] = 0;
        asal_ans[12] = 0; tek_ans[12] = 0; kat4_ans[12] = 1; tamkare_ans[12] = 0;
        asal_ans[13] = 1; tek_ans[13] = 1; kat4_ans[13] = 0; tamkare_ans[13] = 0;
        asal_ans[14] = 0; tek_ans[14] = 0; kat4_ans[14] = 0; tamkare_ans[14] = 0;
        asal_ans[15] = 0; tek_ans[15] = 1; kat4_ans[15] = 0; tamkare_ans[15] = 0;
        
        for(i=0; i<16; i=i+1) begin
            sayi = i; #1;

            if((asal == asal_ans[i]) && (tek == tek_ans[i]) && (kat4 == kat4_ans[i]) && (tamkare == tamkare_ans[i])) begin
                passes = passes + 1;
            end
            else begin
                fails = fails + 1;
                $display("failed, sayi: %d, asal: %b, tek: %b, kat4: %b, tamkare: %b", i, asal, tek, kat4, tamkare);
                if(asal == asal_ans[i]) $display("asal dogru");
                else $display("asal yanlis");
                if(tek == tek_ans[i]) $display("tek dogru");
                else $display("tek yanlis");
                if(kat4 == kat4_ans[i]) $display("kat4 dogru");
                else $display("kat4 yanlis");
                if(tamkare == tamkare_ans[i]) $display("tamkare dogru");
                else $display("tamkare yanlis");
            end
        end
        
        $display("\n%d passes, %d fails\n", passes, fails);
        
        if(passes == 16) $display("ALL PASSED!\n");
        if(fails  == 16) $display("all failed!\n");
    end
endmodule
