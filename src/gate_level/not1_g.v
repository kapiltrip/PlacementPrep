// Gate-level inverter
module not1_g (
  input  wire a,
  output wire y
);
  not u_not(y, a);
endmodule

