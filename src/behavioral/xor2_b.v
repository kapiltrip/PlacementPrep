// Behavioral 2-input XOR
module xor2_b (
  input  wire a,
  input  wire b,
  output reg  y
);
  always @* begin
    y = a ^ b;
  end
endmodule

