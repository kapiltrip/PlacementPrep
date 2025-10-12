// XNOR using only 4 NOR gates
module xnor2_from_nor_g (
  input  wire a,
  input  wire b,
  output wire y
);
  wire t1, t2, t3;
  nor u1(t1, a, b);    // t1 = ~(a + b)
  nor u2(t2, a, t1);   // t2 = ~(a + t1) = ~a & b
  nor u3(t3, b, t1);   // t3 = ~(b + t1) = a & ~b
  nor u4(y, t2, t3);   // y = ~(t2 + t3) = XNOR
endmodule
