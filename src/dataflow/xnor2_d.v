// Dataflow 2-input XNOR
module xnor2_d (
  input  wire a,
  input  wire b,
  output wire y
);
  assign y = ~(a ^ b);
endmodule

