// Parity checker that flags an error when parity is violated
module parity_checker #(
    parameter WIDTH = 7,
    parameter ODD   = 1'b0
) (
    input  wire [WIDTH-1:0] data_in,
    input  wire             parity_bit,
    output wire             error
);
    wire xor_sum = ^{data_in, parity_bit};
    assign error = ODD ? xor_sum : ~xor_sum;
endmodule
