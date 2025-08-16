`timescale 1ns / 1ps

module kayan_yazmac #(parameter N=5) (
    input saat,
    input reset,
    input basla,
    input [N-1:0] sayi_giris,
    input [4:0] miktar,
    output [N-1:0] sayi_cikis,
    output reg hazir
);

    reg [N-1:0] yazmaclar [0:N-1];

    reg [5:0] cevrim;

    localparam BOSTA = 0;
    localparam KAYDIR = 1;

    reg [0:0] durum;

    integer i;

    always @(posedge saat) begin
        if (reset) begin
            hazir      <= 0;
            durum      <= BOSTA;
            cevrim     <= 1;
            for (i=0; i<N; i=i+1)
                yazmaclar[i] <= 0;
        end
        else begin
            case (durum)
                BOSTA: begin
                    hazir <= 0;
                    cevrim <= 1;
                    if (basla) begin
                        yazmaclar[0] <= sayi_giris;
                        durum <= KAYDIR;
                        cevrim <= 2; //cevrim + 1
                    end
                end

                KAYDIR: begin
                    for (i=N-1; i>0; i=i-1)
                        yazmaclar[i] <= yazmaclar[i-1];
                    yazmaclar[0] <= sayi_giris;

                    if (cevrim == miktar-1) begin
                        durum  <= BOSTA;
                        hazir <= 1;
                    end
                    else begin
                        cevrim <= cevrim + 1;
                        hazir <= 0;
                    end
                end
            endcase
        end
    end

    assign sayi_cikis = yazmaclar[N-1];
endmodule
