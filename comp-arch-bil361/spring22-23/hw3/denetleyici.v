`timescale 1ns / 1ps

module denetleyici(
    input saat,
    input reset,
    
    // islemci <-> onbellek
    input [31:0] veri_adres,
    input yaz,
    input [31:0] yaz_veri,
    input oku,
    output [31:0] oku_veri,
    
    // onbellek <-> anabellek
    output [31:0] anabellek_adres,
    output [31:0] anabellek_yaz_veri,
    input  [31:0] anabellek_oku_veri, // anabellekten surekli okunuyor
    output anabellek_yaz
);

reg [31:0] veri_onbellegi [255:0]; // 1KB
// burada onbellek etiket ve gecerli bitleri icin de yazmac dizileri (register array) tutabilirsiniz.

always @(posedge saat) begin

end

endmodule

