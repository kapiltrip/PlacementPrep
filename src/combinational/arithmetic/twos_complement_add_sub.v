// Mode-controlled adder/subtractor using two's complement
module twos_complement_add_sub #(
    parameter WIDTH = 4
) (
    input  wire [WIDTH-1:0] a,
    input  wire [WIDTH-1:0] b,
    input  wire             mode, // 0: add, 1: subtract
    output wire [WIDTH-1:0] result,
    output wire             cout
);
    wire [WIDTH-1:0] b_xor = b ^ {WIDTH{mode}};
    ripple_carry_adder #(.WIDTH(WIDTH)) u_rca (
        .a   (a),
        .b   (b_xor),
        .cin (mode),
        .sum (result),
        .cout(cout)
    );
endmodule
