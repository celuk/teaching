`timescale 1ns / 1ps

module kayan_yazmac_boru #(parameter N=5) (
    input saat,
    input reset,
    input [N-1:0] sayi_giris,
    input [4:0] miktar,
    output [N-1:0] sayi_cikis,
    output bitti
);

    reg [N-1:0] sayi_girisler [0:N-1];
    reg [4:0] miktarlar [0:N-1];
    wire [N-1:0] sayi_cikislar [0:N-1];
    wire hazirlar [0:N-1];

    assign sayi_cikis = sayi_cikislar[N-1];
    assign bitti = hazirlar[N-1];

    genvar i;
    generate
        for (i=0; i<N; i=i+1) begin
            kayan_yazmac #(.N(N)) kayan_yazmac_inst (
                .saat(saat),
                .reset(reset),
                .basla((i==0) ? 1'b1 : hazirlar[i-1]),
                .sayi_giris((i==0) ? sayi_giris : sayi_girisler[i]),
                .miktar((i==0) ? miktar : miktarlar[i]),
                .sayi_cikis(sayi_cikislar[i]),
                .hazir(hazirlar[i])
            );
        end
    endgenerate

    integer j;
    always @* begin
        for (j=1; j<N; j=j+1) begin
            if(sayi_cikislar[j-1] > 0)
                sayi_girisler[j] = sayi_cikislar[j-1] - 1;
            else
                sayi_girisler[j] = 0;

            if(miktar > (N + j)) // (miktar-j) > N
                miktarlar[j] = miktar - j;
            else
                miktarlar[j] = N;
        end
    end
endmodule
