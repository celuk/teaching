`timescale 1ns / 1ps

module tb_tahmin(

    );

    reg [1:0] sag_adim;
    reg [1:0] asagi_adim;
    reg [3:0] sayi;
    wire [3:0] sayi_tahmin;
    wire tahmin_dogru;
    
    tahmin tahmin_dut(
        .sag_adim(sag_adim),
        .asagi_adim(asagi_adim),
        .sayi(sayi),
        .sayi_tahmin(sayi_tahmin),
        .tahmin_dogru(tahmin_dogru)
    );
    
    reg [1:0] sag_adim_ans [15:0];
    reg [1:0] asagi_adim_ans [15:0];
    reg [3:0] sayi_tahmin_ans [15:0];
    
    integer i;
    integer j;
    integer passes = 0;
    integer fails = 0;
    
    initial begin
        sag_adim_ans[0 ] = 0; asagi_adim_ans[0 ] = 0; sayi_tahmin_ans[0 ] = 1;
        sag_adim_ans[1 ] = 0; asagi_adim_ans[1 ] = 1; sayi_tahmin_ans[1 ] = 4;
        sag_adim_ans[2 ] = 0; asagi_adim_ans[2 ] = 2; sayi_tahmin_ans[2 ] = 7;
        sag_adim_ans[3 ] = 0; asagi_adim_ans[3 ] = 3; sayi_tahmin_ans[3 ] = 7;
        sag_adim_ans[4 ] = 1; asagi_adim_ans[4 ] = 0; sayi_tahmin_ans[4 ] = 2;
        sag_adim_ans[5 ] = 1; asagi_adim_ans[5 ] = 1; sayi_tahmin_ans[5 ] = 5;
        sag_adim_ans[6 ] = 1; asagi_adim_ans[6 ] = 2; sayi_tahmin_ans[6 ] = 8;
        sag_adim_ans[7 ] = 1; asagi_adim_ans[7 ] = 3; sayi_tahmin_ans[7 ] = 8;
        sag_adim_ans[8 ] = 2; asagi_adim_ans[8 ] = 0; sayi_tahmin_ans[8 ] = 3;
        sag_adim_ans[9 ] = 2; asagi_adim_ans[9 ] = 1; sayi_tahmin_ans[9 ] = 6;
        sag_adim_ans[10] = 2; asagi_adim_ans[10] = 2; sayi_tahmin_ans[10] = 9;
        sag_adim_ans[11] = 2; asagi_adim_ans[11] = 3; sayi_tahmin_ans[11] = 9;
        sag_adim_ans[12] = 3; asagi_adim_ans[12] = 0; sayi_tahmin_ans[12] = 3;
        sag_adim_ans[13] = 3; asagi_adim_ans[13] = 1; sayi_tahmin_ans[13] = 6;
        sag_adim_ans[14] = 3; asagi_adim_ans[14] = 2; sayi_tahmin_ans[14] = 9;
        sag_adim_ans[15] = 3; asagi_adim_ans[15] = 3; sayi_tahmin_ans[15] = 9;
        
        for(i=0; i<16; i=i+1) begin
            for(j=1; j<=9; j=j+1) begin
                sag_adim = sag_adim_ans[i]; asagi_adim = asagi_adim_ans[i]; sayi = j; #1;
                if(&(sayi_tahmin_ans[i] ~^ j) == tahmin_dogru) begin
                    passes = passes + 1;
                end
                else begin
                    fails = fails + 1;
                end
            end
        end
        
        $display("\n%d passes, %d fails\n", passes, fails);
        
        if(passes == 144) $display("ALL PASSED!\n");
        if(fails  == 144) $display("all failed!\n");
    end
    
endmodule
