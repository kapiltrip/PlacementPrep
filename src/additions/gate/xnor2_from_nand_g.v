// XNOR using only NAND gates (XOR then invert via self-NAND)
module xnor2_from_nand_g (
  input  wire a,
  input  wire b,
  output wire y
);
  wire p, q, r, xor_y;
  nand u1(p, a, b);
  nand u2(q, a, p);
  nand u3(r, b, p);
  nand u4(xor_y, q, r);
  nand u5(y, xor_y, xor_y); // invert to get XNOR
endmodule


