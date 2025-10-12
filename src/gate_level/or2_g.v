// Gate-level 2-input OR
module or2_g (
  input  wire a,
  input  wire b,
  output wire y
);
  or u_or(y, a, b);
endmodule

