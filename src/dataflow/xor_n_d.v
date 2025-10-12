// Dataflow N-input XOR (odd parity)
module xor_n_d #(
  parameter N = 4
)(
  input  wire [N-1:0] a,
  output wire         y
);
  assign y = ^a; // reduction XOR: 1 if odd number of 1s
endmodule

