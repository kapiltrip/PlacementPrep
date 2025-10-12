// Gate-level 2:1 multiplexor
module mux2_g (
  input  wire a,
  input  wire b,
  input  wire sel,
  output wire y
);
  wire nsel, ya, yb;
  not  u0(nsel, sel);
  and  u1(ya, a, nsel);
  and  u2(yb, b, sel);
  or   u3(y, ya, yb);
endmodule

