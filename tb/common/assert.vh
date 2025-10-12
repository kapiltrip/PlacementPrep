// Tiny assert helpers for self-checking benches

`ifndef TB_ASSERT_VH
`define TB_ASSERT_VH

// Expects an integer 'errors' declared in the TB scope
`define CHECK_EQ(NAME, ACT, EXP) \
  if ((ACT) !== (EXP)) begin \
    $display("FAIL: %s @%0t  got=%b exp=%b", NAME, $time, ACT, EXP); \
    errors = errors + 1; \
  end

`define CHECK_TRUE(NAME, COND) \
  if (!(COND)) begin \
    $display("FAIL: %s @%0t condition false", NAME, $time); \
    errors = errors + 1; \
  end

`define FINISH_SUMMARY(TESTNAME) \
  begin \
    if (errors == 0) begin \
      $display("PASS: %s", TESTNAME); \
      $finish; \
    end else begin \
      $display("FAIL: %s  errors=%0d", TESTNAME, errors); \
      $fatal(1, "TB failed: %s", TESTNAME); \
    end \
  end

`endif
