`timescale 1ns / 1ps

module verici #(parameter N = 30)(
    input clk,
    input rst,
    input basla,
    input mod,
    input [N-1:0] gelen_veri,
    output reg [N-1:0] cikan_veri,
    output reg bitti
    );

    reg [N-1:0] cikan_veri_sonraki;
    reg bitti_sonraki;

    reg verial_bitti;
    reg verial_bitti_sonraki;

    reg [N-1:0] veri_buffer;
    reg [N-1:0] veri_buffer_sonraki;

    reg verial_devam;
    reg verial_devam_sonraki;

    reg [4:0] eleman_sayaci = N/3 - 1; // max 20 --> 5 bit, N=60
    reg [4:0] eleman_sayaci_sonraki;

    always @* begin
        cikan_veri_sonraki = cikan_veri;
        bitti_sonraki = 0;
        verial_bitti_sonraki = 0;
        veri_buffer_sonraki = veri_buffer;
        verial_devam_sonraki = verial_devam;
        eleman_sayaci_sonraki = eleman_sayaci;

        if(~verial_devam) begin
            if(basla) begin
                veri_buffer_sonraki = gelen_veri;
                if(mod) begin
                    // ilk cevrimde sadece en anlamli karakteri al, kalanini verial_devam kisminda al
                    cikan_veri_sonraki[2:0] = gelen_veri[(eleman_sayaci*3)+:3];
                    eleman_sayaci_sonraki = eleman_sayaci - 1; // ilk eleman alindi
                    verial_devam_sonraki = 1;
                end
                else begin // mod == 0
                    // tek cevrimde hepsini ata
                    cikan_veri_sonraki = gelen_veri;
                    bitti_sonraki = 1;
                end
            end
        end
        else begin // verial_devam
            eleman_sayaci_sonraki = eleman_sayaci - 1;

            // burada bufferlanmis veriyi kullan, sonraki girisler ornekteki gibi farkli x bir değer gelebilir
            cikan_veri_sonraki[2:0] = veri_buffer[(eleman_sayaci*3)+:3];
            
            if(eleman_sayaci == 0) begin
                verial_devam_sonraki = 0;
                bitti_sonraki = 1;
                eleman_sayaci_sonraki = N/3 - 1;
            end
        end
    end

    always @(posedge clk) begin
        if(rst) begin
            cikan_veri <= 0;
            bitti <= 0;

            verial_bitti <= 0;
            veri_buffer <= 0;
            verial_devam <= 0;

            eleman_sayaci <= N/3 - 1;
        end
        else begin
            cikan_veri <= cikan_veri_sonraki;
            bitti <= bitti_sonraki;

            verial_bitti <= verial_bitti_sonraki;
            veri_buffer <= veri_buffer_sonraki;
            verial_devam <= verial_devam_sonraki;

            eleman_sayaci <= eleman_sayaci_sonraki;
        end
    end

endmodule
