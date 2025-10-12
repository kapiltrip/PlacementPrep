// Dataflow 2-input OR
module or2_d (
  input  wire a,
  input  wire b,
  output wire y
);
  assign y = a | b;
endmodule

