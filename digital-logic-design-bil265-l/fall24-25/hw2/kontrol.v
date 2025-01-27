`timescale 1ns / 1ps

module kontrol(
    input saat,
    input reset,
    input basla,
    input montaja_uygun,
    input [1:0] uretim_tipi,
    input montaj_kalitesi,
    input isletim_sistemi,
    output reg bitti,
    output reg kalite,
    output reg kontrol_sonucu
    );

    reg bitti_sonraki;
    reg kalite_sonraki;
    reg kontrol_sonucu_sonraki;

    wire kontrol_sonucu_w = (montaja_uygun && !(uretim_tipi == 0 && isletim_sistemi == 0 && montaj_kalitesi == 0));
    wire kalite_w = (kontrol_sonucu_w && uretim_tipi == 2 && montaj_kalitesi);

    always @* begin
        bitti_sonraki = 0;
        kalite_sonraki = 0;
        kontrol_sonucu_sonraki = 0;
        
        if(basla) begin
            kalite_sonraki = kalite_w;
            kontrol_sonucu_sonraki = kontrol_sonucu_w;
            bitti_sonraki = 1;
        end
    end

    always @(posedge saat) begin
        if(reset) begin
            bitti <= 0;
            kalite <= 0;
            kontrol_sonucu <= 0;
        end
        else begin
            bitti <= bitti_sonraki;
            kalite <= kalite_sonraki;
            kontrol_sonucu <= kontrol_sonucu_sonraki;
        end
    end
    
endmodule
