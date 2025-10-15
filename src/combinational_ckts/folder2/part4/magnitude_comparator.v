// Parameterizable magnitude comparator producing one-hot outputs
module magnitude_comparator #(
    parameter WIDTH = 4
) (
    input  wire [WIDTH-1:0] a,
    input  wire [WIDTH-1:0] b,
    output wire             a_gt_b,
    output wire             a_eq_b,
    output wire             a_lt_b
);
    assign a_gt_b = (a > b);
    assign a_eq_b = (a == b);
    assign a_lt_b = (a < b);
endmodule
