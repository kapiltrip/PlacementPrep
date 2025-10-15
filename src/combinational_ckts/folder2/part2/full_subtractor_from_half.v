// Full subtractor using two half subtractors and an OR gate
module full_subtractor_from_half (
    input  wire a,
    input  wire b,
    input  wire bin,
    output wire diff,
    output wire bout
);
    wire d1;
    wire b1;
    wire b2;

    half_subtractor hs0 (
        .a      (a),
        .b      (b),
        .diff   (d1),
        .borrow (b1)
    );

    half_subtractor hs1 (
        .a      (d1),
        .b      (bin),
        .diff   (diff),
        .borrow (b2)
    );

    assign bout = b1 | b2;
endmodule
