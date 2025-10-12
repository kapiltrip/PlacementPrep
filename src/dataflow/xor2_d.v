// Dataflow 2-input XOR
module xor2_d (
  input  wire a,
  input  wire b,
  output wire y
);
  assign y = a ^ b;
endmodule

