// Gate-level 2-input XNOR using primitive
module xnor2_g (
  input  wire a,
  input  wire b,
  output wire y
);
  xnor u_xnor(y, a, b);
endmodule


