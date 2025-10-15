// Majority detector for three inputs
module majority_detector_3 (
    input  wire a,
    input  wire b,
    input  wire c,
    output wire majority
);
    assign majority = (a & b) | (a & c) | (b & c);
endmodule
