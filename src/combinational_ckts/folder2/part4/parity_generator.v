// Parity generator for even or odd parity
module parity_generator #(
    parameter WIDTH = 7,
    parameter ODD   = 1'b0
) (
    input  wire [WIDTH-1:0] data_in,
    output wire             parity_bit
);
    wire xor_sum = ^data_in;
    assign parity_bit = ODD ? ~xor_sum : xor_sum;
endmodule
