// XOR using only NAND gates (4 NANDs)
// Ref: p = ~(a & b); q = ~(a & p); r = ~(b & p); y = ~(q & r)
module xor2_from_nand_g (
  input  wire a,
  input  wire b,
  output wire y
);
  wire p, q, r;
  nand u1(p, a, b);
  nand u2(q, a, p);
  nand u3(r, b, p);
  nand u4(y, q, r);
endmodule


