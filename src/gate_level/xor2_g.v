// Gate-level 2-input XOR using primitive
module xor2_g (
  input  wire a,
  input  wire b,
  output wire y
);
  xor u_xor(y, a, b);
endmodule

