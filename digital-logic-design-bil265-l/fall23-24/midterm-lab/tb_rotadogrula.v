`timescale 1ns / 1ps

module tb_rotadogrula(

    );
    
    reg [5:0] rota;
    wire rota_dogru;
    rotadogrula rotadogrula_dut(.rota(rota), .rota_dogru(rota_dogru));
    
    wire rota_dogru_test;
    rotadogrula_test rotadogrula_test_dut(.rota(rota), .rota_dogru(rota_dogru_test));

    integer i;
    integer passes = 0;
    integer fails = 0;
    
    initial begin
        for(i=0; i<64; i=i+1) begin
            rota = i; #1;
            if(rota_dogru == rota_dogru_test) begin
                $display("passed! rota: %b, rota_dogru: %d", rota, rota_dogru);
                passes = passes + 1;
            end
            else begin
                $display("FAILED! rota: %b, rota_dogru: %d", rota, rota_dogru);
                fails = fails + 1;
            end
        end
        
        $display("\n%d passes, %d fails\n", passes, fails);
        
        if(passes == 64) $display("ALL PASSED!\n");
        if(fails  == 64) $display("all failed!\n");
        
        $finish;
    end
    
endmodule

module rotadogrula_test(
    input [5:0] rota,
    output rota_dogru
    );
    
    wire [5:0] nrota;
    not(nrota[5], rota[5]);
    not(nrota[4], rota[4]);
    not(nrota[3], rota[3]);
    not(nrota[2], rota[2]);
    not(nrota[1], rota[1]);
    not(nrota[0], rota[0]);
    
    wire w1, w2, w3, w4;
    and(w1, rota[5], rota[4], rota[3], nrota[2], nrota[1], nrota[0]);
    and(w2, rota[5], nrota[4], nrota[3], nrota[2], rota[1], rota[0]);
    and(w3, rota[5], nrota[4], nrota[3], rota[2], nrota[1], rota[0]);
    and(w4, rota[5], nrota[4], nrota[3], rota[2], rota[1], nrota[0]);
    
    or(rota_dogru, w1, w2, w3, w4);
    
endmodule
