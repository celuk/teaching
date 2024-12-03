`timescale 1ns / 1ps

module ons(
    input [5:0] X,
    output [10:0] Y
    );
    
    assign Y = X*28 + ((X % 2 == 1) ? (X+1)/2 : X/2);
    
    // Farkli sekillerde yapilabilir
    
    /*
    reg [10:0] carp28 = 0;
    reg [4:0] carpyarim = 0;
    
    assign Y = carp28 + carpyarim;
    
    always @* begin
        carp28 = X *28;
        
        if(X % 2 == 1)
            carpyarim = (X+1)/2;
        else
            carpyarim = X/2;
    end
    */
    
endmodule
