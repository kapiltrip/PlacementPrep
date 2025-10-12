// Behavioral tri-state buffer
module tri_buf_b (
  input  wire en,
  input  wire a,
  output reg  y
);
  always @* begin
    if (en) y = a; else y = 1'bz;
  end
endmodule

