// XOR gate implemented using only NAND gates
module xor_from_nand (
    input  wire a,
    input  wire b,
    output wire y
);
    wire n1 = ~(a & b);
    wire n2 = ~(a & n1);
    wire n3 = ~(b & n1);
    assign y = ~(n2 & n3);
endmodule
