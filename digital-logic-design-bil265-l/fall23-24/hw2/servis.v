`timescale 1ns / 1ps

module servis(
    input saat,
    input reset,
    input basla,
    input demlendi,
    input filtrele,
    input filtre_tipi,
    output reg bitti = 0,
    output reg bosalt = 0,
    output reg [4:0] kahve_sayisi = 0
    );
    
    reg [4:0] kahve_sayisi_sonraki = 0;
    reg bosalt_sonraki = 0;
    reg bitti_sonraki = 0;
    
    always @* begin
        kahve_sayisi_sonraki = kahve_sayisi;
        bosalt_sonraki = 0;
        bitti_sonraki = 0;
        
        if(basla) begin
            if(demlendi) begin
                if(filtrele) begin
                    case(filtre_tipi)
                        1'b0: kahve_sayisi_sonraki = kahve_sayisi + 2;
                        1'b1: kahve_sayisi_sonraki = kahve_sayisi + 3;
                        default: kahve_sayisi_sonraki = kahve_sayisi;
                    endcase
                end
                else begin
                    kahve_sayisi_sonraki = kahve_sayisi + 1;
                end
            end
            
            if(kahve_sayisi_sonraki >= 25) begin
                kahve_sayisi_sonraki = 0;
                bosalt_sonraki = 1;
            end
            
            bitti_sonraki = 1;
        end
    end
    
    always @(posedge saat) begin
        if(reset) begin
            kahve_sayisi <= 0;
            bosalt <= 0;
            bitti <= 0;
        end
        else begin
            kahve_sayisi <= kahve_sayisi_sonraki;
            bosalt <= bosalt_sonraki;
            bitti <= bitti_sonraki;
        end
    end
    
endmodule
