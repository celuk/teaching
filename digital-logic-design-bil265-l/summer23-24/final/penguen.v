`timescale 1ns / 1ps

module penguen(
    input saat,
    input reset,
    input [2:0]avlanan_balik,
    output reg bitti,
    output [6:0]bitme_sure
    );
    reg [4:0]mide, mide_;
    reg [6:0]sayac,sayac_;
    reg bitti_;
    
    initial begin
        mide = 4'd0;
        sayac = 6'd0;
        bitti = 1'b0;
    end
    always @* begin
        sayac_ = sayac;
        bitti_ = bitti;
        mide_ = mide;

        if(!bitti)begin
            sayac_ = sayac + 1;
            if((mide + avlanan_balik) >= 25)begin
                bitti_ = 1;
                sayac_ = sayac;
            end
            else begin
                if(sayac%3 == 2)begin
                    mide_ = mide + avlanan_balik - 3;
                end
                else begin
                    mide_ = mide + avlanan_balik;
                end
            end             
        end
    end
    
    always @(posedge saat)begin
        if(reset)begin
            sayac <= 0;
            bitti <= 0;
            mide  <= 0;
        end
        else begin
            sayac <= sayac_;
            bitti <= bitti_;
            mide  <= mide_;
        end
    end
    
    assign bitme_sure = sayac + 1;
    
endmodule
