// Gate-level 2-input AND
module and2_g (
  input  wire a,
  input  wire b,
  output wire y
);
  and u_and(y, a, b);
endmodule

