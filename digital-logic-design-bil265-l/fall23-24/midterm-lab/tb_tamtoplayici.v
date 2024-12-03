`timescale 1ns / 1ps

module tb_tamtoplayici(

    );
    
    reg A;
    reg B;
    reg Cin;
    wire S;
    wire Cout;
    
    tamtoplayici tamtoplayici_dut(
        .A(A), 
        .B(B), 
        .Cin(Cin), 
        .S(S), 
        .Cout(Cout)
    );
    
    reg Aans    [7:0];
    reg Bans    [7:0];
    reg Cinans  [7:0];
    reg Sans    [7:0];
    reg Coutans [7:0];
    
    integer i;
    integer passes = 0;
    integer fails = 0;
    
    initial begin
        
        Aans[0] = 0; Bans[0] = 0; Cinans[0] = 0; Sans[0] = 0; Coutans[0] = 0;
        Aans[1] = 0; Bans[1] = 0; Cinans[1] = 1; Sans[1] = 1; Coutans[1] = 0;
        Aans[2] = 0; Bans[2] = 1; Cinans[2] = 0; Sans[2] = 1; Coutans[2] = 0;
        Aans[3] = 0; Bans[3] = 1; Cinans[3] = 1; Sans[3] = 0; Coutans[3] = 1;
        Aans[4] = 1; Bans[4] = 0; Cinans[4] = 0; Sans[4] = 1; Coutans[4] = 0;
        Aans[5] = 1; Bans[5] = 0; Cinans[5] = 1; Sans[5] = 0; Coutans[5] = 1;
        Aans[6] = 1; Bans[6] = 1; Cinans[6] = 0; Sans[6] = 0; Coutans[6] = 1;
        Aans[7] = 1; Bans[7] = 1; Cinans[7] = 1; Sans[7] = 1; Coutans[7] = 1;
        
        for(i=0; i<8; i=i+1) begin
            A = Aans[i]; B = Bans[i]; Cin = Cinans[i]; #1;
            if(S == Sans[i] && Cout == Coutans[i]) begin
                $display("passed! A: %d, B: %d, Cin: %d, S: %d, Cout: %d", A, B, Cin, S, Cout);
                passes = passes + 1;
            end
            else begin
                $display("FAILED! A: %d, B: %d, Cin: %d, S: %d, Cout: %d", A, B, Cin, S, Cout);
                fails = fails + 1;
            end
        end
        
        $display("\n%d passes, %d fails\n", passes, fails);
        
        if(passes == 8) $display("ALL PASSED!\n");
        if(fails  == 8) $display("all failed!\n");
        
        $finish;
    end
    
endmodule
