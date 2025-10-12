// Behavioral inverter
module not1_b (
  input  wire a,
  output reg  y
);
  always @* begin
    y = ~a;
  end
endmodule

