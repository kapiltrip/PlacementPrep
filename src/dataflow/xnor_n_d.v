// Dataflow N-input XNOR (even parity)
module xnor_n_d #(
  parameter N = 4
)(
  input  wire [N-1:0] a,
  output wire         y
);
  assign y = ~^a; // reduction XNOR: 1 if even number of 1s
endmodule

