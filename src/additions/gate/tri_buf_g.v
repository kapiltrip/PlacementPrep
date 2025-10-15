// Gate-level tri-state buffer: y = (en ? a : Z)
module tri_buf_g (
  input  wire en,
  input  wire a,
  output wire y
);
  bufif1 u_buf(y, a, en); // drive when en==1, else Z
endmodule


