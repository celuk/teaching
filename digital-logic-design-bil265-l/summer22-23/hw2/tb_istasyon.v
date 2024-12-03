`timescale 1ns / 1ps

module tb_istasyon(

    );
    
    reg saat;
    reg reset;
    reg [1:0] islem;
    wire amorti;
    wire [4:0] amorti_gunu;
    
    istasyon #(.ARAC_SAYISI(300)) istasyon_dut(
        .saat(saat),
        .reset(reset),
        .islem(islem),
        .amorti(amorti),
        .amorti_gunu(amorti_gunu)
    );
    
    always begin
        saat = ~saat; #0.5;
    end
    
    integer passes = 0;
    integer fails = 0;
    
    initial begin
        saat = 0;
        reset = 0;
/////////////////////////////TEST-1///////////////////////////////////////// 
       islem = 1;
       #27;
       
       islem = 0;
       
       #4;
       
       if(amorti == 1 && amorti_gunu == 30) begin
           $display("TEST1 PASSED");
           passes = passes + 1;
       end
       else begin
           $display("test1 failed, amorti: %d, amorti_gunu: %d", amorti, amorti_gunu);
           fails = fails + 1;
       end
/////////////////////////////TEST-2/////////////////////////////////////////        
       reset = 1;
       #100;
       reset = 0;
       
       islem = 2;
       #31;
       
       if(amorti == 1 && (amorti_gunu == 6 || amorti_gunu == 4)) begin
           $display("TEST2 PASSED");
           passes = passes + 1;
       end
       else begin
           $display("test2 failed, amorti: %d, amorti_gunu: %d", amorti, amorti_gunu);
           fails = fails + 1;
       end
/////////////////////////////TEST-3/////////////////////////////////////////         
       reset = 1;
       #12;
       reset = 0;
       
       islem = 0; #1;
       islem = 1; #1;
       islem = 2; #1;
       islem = 3; #1;
       islem = 3; #1;
       islem = 2; #1;
       islem = 1; #1;
       islem = 0; #1;
       islem = 0; #1;
       islem = 0; #1;
       islem = 1; #1;
       islem = 2; #1;
       islem = 2; #1;
       islem = 3; #1;
       islem = 3; #1;
       islem = 1; #1;
       islem = 1; #1;
       islem = 1; #1;
       islem = 2; #1;
       islem = 2; #1;
       islem = 2; #1;
       islem = 2; #1;
       islem = 2; #1;
       islem = 2; #1;
       islem = 0; #1;
       islem = 0; #1;
       islem = 1; #1;
       islem = 1; #1;
       //islem = 2; #1;
       //islem = 1; #1;
       
       if(amorti == 1 && amorti_gunu == 7) begin
           $display("TEST3 PASSED");
           passes = passes + 1;
       end
       else begin
           $display("test3 failed, amorti: %d, amorti_gunu: %d", amorti, amorti_gunu);
           fails = fails + 1;
       end
       
/////////////////////////////TEST-4/////////////////////////////////////////        
       reset = 1;
       #125;
       reset = 0;
       
       islem = 1;
       #31;
       if(amorti == 0 && amorti_gunu == 0) begin
           $display("TEST4 PASSED");
           passes = passes + 1;
       end
       else begin
           $display("test4 failed, amorti: %d, amorti_gunu: %d", amorti, amorti_gunu);
           fails = fails + 1;
       end
/////////////////////////////TEST-5/////////////////////////////////////////        
       reset = 1;
       #1;
       reset = 0;
       
       islem = 2; #1;
       islem = 2; #1;
       islem = 2; #1;
       islem = 2; #1;
       islem = 2; #1;
       islem = 2; #1;
       islem = 2; #1;
       islem = 2; #1;
       islem = 2; #1;
       islem = 2; #1;
       islem = 2; #1;
       islem = 2; #1;
       islem = 2; #1;
       islem = 2; #1;
       islem = 2; #1;
       islem = 2; #1;
       islem = 2; #1;
       islem = 2; #1;
       islem = 2; #1;
       islem = 2; #1;
       islem = 2; #1;
       islem = 2; #1;
       islem = 2; #1;
       islem = 2; #1;
       islem = 2; #1;
       islem = 2; #1;
       islem = 2; #1;
       islem = 2; #1;
       
       if(amorti == 1 && (amorti_gunu == 6 || amorti_gunu == 4)) begin
           $display("TEST5 PASSED");
           passes = passes + 1;
       end
       else begin
           $display("test5 failed, amorti: %d, amorti_gunu: %d", amorti, amorti_gunu);
           fails = fails + 1;
       end
/////////////////////////////TEST-6/////////////////////////////////////////        
       reset = 1;
       #2;
       reset = 0;
       
       islem = 2; #1;
       islem = 1; #1;
       islem = 2; #1;
       islem = 1; #1;
       islem = 2; #1;
       islem = 1; #1;
       islem = 2; #1;
       islem = 1; #1;
       islem = 2; #1;
       islem = 1; #1;
       islem = 2; #1;
       islem = 1; #1;
       islem = 2; #1;
       islem = 1; #1;
       islem = 2; #1;
       islem = 1; #1;
       islem = 2; #1;
       islem = 1; #1;
       islem = 2; #1;
       islem = 1; #1;
       islem = 2; #1;
       islem = 1; #1;
       islem = 2; #1;
       islem = 1; #1;
       islem = 2; #1;
       islem = 1; #1;
       islem = 2; #1;
       islem = 1; #1;
       
       if(amorti == 1 && amorti_gunu == 6) begin
           $display("TEST6 PASSED");
           passes = passes + 1;
       end
       else begin
           $display("test6 failed, amorti: %d, amorti_gunu: %d", amorti, amorti_gunu);
           fails = fails + 1;
       end
/////////////////////////////TEST-7/////////////////////////////////////////       
       reset = 1;
       #2;
       reset = 0;
       
       islem = 1; #1;
       islem = 1; #1;
       islem = 1; #1;
       islem = 1; #1;
       islem = 1; #1;
       islem = 1; #1;
       islem = 1; #1;
       islem = 1; #1;
       islem = 1; #1;
       islem = 1; #1;
       islem = 1; #1;
       islem = 1; #1;
       islem = 1; #1;
       islem = 1; #1;
       islem = 1; #1;
       islem = 1; #1;
       islem = 1; #1;
       islem = 1; #1;
       islem = 1; #1;
       islem = 1; #1;
       islem = 1; #1;
       islem = 1; #1;
       islem = 1; #1;
       islem = 1; #1;
       islem = 1; #1;
       islem = 1; #1;
       islem = 1; #1;
       islem = 1; #1;
       
       if(amorti == 0 && amorti_gunu == 0) begin
           $display("TEST7 PASSED");
           passes = passes + 1;
       end
       else begin
           $display("test7 failed, amorti: %d, amorti_gunu: %d", amorti, amorti_gunu);
           fails = fails + 1;
       end       
/////////////////////////////TEST-8/////////////////////////////////////////  
       reset = 1;
       #2;
       reset = 0;
       
       islem = 0; #1;
       islem = 0; #1;
       islem = 0; #1;
       islem = 0; #1;
       islem = 0; #1;
       
       reset = 1;
       #2;
       reset = 0; 
       
       islem = 3; #1;
       islem = 3; #1;
       islem = 3; #1;
       islem = 3; #1;
       islem = 3; #1;
       islem = 3; #1;
       islem = 3; #1;
       islem = 3; #1;
       islem = 3; #1;
       islem = 3; #1;
       islem = 3; #1;
       islem = 3; #1;
       islem = 3; #1;
       islem = 3; #1;
       islem = 3; #1;
       islem = 3; #1;
       islem = 3; #1;
       islem = 3; #1;
       islem = 3; #1;
       islem = 3; #1;
       islem = 0; #1;
       
       islem = 0; #1;
       islem = 0; #1;        
       islem = 0; #1;        
             
       if(amorti == 1 && amorti_gunu == 21) begin
           $display("TEST8 PASSED");
           passes = passes + 1;
       end
       else begin
           $display("test8 failed, amorti: %d, amorti_gunu: %d", amorti, amorti_gunu);
           fails = fails + 1;
       end          
//////////////////////////////TEST-9/////////////////////////////////////////       
        reset = 1;
        #2;
        reset = 0;
        
        islem = 1; #1;
        islem = 1; #1;
        islem = 1; #1;
        islem = 1; #1;
        islem = 1; #1;
        islem = 1; #1;
        islem = 1; #1;
        islem = 1; #1;
        islem = 1; #1;
        islem = 1; #1;
        islem = 1; #1;
        islem = 1; #1;
        islem = 1; #1;
        islem = 1; #1;
        islem = 1; #1;
        islem = 1; #1;
        islem = 1; #1;
        islem = 1; #1;
        islem = 1; #1;
        islem = 1; #1;
        islem = 1; #1;
        islem = 1; #1;
        islem = 1; #1;
        islem = 1; #1;
        islem = 1; #1;
        islem = 1; #1;
        islem = 1; #1;
        islem = 1; #1;//28 gun
        
        islem = 0; #1;
        islem = 0; #1;   
        if(amorti == 0 && amorti_gunu == 0) begin
            $display("TEST9 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test9 failed, amorti: %d, amorti_gunu: %d", amorti, amorti_gunu);
            fails = fails + 1;
        end                        
//////////////////////////////TEST-10/////////////////////////////////////////       
        reset = 1;
        #2;
        reset = 0;
       
        islem = 3; #1;
        islem = 3; #1;
        islem = 3; #1;  
        islem = 2; #1;
        islem = 2; #1;
        islem = 0; #1;
        islem = 0; #1;
        islem = 3; #1;
        islem = 3; #1;
        islem = 3; #1;
        islem = 3; #1;
        islem = 3; #1;
        islem = 3; #1;
        islem = 0; #1;
        islem = 0; #1;
        islem = 1; #1;
        islem = 3; #1;
        islem = 3; #1;
        islem = 3; #1;
        islem = 1; #1;
        islem = 2; #1;
        islem = 1; #1;
        islem = 1; #1;
        islem = 2; #1;        
        islem = 2; #1;        
        islem = 2; #1;        
        if(amorti == 1 && amorti_gunu == 7) begin
            $display("TEST10 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test10 failed, amorti: %d, amorti_gunu: %d", amorti, amorti_gunu);
            fails = fails + 1;
        end            
        
        $display("%d passes, %d fails\n", passes, fails);
        
        if(passes == 10) $display("ALL PASSED!\n");
        if(fails  == 10) $display("all failed!\n");
        
        $finish;
    end
    
endmodule

