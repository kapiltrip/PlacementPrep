// Behavioral 2:1 mux
module mux2_b (
  input  wire a,
  input  wire b,
  input  wire sel,
  output reg  y
);
  always @* begin
    case (sel)
      1'b0: y = a;
      1'b1: y = b;
    endcase
  end
endmodule

