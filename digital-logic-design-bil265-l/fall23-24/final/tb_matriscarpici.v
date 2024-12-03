`timescale 1ns / 1ps

module tb_matriscarpici(

    );
    
    localparam M = 16;
    
    reg clk;
    reg rst;
    reg [M-1:0] matris_veri;
    reg matris_gecerli;
    wire [2*M+1:0] carpim_veri;
    wire carpim_gecerli;
    
    matriscarpici #(.M(M)) matriscarpici_dut(
        .clk(clk),
        .rst(rst),
        .matris_veri(matris_veri),
        .matris_gecerli(matris_gecerli),
        .carpim_veri(carpim_veri),
        .carpim_gecerli(carpim_gecerli)
    );
    
    always begin
        clk = ~clk; #0.5;
    end

    reg [M-1:0] A_matrisi [7:0];
    reg [M-1:0] B_matrisi [7:0];
    reg [2*M+1:0] C_matrisi [3:0];
    
    integer i = 0;
    integer j = 0;
    integer count = 0;

    integer passes = 0;
    integer fails = 0;

    initial begin
        clk = 0;
        rst = 1;
        #10;
        rst = 0;
        
        matris_gecerli = 0;
        
        A_matrisi[0] = 2; A_matrisi[1] = 3; A_matrisi[2] = 4; A_matrisi[3] = 0;
        A_matrisi[4] = 1; A_matrisi[5] = 1; A_matrisi[6] = 9; A_matrisi[7] = 8;
        
        B_matrisi[0] = 2; B_matrisi[1] = 0;
        B_matrisi[2] = 9; B_matrisi[3] = 3;
        B_matrisi[4] = 1; B_matrisi[5] = 4;
        B_matrisi[6] = 6; B_matrisi[7] = 1;
        
        C_matrisi[0] = A_matrisi[0]*B_matrisi[0] + A_matrisi[1]*B_matrisi[2] 
                     + A_matrisi[2]*B_matrisi[4] + A_matrisi[3]*B_matrisi[6];
        C_matrisi[1] = A_matrisi[0]*B_matrisi[1] + A_matrisi[1]*B_matrisi[3] 
                     + A_matrisi[2]*B_matrisi[5] + A_matrisi[3]*B_matrisi[7];
        C_matrisi[2] = A_matrisi[4]*B_matrisi[0] + A_matrisi[5]*B_matrisi[2] 
                     + A_matrisi[6]*B_matrisi[4] + A_matrisi[7]*B_matrisi[6];
        C_matrisi[3] = A_matrisi[4]*B_matrisi[1] + A_matrisi[5]*B_matrisi[3] 
                     + A_matrisi[6]*B_matrisi[5] + A_matrisi[7]*B_matrisi[7];
        
        for(i=0; i<8; i=i+1) begin
            matris_veri = A_matrisi[i]; matris_gecerli = 1; #1;
        end
        for(i=0; i<8; i=i+1) begin
            matris_veri = B_matrisi[i]; matris_gecerli = 1; #1;
        end
        
        matris_gecerli = 0;
        
        while(!carpim_gecerli) #1;
        
        for(i=0; i<4; i=i+1) begin
            if(carpim_gecerli && carpim_veri == C_matrisi[i]) begin
                count = count + 1;
            end
            #1;
        end
        
        if(count == 4 && carpim_gecerli == 0) begin
            $display("TEST1 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test1 failed, kac_carpim_dogru: %d, carpim_gecerli: %d", count, carpim_gecerli);
            fails = fails + 1;
        end
        
        count = 0;
        
        rst = 1;
        #55;
        rst = 0;
        
        A_matrisi[0] = 'hffff; A_matrisi[1] = 'hffff; A_matrisi[2] = 'hffff; A_matrisi[3] = 'hffff;
        A_matrisi[4] = 'hffff; A_matrisi[5] = 'hffff; A_matrisi[6] = 'hffff; A_matrisi[7] = 'hffff;
        
        B_matrisi[0] = 'hffff; B_matrisi[1] = 'hffff;
        B_matrisi[2] = 'hffff; B_matrisi[3] = 'hffff;
        B_matrisi[4] = 'hffff; B_matrisi[5] = 'hffff;
        B_matrisi[6] = 'hffff; B_matrisi[7] = 'hffff;
        
        C_matrisi[0] = A_matrisi[0]*B_matrisi[0] + A_matrisi[1]*B_matrisi[2] 
                     + A_matrisi[2]*B_matrisi[4] + A_matrisi[3]*B_matrisi[6];
        C_matrisi[1] = A_matrisi[0]*B_matrisi[1] + A_matrisi[1]*B_matrisi[3] 
                     + A_matrisi[2]*B_matrisi[5] + A_matrisi[3]*B_matrisi[7];
        C_matrisi[2] = A_matrisi[4]*B_matrisi[0] + A_matrisi[5]*B_matrisi[2] 
                     + A_matrisi[6]*B_matrisi[4] + A_matrisi[7]*B_matrisi[6];
        C_matrisi[3] = A_matrisi[4]*B_matrisi[1] + A_matrisi[5]*B_matrisi[3] 
                     + A_matrisi[6]*B_matrisi[5] + A_matrisi[7]*B_matrisi[7];
        
        for(i=0; i<8; i=i+1) begin
            matris_veri = A_matrisi[i]; matris_gecerli = 1; #1;
        end
        for(i=0; i<8; i=i+1) begin
            matris_veri = B_matrisi[i]; matris_gecerli = 1; #1;
        end
        
        matris_gecerli = 0;
        
        while(!carpim_gecerli) #1;
        
        for(i=0; i<4; i=i+1) begin
            while(!carpim_gecerli) #1; // ardisik verilmiyorsa
            if(carpim_gecerli && carpim_veri == C_matrisi[i]) begin
                count = count + 1;
            end
            #1;
        end
        
        if(count == 4 && carpim_gecerli == 0) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test2 failed, kac_carpim_dogru: %d, carpim_gecerli: %d", count, carpim_gecerli);
            fails = fails + 1;
        end
        
        count = 0;
        
        for(j=0; j<8; j=j+1) begin
            rst = 1;
            #1;
            rst = 0;
            
            for (i=0; i<8; i=i+1) begin
                A_matrisi[i] = $random % 65536;
            end
            for (i=0; i<8; i=i+1) begin
                B_matrisi[i] = $random % 65536;
            end
            
            C_matrisi[0] = A_matrisi[0]*B_matrisi[0] + A_matrisi[1]*B_matrisi[2] 
                         + A_matrisi[2]*B_matrisi[4] + A_matrisi[3]*B_matrisi[6];
            C_matrisi[1] = A_matrisi[0]*B_matrisi[1] + A_matrisi[1]*B_matrisi[3] 
                         + A_matrisi[2]*B_matrisi[5] + A_matrisi[3]*B_matrisi[7];
            C_matrisi[2] = A_matrisi[4]*B_matrisi[0] + A_matrisi[5]*B_matrisi[2] 
                         + A_matrisi[6]*B_matrisi[4] + A_matrisi[7]*B_matrisi[6];
            C_matrisi[3] = A_matrisi[4]*B_matrisi[1] + A_matrisi[5]*B_matrisi[3] 
                         + A_matrisi[6]*B_matrisi[5] + A_matrisi[7]*B_matrisi[7];
            
            for(i=0; i<8; i=i+1) begin
                matris_veri = A_matrisi[i]; matris_gecerli = 1; #1;
            end
            for(i=0; i<8; i=i+1) begin
                matris_veri = B_matrisi[i]; matris_gecerli = 1; #1;
            end
            
            matris_gecerli = 0;
            
            while(!carpim_gecerli) #1;
            
            for(i=0; i<4; i=i+1) begin
                while(!carpim_gecerli) #1; // ardisik verilmiyorsa
                if(carpim_gecerli && carpim_veri == C_matrisi[i]) begin
                    count = count + 1;
                end
                #1;
            end
            
            if(count == 4 && carpim_gecerli == 0) begin
                $display("TEST%0d PASSED", j+3);
                passes = passes + 1;
            end
            else begin
                $display("test%0d failed, kac_carpim_dogru: %d, carpim_gecerli: %d", j+3, count, carpim_gecerli);
                fails = fails + 1;
            end
            
            count = 0;
        end
        
        $display("%d passes, %d fails\n", passes, fails);
        
        if(passes == 10) $display("ALL PASSED!\n");
        if(fails  == 10) $display("all failed!\n");
        
        $finish;
    end
    
endmodule
