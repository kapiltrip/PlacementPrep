// Parameterizable ripple-carry adder built from full adders
module ripple_carry_adder #(
    parameter WIDTH = 4
) (
    input  wire [WIDTH-1:0] a,
    input  wire [WIDTH-1:0] b,
    input  wire             cin,
    output wire [WIDTH-1:0] sum,
    output wire             cout
);
    wire [WIDTH:0] carry;
    assign carry[0] = cin;

    genvar i;
    generate
        for (i = 0; i < WIDTH; i = i + 1) begin : gen_fa
            full_adder fa (
                .a         (a[i]),
                .b         (b[i]),
                .cin       (carry[i]),
                .sum       (sum[i]),
                .cout      (carry[i+1]),
                .propagate (),
                .generate  ()
            );
        end
    endgenerate

    assign cout = carry[WIDTH];
endmodule
