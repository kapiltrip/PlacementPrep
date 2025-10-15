// Minority detector for three inputs
module minority_detector_3 (
    input  wire a,
    input  wire b,
    input  wire c,
    output wire minority
);
    assign minority = (~a & ~b) | (~a & ~c) | (~b & ~c);
endmodule
