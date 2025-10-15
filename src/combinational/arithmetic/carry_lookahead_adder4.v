// Four-bit carry look-ahead adder using propagate/generate signals
module carry_lookahead_adder4 (
    input  wire [3:0] a,
    input  wire [3:0] b,
    input  wire       cin,
    output wire [3:0] sum,
    output wire       cout,
    output wire [3:0] carry
);
    wire [3:0] p = a ^ b;
    wire [3:0] g = a & b;

    assign carry[0] = cin;
    assign carry[1] = g[0] | (p[0] & carry[0]);
    assign carry[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & carry[0]);
    assign carry[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & carry[0]);
    assign cout      = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) |
                       (p[3] & p[2] & p[1] & g[0]) |
                       (p[3] & p[2] & p[1] & p[0] & carry[0]);

    assign sum = p ^ carry;
endmodule
