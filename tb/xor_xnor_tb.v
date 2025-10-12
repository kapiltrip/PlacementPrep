`timescale 1ns/1ps
`include "common/assert.vh"

module xor_xnor_tb;
  reg a, b;
  reg [3:0] v;
  integer i;
  integer errors;
  integer ones;

  // 2-input XOR/XNOR (3 styles)
  wire y_xor_g, y_xor_d, y_xor_b;
  wire y_xnor_g, y_xnor_d, y_xnor_b;
  // From NAND/NOR structural versions
  wire y_xor_nand, y_xnor_nand, y_xor_nor, y_xnor_nor;

  // N-input reduction versions (N=4)
  wire y_xor4, y_xnor4;

  xor2_g  u_xor_g (.a(a), .b(b), .y(y_xor_g));
  xor2_d  u_xor_d (.a(a), .b(b), .y(y_xor_d));
  xor2_b  u_xor_b (.a(a), .b(b), .y(y_xor_b));

  xnor2_g u_xnor_g(.a(a), .b(b), .y(y_xnor_g));
  xnor2_d u_xnor_d(.a(a), .b(b), .y(y_xnor_d));
  xnor2_b u_xnor_b(.a(a), .b(b), .y(y_xnor_b));

  xor2_from_nand_g  u_xor_nand (.a(a), .b(b), .y(y_xor_nand));
  xnor2_from_nand_g u_xnor_nand(.a(a), .b(b), .y(y_xnor_nand));
  xor2_from_nor_g   u_xor_nor  (.a(a), .b(b), .y(y_xor_nor));
  xnor2_from_nor_g  u_xnor_nor (.a(a), .b(b), .y(y_xnor_nor));

  xor_n_d  #(.N(4)) u_xor4 (.a(v), .y(y_xor4));
  xnor_n_d #(.N(4)) u_xnor4(.a(v), .y(y_xnor4));

  initial begin
    $dumpfile("xor_xnor.vcd");
    $dumpvars(0, xor_xnor_tb);
  end

  initial begin
    errors = 0;

    // 2-input truth tables and cross-check between implementations
    for (i = 0; i < 4; i = i + 1) begin
      {a, b} = i[1:0]; #1;
      // Expected values
      `CHECK_EQ("xor_g",  y_xor_g,  (a ^ b))
      `CHECK_EQ("xor_d",  y_xor_d,  (a ^ b))
      `CHECK_EQ("xor_b",  y_xor_b,  (a ^ b))
      `CHECK_EQ("xnor_g", y_xnor_g, ~(a ^ b))
      `CHECK_EQ("xnor_d", y_xnor_d, ~(a ^ b))
      `CHECK_EQ("xnor_b", y_xnor_b, ~(a ^ b))

      // Structural-only equivalence
      `CHECK_EQ("xor_nand", y_xor_nand, (a ^ b))
      `CHECK_EQ("xor_nor",  y_xor_nor,  (a ^ b))
      `CHECK_EQ("xnor_nand",y_xnor_nand,~(a ^ b))
      `CHECK_EQ("xnor_nor", y_xnor_nor, ~(a ^ b))
    end

    // XOR identities
    a = 0; b = 0; #1; `CHECK_EQ("A^A=0(0)", (a^a), 1'b0)
    a = 1; b = 0; #1; `CHECK_EQ("A^A=0(1)", (a^a), 1'b0)
    a = 0; b = 1; #1; `CHECK_EQ("A^0=A(0)", (a^1'b0), a)
    a = 1; b = 1; #1; `CHECK_EQ("A^1=~A(1)", (a^1'b1), ~a)

    // 4-input parity: XOR=1 for odd ones, XNOR=1 for even ones
    for (i = 0; i < 16; i = i + 1) begin
      v = i[3:0]; #1;
      // compute popcount mod 2
      ones = v[0] + v[1] + v[2] + v[3];
      `CHECK_EQ("xor4_parity",  y_xor4,  ((ones % 2) ? 1'b1 : 1'b0))
      `CHECK_EQ("xnor4_parity", y_xnor4, ((ones % 2) ? 1'b0 : 1'b1))
    end

    `FINISH_SUMMARY("xor_xnor_tb")
  end
endmodule
