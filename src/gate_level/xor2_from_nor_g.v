// XOR using only NOR gates (5 NORs)
// n1=~a, n2=~b, t1=a&~b, t2=~a&b, y=t1|t2 = invert(nor(t1,t2))
module xor2_from_nor_g (
  input  wire a,
  input  wire b,
  output wire y
);
  wire na, nb, t1, t2, y_n;
  nor u1(na, a, a);   // ~a
  nor u2(nb, b, b);   // ~b
  nor u3(t1, a, nb);  // ~(a + ~b) = ~a & b
  nor u4(t2, na, b);  // ~(~a + b) = a & ~b
  nor u5(y_n, t1, t2);// ~(t1 + t2) = ~(XOR) = XNOR
  nor u6(y, y_n, y_n);// invert to get XOR
endmodule

