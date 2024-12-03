`timescale 1ns / 1ps

module odeme(
    input  saat,
    input  reset,
    input  basla,
    input  [7:0] ucret,
    input  [8:0] bakiye,
    output reg onay = 0,
    output reg [8:0] k_bakiye = 0,
    output reg bitti = 0
    );
    
    reg onay_sonraki = 0;
    reg [8:0] k_bakiye_sonraki = 0;
    reg bitti_sonraki = 0;
    
    always @* begin
        onay_sonraki = 0;
        k_bakiye_sonraki = bakiye;
        bitti_sonraki = 0;
        
        if(basla) begin
            if(bakiye >= ucret) begin
                onay_sonraki = 1;
                k_bakiye_sonraki = bakiye - ucret;
            end
            
            bitti_sonraki = 1;
        end
    end
    
    always @(posedge saat) begin
        if(reset) begin
            onay <= 0;
            k_bakiye <= 0;
            bitti <= 0;
        end
        else begin
            onay <= onay_sonraki;
            k_bakiye <= k_bakiye_sonraki;
            bitti <= bitti_sonraki;
        end
    end
    
endmodule
