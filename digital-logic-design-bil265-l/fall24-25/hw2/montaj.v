`timescale 1ns / 1ps

module montaj(
    input saat,
    input reset,
    input basla,
    input [2:0] govde,
    input [2:0] ekran,
    input [2:0] batarya,
    output reg bitti,
    output reg montaja_uygun,
    output reg [1:0] uretim_tipi,
    output reg montaj_kalitesi
    );

    reg montaja_uygun_sonraki;
    reg [1:0] uretim_tipi_sonraki;
    reg montaj_kalitesi_sonraki;
    reg bitti_sonraki;

    wire [1:0] govde_tipi = govde[2] ? 2 : (govde[1] ? 1 : 0);
    wire [1:0] ekran_tipi = ekran[2] ? 2 : (ekran[1] ? 1 : 0);
    wire [1:0] batarya_tipi = batarya[2] ? 2 : (batarya[1] ? 1 : 0);

    wire montaj_uygunlugu = ((govde_tipi == ekran_tipi) ? 1 : 
                             (govde_tipi == batarya_tipi) ? 1 : 
                             (ekran_tipi == batarya_tipi) ? 1 :
                              0);
    wire kaliteli_montaj =  (govde_tipi == ekran_tipi)  &&
                            (govde_tipi == batarya_tipi) &&
                            (ekran_tipi == batarya_tipi);

    wire [1:0] uretim_tipi_w = (govde_tipi == ekran_tipi)    ? govde_tipi : 
                               ((govde_tipi == batarya_tipi) ? govde_tipi : ekran_tipi);

    always @* begin
        montaja_uygun_sonraki = 0;
        uretim_tipi_sonraki = 0;
        montaj_kalitesi_sonraki = 0;
        bitti_sonraki = 0;

        if(basla) begin
            montaja_uygun_sonraki = montaj_uygunlugu;
            uretim_tipi_sonraki = uretim_tipi_w;
            montaj_kalitesi_sonraki = kaliteli_montaj;
            bitti_sonraki = 1;
        end
    end

    always @(posedge saat) begin
        if(reset) begin
            bitti <= 0;
            montaja_uygun <= 0;
            uretim_tipi <= 0;
            montaj_kalitesi <= 0;
        end
        else begin
            bitti <= bitti_sonraki;
            montaja_uygun <= montaja_uygun_sonraki;
            uretim_tipi <= uretim_tipi_sonraki;
            montaj_kalitesi <= montaj_kalitesi_sonraki;
        end
    end
    
endmodule
