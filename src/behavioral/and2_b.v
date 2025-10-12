// Behavioral 2-input AND
module and2_b (
  input  wire a,
  input  wire b,
  output reg  y
);
  always @* begin
    y = a & b;
  end
endmodule

