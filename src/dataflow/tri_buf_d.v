// Dataflow tri-state buffer
module tri_buf_d (
  input  wire en,
  input  wire a,
  output wire y
);
  assign y = en ? a : 1'bz;
endmodule

