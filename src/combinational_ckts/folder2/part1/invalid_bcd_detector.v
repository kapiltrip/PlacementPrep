// Detector that flags invalid BCD inputs (10-15)
module invalid_bcd_detector (
    input  wire [3:0] bcd,
    output wire invalid
);
    wire b3 = bcd[3];
    wire b2 = bcd[2];
    wire b1 = bcd[1];
    assign invalid = (b3 & b2) | (b3 & b1) | (b2 & b1);
endmodule
