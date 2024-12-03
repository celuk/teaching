`timescale 1ns / 1ps

module tb_kilit_acici(

    );
    
    reg [2:0] sag_adim;
    reg [1:0] sol_adim;
    reg [5:0] kilit_sifre;
    wire kilit_acik;
    
    kilit_acici kilit(
        .sag_adim(sag_adim),
        .sol_adim(sol_adim),
        .kilit_sifre(kilit_sifre),
        .kilit_acik(kilit_acik)
    );
    
    reg [2:0] sag_adim_ans [31:0];
    reg [1:0] sol_adim_ans [31:0];
    reg [5:0] sonuc_ans [31:0];
    
    integer i;
    integer j;
    integer passes = 0;
    integer fails = 0;
    
    initial begin
        sag_adim_ans[0 ] = 0; sol_adim_ans[0 ] = 0; sonuc_ans[0 ] = 0;
        sag_adim_ans[1 ] = 0; sol_adim_ans[1 ] = 1; sonuc_ans[1 ] = 30;
        sag_adim_ans[2 ] = 0; sol_adim_ans[2 ] = 2; sonuc_ans[2 ] = 20;
        sag_adim_ans[3 ] = 0; sol_adim_ans[3 ] = 3; sonuc_ans[3 ] = 10;
        sag_adim_ans[4 ] = 1; sol_adim_ans[4 ] = 0; sonuc_ans[4 ] = 5;
        sag_adim_ans[5 ] = 1; sol_adim_ans[5 ] = 1; sonuc_ans[5 ] = 35;
        sag_adim_ans[6 ] = 1; sol_adim_ans[6 ] = 2; sonuc_ans[6 ] = 25;
        sag_adim_ans[7 ] = 1; sol_adim_ans[7 ] = 3; sonuc_ans[7 ] = 15;
        sag_adim_ans[8 ] = 2; sol_adim_ans[8 ] = 0; sonuc_ans[8 ] = 10;
        sag_adim_ans[9 ] = 2; sol_adim_ans[9 ] = 1; sonuc_ans[9 ] = 0;
        sag_adim_ans[10] = 2; sol_adim_ans[10] = 2; sonuc_ans[10] = 30;
        sag_adim_ans[11] = 2; sol_adim_ans[11] = 3; sonuc_ans[11] = 20;
        sag_adim_ans[12] = 3; sol_adim_ans[12] = 0; sonuc_ans[12] = 15;
        sag_adim_ans[13] = 3; sol_adim_ans[13] = 1; sonuc_ans[13] = 5;
        sag_adim_ans[14] = 3; sol_adim_ans[14] = 2; sonuc_ans[14] = 35;
        sag_adim_ans[15] = 3; sol_adim_ans[15] = 3; sonuc_ans[15] = 25;
        sag_adim_ans[16] = 4; sol_adim_ans[16] = 0; sonuc_ans[16] = 20;
        sag_adim_ans[17] = 4; sol_adim_ans[17] = 1; sonuc_ans[17] = 10;
        sag_adim_ans[18] = 4; sol_adim_ans[18] = 2; sonuc_ans[18] = 0;
        sag_adim_ans[19] = 4; sol_adim_ans[19] = 3; sonuc_ans[19] = 30;
        sag_adim_ans[20] = 5; sol_adim_ans[20] = 0; sonuc_ans[20] = 25;
        sag_adim_ans[21] = 5; sol_adim_ans[21] = 1; sonuc_ans[21] = 15;
        sag_adim_ans[22] = 5; sol_adim_ans[22] = 2; sonuc_ans[22] = 5;
        sag_adim_ans[23] = 5; sol_adim_ans[23] = 3; sonuc_ans[23] = 35;
        sag_adim_ans[24] = 6; sol_adim_ans[24] = 0; sonuc_ans[24] = 30;
        sag_adim_ans[25] = 6; sol_adim_ans[25] = 1; sonuc_ans[25] = 20;
        sag_adim_ans[26] = 6; sol_adim_ans[26] = 2; sonuc_ans[26] = 10;
        sag_adim_ans[27] = 6; sol_adim_ans[27] = 3; sonuc_ans[27] = 0;
        sag_adim_ans[28] = 7; sol_adim_ans[28] = 0; sonuc_ans[28] = 35;
        sag_adim_ans[29] = 7; sol_adim_ans[29] = 1; sonuc_ans[29] = 25;
        sag_adim_ans[30] = 7; sol_adim_ans[30] = 2; sonuc_ans[30] = 15;
        sag_adim_ans[31] = 7; sol_adim_ans[31] = 3; sonuc_ans[31] = 5;
        
        for(i=0; i<32; i=i+1) begin
            for(j=0; j<40; j=j+1) begin
                sag_adim = sag_adim_ans[i]; sol_adim = sol_adim_ans[i]; kilit_sifre = j; #1;
                if(&(sonuc_ans[i] ~^ j) == kilit_acik) begin
                    passes = passes + 1;
                end
                else begin
                    fails = fails + 1;
                end
            end
        end
        
        $display("\n%d passes, %d fails\n", passes, fails);
        
        if(passes == 1280) $display("ALL PASSED!\n");
        if(fails  == 1280) $display("all failed!\n");
    end
    
endmodule
