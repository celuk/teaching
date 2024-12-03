`timescale 1ns / 1ps

module tb_odev1_fonk(

    );
    
    reg A, B, C, D, E;
    wire F;
    
    odev1_fonk o1f(.A(A), .B(B), .C(C), .D(D), .E(E), .F(F));
    
    reg A_ans [31:0];
    reg B_ans [31:0];
    reg C_ans [31:0];
    reg D_ans [31:0];
    reg E_ans [31:0]; 
    reg F_ans [31:0];
    
    integer i;
    integer passes = 0;
    integer fails = 0;
    
    initial begin
        A_ans[0 ] = 0; B_ans[0 ] = 0; C_ans[0 ] = 0; D_ans[0 ] = 0; E_ans[0 ] = 0; F_ans[0 ] = 1;
        A_ans[1 ] = 0; B_ans[1 ] = 0; C_ans[1 ] = 0; D_ans[1 ] = 0; E_ans[1 ] = 1; F_ans[1 ] = 1;
        A_ans[2 ] = 0; B_ans[2 ] = 0; C_ans[2 ] = 0; D_ans[2 ] = 1; E_ans[2 ] = 0; F_ans[2 ] = 1;
        A_ans[3 ] = 0; B_ans[3 ] = 0; C_ans[3 ] = 0; D_ans[3 ] = 1; E_ans[3 ] = 1; F_ans[3 ] = 1;
        A_ans[4 ] = 0; B_ans[4 ] = 0; C_ans[4 ] = 1; D_ans[4 ] = 0; E_ans[4 ] = 0; F_ans[4 ] = 1;
        A_ans[5 ] = 0; B_ans[5 ] = 0; C_ans[5 ] = 1; D_ans[5 ] = 0; E_ans[5 ] = 1; F_ans[5 ] = 1;
        A_ans[6 ] = 0; B_ans[6 ] = 0; C_ans[6 ] = 1; D_ans[6 ] = 1; E_ans[6 ] = 0; F_ans[6 ] = 1;
        A_ans[7 ] = 0; B_ans[7 ] = 0; C_ans[7 ] = 1; D_ans[7 ] = 1; E_ans[7 ] = 1; F_ans[7 ] = 1;
        A_ans[8 ] = 0; B_ans[8 ] = 1; C_ans[8 ] = 0; D_ans[8 ] = 0; E_ans[8 ] = 0; F_ans[8 ] = 0;
        A_ans[9 ] = 0; B_ans[9 ] = 1; C_ans[9 ] = 0; D_ans[9 ] = 0; E_ans[9 ] = 1; F_ans[9 ] = 0;
        A_ans[10] = 0; B_ans[10] = 1; C_ans[10] = 0; D_ans[10] = 1; E_ans[10] = 0; F_ans[10] = 1;
        A_ans[11] = 0; B_ans[11] = 1; C_ans[11] = 0; D_ans[11] = 1; E_ans[11] = 1; F_ans[11] = 1;
        A_ans[12] = 0; B_ans[12] = 1; C_ans[12] = 1; D_ans[12] = 0; E_ans[12] = 0; F_ans[12] = 0;
        A_ans[13] = 0; B_ans[13] = 1; C_ans[13] = 1; D_ans[13] = 0; E_ans[13] = 1; F_ans[13] = 0;
        A_ans[14] = 0; B_ans[14] = 1; C_ans[14] = 1; D_ans[14] = 1; E_ans[14] = 0; F_ans[14] = 1;
        A_ans[15] = 0; B_ans[15] = 1; C_ans[15] = 1; D_ans[15] = 1; E_ans[15] = 1; F_ans[15] = 1;
        A_ans[16] = 1; B_ans[16] = 0; C_ans[16] = 0; D_ans[16] = 0; E_ans[16] = 0; F_ans[16] = 1;
        A_ans[17] = 1; B_ans[17] = 0; C_ans[17] = 0; D_ans[17] = 0; E_ans[17] = 1; F_ans[17] = 1;
        A_ans[18] = 1; B_ans[18] = 0; C_ans[18] = 0; D_ans[18] = 1; E_ans[18] = 0; F_ans[18] = 1;
        A_ans[19] = 1; B_ans[19] = 0; C_ans[19] = 0; D_ans[19] = 1; E_ans[19] = 1; F_ans[19] = 1;
        A_ans[20] = 1; B_ans[20] = 0; C_ans[20] = 1; D_ans[20] = 0; E_ans[20] = 0; F_ans[20] = 1;
        A_ans[21] = 1; B_ans[21] = 0; C_ans[21] = 1; D_ans[21] = 0; E_ans[21] = 1; F_ans[21] = 1;
        A_ans[22] = 1; B_ans[22] = 0; C_ans[22] = 1; D_ans[22] = 1; E_ans[22] = 0; F_ans[22] = 1;
        A_ans[23] = 1; B_ans[23] = 0; C_ans[23] = 1; D_ans[23] = 1; E_ans[23] = 1; F_ans[23] = 1;
        A_ans[24] = 1; B_ans[24] = 1; C_ans[24] = 0; D_ans[24] = 0; E_ans[24] = 0; F_ans[24] = 1;
        A_ans[25] = 1; B_ans[25] = 1; C_ans[25] = 0; D_ans[25] = 0; E_ans[25] = 1; F_ans[25] = 1;
        A_ans[26] = 1; B_ans[26] = 1; C_ans[26] = 0; D_ans[26] = 1; E_ans[26] = 0; F_ans[26] = 1;
        A_ans[27] = 1; B_ans[27] = 1; C_ans[27] = 0; D_ans[27] = 1; E_ans[27] = 1; F_ans[27] = 1;
        A_ans[28] = 1; B_ans[28] = 1; C_ans[28] = 1; D_ans[28] = 0; E_ans[28] = 0; F_ans[28] = 1;
        A_ans[29] = 1; B_ans[29] = 1; C_ans[29] = 1; D_ans[29] = 0; E_ans[29] = 1; F_ans[29] = 1;
        A_ans[30] = 1; B_ans[30] = 1; C_ans[30] = 1; D_ans[30] = 1; E_ans[30] = 0; F_ans[30] = 1;
        A_ans[31] = 1; B_ans[31] = 1; C_ans[31] = 1; D_ans[31] = 1; E_ans[31] = 1; F_ans[31] = 1;
        
        for(i=0; i<32; i=i+1) begin
            A = A_ans[i]; B = B_ans[i]; C = C_ans[i]; D = D_ans[i]; E = E_ans[i]; #1;
            
            if(F == F_ans[i]) begin
                passes = passes + 1;
            end
            else begin
                fails = fails + 1;
            end
        end
        
        $display("\n%d passes, %d fails\n", passes, fails);
        
        if(passes == 32) $display("ALL PASSED!\n");
        if(fails  == 32) $display("all failed!\n");
        
        $finish;
    end
    
endmodule
