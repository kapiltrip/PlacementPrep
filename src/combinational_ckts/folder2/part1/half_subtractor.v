// Half subtractor generating difference and borrow
module half_subtractor (
    input  wire a,  // minuend
    input  wire b,  // subtrahend
    output wire diff,
    output wire borrow
);
    assign diff   = a ^ b;
    assign borrow = (~a) & b;
endmodule
