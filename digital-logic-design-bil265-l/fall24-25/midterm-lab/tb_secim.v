`timescale 1ns / 1ps

module tb_secim(

    );
    
    reg [7:0] T;
    reg [7:0] H;
    wire S;
    wire S_test;
    
    secim secim_dut(
        .T(T),
        .H(H),
        .S(S)
    );
    
    secim secim_test_dut(
        .T(T),
        .H(H),
        .S(S_test)
    );
    
    integer i;
    integer j;
    integer passes = 0;
    integer fails = 0;
    
    initial begin
        for(i=0; i<256; i=i+1) begin
            T = i;
            for(j=0; j<256; j=j+1) begin
                H = j; #1;
                
                if(S == S_test) begin
                    passes = passes + 1;
                end
                else begin
                    fails = fails + 1;
                end
            end
        end
    
        $display("\n%d passes, %d fails\n", passes, fails);
        
        if(passes == 65536) $display("ALL PASSED!\n");
        if(fails  == 65536) $display("all failed!\n");
    end
    
endmodule

module secim_test(
    input [7:0] T,
    input [7:0] H,
    output S
);

wire BS1;
sandik beyazsandik1(
    .T(T[7:6]),
    .H(H[7:6]),
    .S(BS1)
);

wire BS2;
sandik beyazsandik2(
    .T(T[5:4]),
    .H(H[5:4]),
    .S(BS2)
);

wire MS;
sandik mavisandik(
    .T(T[3:2]),
    .H(H[3:2]),
    .S(MS)
);

wire KS;
sandik kirmizisandik(
    .T(T[1:0]),
    .H(H[1:0]),
    .S(KS)
);

wire MSKS;
and(MSKS, MS, KS);

wire BS2KS;
and(BS2KS, BS2, KS);

wire BS1KS;
and(BS1KS, BS1, KS);

wire BS1BS2MS;
and(BS1BS2MS, BS1, BS2, MS);

or(S, MSKS, BS2KS, BS1KS, BS1BS2MS);

endmodule
