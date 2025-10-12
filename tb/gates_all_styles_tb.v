`timescale 1ns/1ps
`include "common/assert.vh"

module gates_all_styles_tb;
  // Shared inputs
  reg a, b, sel, en;
  reg exp;
  integer i, j;
  integer errors;

  // AND outputs
  wire y_and_g, y_and_d, y_and_b;
  // OR outputs
  wire y_or_g, y_or_d, y_or_b;
  // NOT outputs
  wire y_not_g, y_not_d, y_not_b;
  // MUX outputs
  wire y_mux_g, y_mux_d, y_mux_b;
  // TRI-STATE outputs
  wire y_tri_g, y_tri_d; 
  wire y_tri_b; // wire is fine; driven by reg in DUT

  // Instantiate DUTs (3 styles each)
  and2_g  u_and_g(.a(a), .b(b), .y(y_and_g));
  and2_d  u_and_d(.a(a), .b(b), .y(y_and_d));
  and2_b  u_and_b(.a(a), .b(b), .y(y_and_b));

  or2_g   u_or_g (.a(a), .b(b), .y(y_or_g));
  or2_d   u_or_d (.a(a), .b(b), .y(y_or_d));
  or2_b   u_or_b (.a(a), .b(b), .y(y_or_b));

  not1_g  u_not_g(.a(a), .y(y_not_g));
  not1_d  u_not_d(.a(a), .y(y_not_d));
  not1_b  u_not_b(.a(a), .y(y_not_b));

  mux2_g  u_mux_g(.a(a), .b(b), .sel(sel), .y(y_mux_g));
  mux2_d  u_mux_d(.a(a), .b(b), .sel(sel), .y(y_mux_d));
  mux2_b  u_mux_b(.a(a), .b(b), .sel(sel), .y(y_mux_b));

  tri_buf_g u_tri_g(.en(en), .a(a), .y(y_tri_g));
  tri_buf_d u_tri_d(.en(en), .a(a), .y(y_tri_d));
  tri_buf_b u_tri_b(.en(en), .a(a), .y(y_tri_b));

  // Wave dump (optional)
  initial begin
    $dumpfile("waves.vcd");
    $dumpvars(0, gates_all_styles_tb);
  end

  // Test sequences
  initial begin
    errors = 0;

    // AND gate: sweep all combinations
    for (i = 0; i < 4; i = i + 1) begin
      {a, b} = i[1:0]; #1;
      exp = (a & b);
      `CHECK_EQ("and_g", y_and_g, exp)
      `CHECK_EQ("and_d", y_and_d, exp)
      `CHECK_EQ("and_b", y_and_b, exp)
    end

    // OR gate
    for (i = 0; i < 4; i = i + 1) begin
      {a, b} = i[1:0]; #1;
      exp = (a | b);
      `CHECK_EQ("or_g", y_or_g, exp)
      `CHECK_EQ("or_d", y_or_d, exp)
      `CHECK_EQ("or_b", y_or_b, exp)
    end

    // NOT gate
    for (i = 0; i < 2; i = i + 1) begin
      a = i[0]; #1;
      exp = ~a;
      `CHECK_EQ("not_g", y_not_g, exp)
      `CHECK_EQ("not_d", y_not_d, exp)
      `CHECK_EQ("not_b", y_not_b, exp)
    end

    // 2:1 MUX
    for (j = 0; j < 2; j = j + 1) begin
      sel = j[0];
      for (i = 0; i < 4; i = i + 1) begin
        {a, b} = i[1:0]; #1;
        exp = sel ? b : a;
        `CHECK_EQ("mux_g", y_mux_g, exp)
        `CHECK_EQ("mux_d", y_mux_d, exp)
        `CHECK_EQ("mux_b", y_mux_b, exp)
      end
    end

    // Tri-state buffer: en=1 → y=a; en=0 → Z
    for (j = 0; j < 2; j = j + 1) begin
      en = j[0];
      for (i = 0; i < 2; i = i + 1) begin
        a = i[0]; #1;
        if (en) begin
          exp = a;
          `CHECK_EQ("tri_g_en", y_tri_g, exp)
          `CHECK_EQ("tri_d_en", y_tri_d, exp)
          `CHECK_EQ("tri_b_en", y_tri_b, exp)
        end else begin
          `CHECK_EQ("tri_g_dis", y_tri_g, 1'bz)
          `CHECK_EQ("tri_d_dis", y_tri_d, 1'bz)
          `CHECK_EQ("tri_b_dis", y_tri_b, 1'bz)
        end
      end
    end

    `FINISH_SUMMARY("gates_all_styles_tb")
  end
endmodule

