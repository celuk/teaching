`timescale 1ns / 1ps

module secim(
    input [7:0] T,
    input [7:0] H,
    output S
);

wire BS1;
sandik beyazsandik1(
    .T(T[7:6]),
    .H(H[7:6]),
    .S(BS1)
);

wire BS2;
sandik beyazsandik2(
    .T(T[5:4]),
    .H(H[5:4]),
    .S(BS2)
);

wire MS;
sandik mavisandik(
    .T(T[3:2]),
    .H(H[3:2]),
    .S(MS)
);

wire KS;
sandik kirmizisandik(
    .T(T[1:0]),
    .H(H[1:0]),
    .S(KS)
);

wire MSKS;
and(MSKS, MS, KS);

wire BS2KS;
and(BS2KS, BS2, KS);

wire BS1KS;
and(BS1KS, BS1, KS);

wire BS1BS2MS;
and(BS1BS2MS, BS1, BS2, MS);

or(S, MSKS, BS2KS, BS1KS, BS1BS2MS);

endmodule
