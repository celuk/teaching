`timescale 1ns / 1ps

module tb_denetleyici(
);

reg[31:0] anabellek [299:0];


reg saat;
reg reset;
reg[31:0] veri_adres;
reg yaz;
reg[31:0] yaz_veri;
reg oku;
wire[31:0] oku_veri;
wire[31:0] anabellek_adres;
wire[31:0] anabellek_yaz_veri;
reg[31:0] anabellek_oku_veri;
wire anabellek_yaz;

reg[2:0] say = 0;

denetleyici tuu(
    .saat(saat),
    .reset(reset),
    .veri_adres(veri_adres),
    .yaz(yaz),
    .yaz_veri(yaz_veri),
    .oku(oku),
    .oku_veri(oku_veri),
    .anabellek_adres(anabellek_adres),
    .anabellek_yaz_veri(anabellek_yaz_veri),
    .anabellek_oku_veri(anabellek_oku_veri),
    .anabellek_yaz(anabellek_yaz)
);

always@* begin
    anabellek_oku_veri = anabellek[anabellek_adres];
    if(anabellek_yaz) begin
        anabellek[anabellek_adres] = anabellek_yaz_veri;
    end
end

always begin
    saat = 0;
    #5;
    saat = 1;
    #5;
end

integer i;

initial begin
    for(i=0;i<300;i=i+1) begin
        anabellek[i]=0;
    end
    reset = 1;
    #10;
    reset = 0;
    for(i=0;i<300;i=i+1) begin
       veri_adres = i;
       yaz = 1;
       yaz_veri = i;
       oku = 0;
       #10;
    end
    for(i=0;i<300;i=i+1) begin
       veri_adres = i;
       yaz = 0;
       yaz_veri = i;
       oku = 1;
       #10;
    end

end

endmodule