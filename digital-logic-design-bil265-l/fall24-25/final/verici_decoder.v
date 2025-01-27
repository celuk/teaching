`timescale 1ns / 1ps

module verici_decoder #(parameter N = 30)(
    input clk,
    input rst,
    input basla,
    input mod1,
    input mod2,
    input [N-1:0] gelen_veri,
    output [N-1:0] cikan_veri,
    output bitti
    );

    // buradaki tek sorun mod'larin basla gelen cevrim sonrasinda degismesi olabilir
    // fakat en azindan decoder modulu icin bu kontrol zaten burada yapilmamalidir 
    // zaten alt modullerde sadece basla geldigi cevrim moda bakilmaktadir
    // decoder ust modulde basla geldigi anda calistigi icin mod1'in direkt baglanmasi yeterlidir
    // fakat vericinin mod2'si ust modulde basla geldigi anda degil decoder bitince verilmeli
    // bu yuzden mod2 basla geldigi anda bufferlaniyor ve bufferlanmis deger vericiye veriliyor
    // bunu yapmasaniz da kabul, mod1 ve mod2'nin basla'dan sonra degismeyecegini varsayabilirdiniz

    wire decoder_bitti;
    wire [N-1:0] decoder_cikan_veri;
    decoder #(.N(N)) decoder_dut(
        .clk(clk),
        .rst(rst),
        .basla(basla),
        .mod(mod1),
        .gelen_veri(gelen_veri),
        .cikan_veri(decoder_cikan_veri),
        .bitti(decoder_bitti)
    );

    reg mod2_buffer;
    verici #(.N(N)) verici_dut(
        .clk(clk),
        .rst(rst),
        .basla(decoder_bitti),
        .mod(mod2_buffer),
        .gelen_veri(decoder_cikan_veri),
        .cikan_veri(cikan_veri),
        .bitti(bitti)
    );

    always @(posedge clk) begin
        if(rst) begin
            mod2_buffer <= 0;
        end
        else begin
            if(basla) begin
                mod2_buffer <= mod2;
            end
        end
    end

endmodule
