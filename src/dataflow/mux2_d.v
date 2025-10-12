// Dataflow 2:1 mux
module mux2_d (
  input  wire a,
  input  wire b,
  input  wire sel,
  output wire y
);
  assign y = sel ? b : a;
endmodule

