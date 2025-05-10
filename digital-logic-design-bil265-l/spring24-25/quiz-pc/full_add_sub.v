`timescale 1ns / 1ps

module full_add_sub(
    input a,
    input b,
    input carry_in,
    output result,
    output carry_out
);

    wire bxorcin;
    xor(bxorcin, b, carry_in);

    wire axorbxorcin;
    xor(axorbxorcin, a, bxorcin);

    xor(result, axorbxorcin, carry_in);

    wire axorbxorcinandcarry_in;
    and(axorbxorcinandcarry_in, axorbxorcin, carry_in);

    wire aandbxorcin;
    and(aandbxorcin, a, bxorcin);

    or(carry_out, axorbxorcinandcarry_in, aandbxorcin);

endmodule
