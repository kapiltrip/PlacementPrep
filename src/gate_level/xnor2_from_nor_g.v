// XNOR using only NOR gates (derive directly)
module xnor2_from_nor_g (
  input  wire a,
  input  wire b,
  output wire y
);
  wire na, nb, t1, t2;
  nor u1(na, a, a);   // ~a
  nor u2(nb, b, b);   // ~b
  nor u3(t1, a, b);   // ~(a+b) = ~a & ~b
  nor u4(t2, na, nb); // ~(~a + ~b) = a & b
  // y = t1 | t2 using NOR: y = inv( t1 NOR t2 )
  wire y_n;
  nor u5(y_n, t1, t2);
  nor u6(y, y_n, y_n);
endmodule

