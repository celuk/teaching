`timescale 1ns / 1ps

module tb_oyun(

    );
    
    reg [1:0] X11;
    reg [1:0] Y11;
    reg [1:0] X12;
    reg [1:0] Y12;
    reg [1:0] X13;
    reg [1:0] Y13;
    reg [1:0] X21;
    reg [1:0] Y21;
    reg [1:0] X22;
    reg [1:0] Y22;
    reg [1:0] X23;
    reg [1:0] Y23;
    wire O;
    
    oyun oyun_dut(.X11(X11), .Y11(Y11), .X12(X12), .Y12(Y12), .X13(X13), .Y13(Y13), 
                  .X21(X21), .Y21(Y21), .X22(X22), .Y22(Y22), .X23(X23), .Y23(Y23),
                  .O(O));
    
    reg [1:0] Xans [15:0];
    reg [1:0] Yans [15:0];
    reg [1:0] Pans [15:0];
    
    integer i;
    integer j;
    integer k;
    integer l;
    integer m;
    integer n;
    
    integer passes = 0;
    integer fails = 0;
    
    initial begin
        Xans[0 ] = 0; Yans[0 ] = 0; Pans[0 ] = 0;
        Xans[1 ] = 0; Yans[1 ] = 1; Pans[1 ] = 0;
        Xans[2 ] = 0; Yans[2 ] = 2; Pans[2 ] = 0;
        Xans[3 ] = 0; Yans[3 ] = 3; Pans[3 ] = 0;
        Xans[4 ] = 1; Yans[4 ] = 0; Pans[4 ] = 0;
        Xans[5 ] = 1; Yans[5 ] = 1; Pans[5 ] = 1;
        Xans[6 ] = 1; Yans[6 ] = 2; Pans[6 ] = 2;
        Xans[7 ] = 1; Yans[7 ] = 3; Pans[7 ] = 1;
        Xans[8 ] = 2; Yans[8 ] = 0; Pans[8 ] = 0;
        Xans[9 ] = 2; Yans[9 ] = 1; Pans[9 ] = 2;
        Xans[10] = 2; Yans[10] = 2; Pans[10] = 3;
        Xans[11] = 2; Yans[11] = 3; Pans[11] = 2;
        Xans[12] = 3; Yans[12] = 0; Pans[12] = 0;
        Xans[13] = 3; Yans[13] = 1; Pans[13] = 1;
        Xans[14] = 3; Yans[14] = 2; Pans[14] = 2;
        Xans[15] = 3; Yans[15] = 3; Pans[15] = 1;
        
        for(i=0; i<16; i=i+1) begin
            X11 = Xans[i]; Y11 = Yans[i];
            for(j=0; j<16; j=j+1) begin
                X21 = Xans[j]; Y21 = Yans[j];
                for(k=0; k<16; k=k+1) begin
                    X12 = Xans[k]; Y12 = Yans[k];
                    for(l=0; l<16; l=l+1) begin
                        X22 = Xans[l]; Y22 = Yans[l];
                        for(m=0; m<16; m=m+1) begin
                            X13 = Xans[m]; Y13 = Yans[m];
                            for(n=0; n<16; n=n+1) begin
                                X23 = Xans[n]; Y23 = Yans[n]; #1;
                                if(((Pans[i] + Pans[j] >= 5) + (Pans[k] + Pans[l] >= 5) + (Pans[m] + Pans[n] >= 5) >= 2) == O) begin
                                    passes = passes + 1;
                                end
                                else begin
                                    fails = fails + 1;
                                end
                            end
                        end
                    end
                end
                
            end
        end
        
        $display("%d passes, %d fails\n", passes, fails);
        
        if(passes == 16777216) $display("ALL PASSED!\n");
        if(fails  == 16777216) $display("all failed!\n");
        
        $finish;
    end
    
endmodule
