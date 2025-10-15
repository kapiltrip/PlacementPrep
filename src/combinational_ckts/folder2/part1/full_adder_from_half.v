// Full adder constructed from two half adders and an OR gate
module full_adder_from_half (
    input  wire a,
    input  wire b,
    input  wire cin,
    output wire sum,
    output wire cout
);
    wire s1;
    wire c1;
    wire c2;

    half_adder ha0 (
        .a   (a),
        .b   (b),
        .sum (s1),
        .carry(c1)
    );

    half_adder ha1 (
        .a   (s1),
        .b   (cin),
        .sum (sum),
        .carry(c2)
    );

    assign cout = c1 | c2;
endmodule
