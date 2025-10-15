// todo.v — Workbook in Verilog comments
// How to use:
// 1) For each task below, write your code directly under the comment block.
// 2) When finished, change [ ] to [x] or write "yes" in the comment.
// 3) Keep your modules/tests in this file or move them to the target paths later.

// ===== Behavioral =====
// [ ] src/behavioral/and2_b.v — Do: Make a 2‑input AND and test all input combos
// --- write your code below ---
module and_b(
    input wire a,
    input wire b,
    output reg y
);
always @(*) begin
    y=a & b;
end
endmodule

/* Notes (and_b):
   Nice clean combinational description. Using always @(*) with a reg output
   avoids latches, so this one is good to go. */
/* More notes (and_b):
   Use blocking assignments (=) in combinational always blocks, as you did,
   to model pure logic without scheduling surprises. A compact alternative is
   dataflow: `assign y = a & b;` which synthesizes identically. In a quick
   testbench, iterate {a,b} through 00,01,10,11 and check y matches a&b.
   If you later widen to buses, ensure both inputs have matching widths. */

// [ ] src/behavioral/mux2_b.v — Do: Make a 2:1 mux with select and test all cases
// --- write your code below ---
module mux_b(
    input wire a,
    input wire b,
    input wire sel,
    output reg y
);
always @(*) begin
    case (sel)
        1'b1: y=b;
        1'b0: y=a;
    endcase
end
endmodule

/* Notes (mux_b):
   Works for sel=0/1, but without a default branch y keeps its previous value
   when sel is X/Z, which simulates like a latch. Add a default assignment or
   pre-initialize y. */
/* More notes (mux_b):
   Two safe idioms: (1) give y a default at block top `y = a; if (sel) y = b;`
   or (2) keep your case but add a default. If you expect X/Z on sel in sim,
   it helps to drive a known safe value to avoid latch-like behavior. Prefer
   if/else for 2:1 muxes; reserve case for multi-way selects for clarity. */
module mux_b_ref(
    input  wire a,
    input  wire b,
    input  wire sel,
    output reg  y
);
always @(*) begin
    case (sel)
        1'b0: y = a;
        1'b1: y = b;
        default: y = 1'b0; // keeps y defined for X/Z selects
    endcase
end
endmodule

// [ ] src/behavioral/not1_b.v — Do: Make a 1‑input inverter and test 0/1
// --- write your code below ---
module not_b(
    input wire a,
    output reg y
)
always @(*) begin
    y=~a;
end
endmodule

/* Notes (not_b):
   Missing semicolon after the port list causes a syntax error. Otherwise the
   body is fine. */
/* More notes (not_b):
   Output may be a wire via dataflow (`assign y = ~a;`) if you don’t need an
   always block. For single-bit signals ~ is bitwise invert; avoid logical !
   unless you specifically want 1-bit boolean semantics. Test with a=0 then 1
   to confirm toggling, and ensure widths match if you later use vectors. */
module not_b_ref(
    input  wire a,
    output reg  y
);
always @(*) begin
    y = ~a;
end
endmodule

// [ ] src/behavioral/or2_b.v — Do: Make a 2‑input OR and test all input combos
// --- write your code below ---
module or_b(
    input wire a,b,
    output reg y
);
always @(*) begin
    y=a|b;
end
endmodule

/* Notes (or_b):
   Straightforward combinational block. No issues here. */
/* More notes (or_b):
   For small gates, dataflow is concise: `assign y = a | b;`. Keep using
   blocking assignments in combinational always to avoid unintended registers.
   Distinguish bitwise `|` from logical `||`; for single-bit wires both align,
   but `|` scales to vectors. Add a 4-case test to confirm the truth table. */

// [ ] src/behavioral/tri_buf_b.v — Do: Make a tri‑state buffer with enable; disabled output is high‑impedance
// --- write your code below ---
module triStateBuffer(
    input en , a,
    output y
);
always (*) begin
    if(en)
        y=a;
    else
        y=1'bz;
end
endmodule

/* Notes (triStateBuffer):
   Two gotchas: (1) use always @(*) so every input is in the sensitivity list;
   (2) assigning 'z procedurally to a reg is rarely synthesizable. Prefer a
   continuous assignment or bufif*. */
/* More notes (triStateBuffer):
   Most FPGAs do not support internal tri-state; use muxing internally and
   tri-state only on top-level I/O pins. The continuous-assign form also makes
   y a wire, which matches multiple-driver semantics better. In sim, watch for
   contention (X) if more than one source can drive the net simultaneously. */
module triStateBuffer_ref(
    input  wire en,
    input  wire a,
    output wire y
);
assign y = en ? a : 1'bz;
endmodule

// [ ] src/behavioral/xnor2_b.v — Do: Make a 2‑input XNOR and verify its truth table
// --- write your code below ---
module exnor_b(
    input wire a,
    input wire b,
    output reg y
);
always (*) begin
    y=~(a^b);
end
endmodule

/* Notes (exnor_b):
   Logic is correct, but write the sensitivity list as @(*). Spelling "exnor"
   is harmless; most codebases spell it xnor. */
/* More notes (exnor_b):
   Prefer `~^` (XNOR) as a shorthand: `y = a ~^ b;` for readability. Ensure
   you use bitwise ops (`^`, `~^`) not logical (`^` is always bitwise). Verify
   all four input combos in a TB, and consider an immediate assertion against
   a reference `assign y_ref = ~(a ^ b);`. Rename modules to avoid collisions. */
module xnor_b_ref(
    input  wire a,
    input  wire b,
    output reg  y
);
always @(*) begin
    y = ~(a ^ b);
end
endmodule

// [ ] src/behavioral/xor2_b.v — Do: Make a 2‑input XOR and verify its truth table
// --- write your code below ---
module xor_b(
    input wire a,b,
    output reg y
);
always @(*) begin
    y=a^b;
end
endmodule

/* Notes (xor_b):
   Looks good—combinational block with reg output and full assignment. */
/* More notes (xor_b):
   You can also use dataflow: `assign y = a ^ b;` for brevity. If you expand to
   vectors, `^` is bitwise XOR; reduction XOR is `^vector` (unary). In sim, be
   aware that `X ^ 0 = X`; add checks to detect X-propagation if that matters.
   Simple TB: sweep a,b and compare against `y_ref = a ^ b`. */

// ===== Dataflow =====
// [ ] src/dataflow/and2_d.v — Do: Make a 2‑input AND and verify the truth table
// --- write your code below ---
module and_d(
    input wire a,b,
    output wire y
);
assign y=a&b;
endmodule

/* Notes (and_d):
   Correct one-line dataflow description. */
/* More notes (and_d):
   Keep consistent spacing around operators for readability. With vectors, the
   bitwise AND applies per bit; for a boolean reduction use unary `&vector`.
   In synthesis this maps to a single two-input AND. TB should toggle inputs
   independently and log the four truth-table outcomes. */

// [ ] src/dataflow/mux2_d.v — Do: Make a 2:1 mux with select and verify both paths
// --- write your code below ---
module mux_d(
    input wire a,
    input wire sel,
    output wire y
);
assign y=(sel) ? b:a;
endmodule

/* Notes (mux_d):
   Expression uses signal b but the port list omits it. Add b to the ports and
   document which input sel=1 picks. */
/* More notes (mux_d):
   The ternary operator is ideal here: `assign y = sel ? b : a;`. It is a pure
   combinational construction and synthesizes efficiently. Document the select
   polarity near the declaration for future readers. Consider guarding unknown
   sel in sim if you want deterministic behavior under X/Z. */
module mux_d_ref(
    input  wire a,
    input  wire b,
    input  wire sel,
    output wire y
);
assign y = sel ? b : a; // sel=1 -> b, sel=0 -> a
endmodule

// [ ] src/dataflow/not1_d.v — Do: Make an inverter and verify 0→1 and 1→0
// --- write your code below ---
module not_d(
    input wire a,
    output wire y
);
assign y=~a;
endmodule

/* Notes (not_d):
   Perfect as-is. */
/* More notes (not_d):
   If you plan to invert a bus later, `assign y = ~a;` naturally bitwise-inverts
   each bit. Ensure the declared widths match to avoid accidental truncation.
   In a TB, step a through 0 and 1 (or a small vector range) and assert `y==~a`.
   No clocking or resets required for pure combinational modules like this. */

// [ ] src/dataflow/or2_d.v — Do: Make a 2‑input OR and verify the truth table
// --- write your code below ---
module or_d(
    input wire a,b,
    output wire y
);
assign y=a|b;
endmodule

/* Notes (or_d):
   Clean OR gate expression. */
/* More notes (or_d):
   Remember `|` is bitwise OR, `||` is logical OR; prefer `|` for signals that
   may later become buses. For reduction OR use unary `|vector`. Verify with a
   simple TB that sweeps inputs and checks `y == (a | b)` under all cases. */

// [ ] src/dataflow/tri_buf_d.v — Do: Make a tri‑state buffer with enable; check high‑impedance when disabled
// --- write your code below ---

module triState(
    input wire a,
    input wire en,
    output wire y
);
assign y=(en) ? a:1'bz;
endmodule

/* Notes (triState):
   Nice continuous assignment—this is the synthesizable pattern for tri-state. */
/* More notes (triState):
   In FPGA targets, internal tri-states are usually not supported; the tools
   convert them to muxes. Keep tri-state usage at top-level I/O when possible.
   Simulate contention scenarios carefully; any simultaneous drivers will yield
   X. For active-low enables, `bufif0` or a ternary with `!en` is appropriate. */

// [ ] src/dataflow/xnor_n_d.v — Do: Make a 2‑input XNOR without using a direct XOR/XNOR operator; verify
// --- write your code below ---
module xnor_d(
    input wire a,b,
    output wire y
);
wire c,d,e,f;
nor g1(c,a,b);
nor g2(d,a,c);
nor g3(e,b,c);
nor g4(f,d,e);
endmodule

/* Notes (xnor_n_d):
   Great NOR network, but y never gets driven. Either hook g4 straight to y or
   assign y=f. */
/* More notes (xnor_n_d):
   This is the minimal 4-NOR realization of XNOR: two cross-coupled NORs form
   the mux-like core, and the final NOR combines them. Keep intermediate nets
   one-bit wires and avoid reusing names across snippets. Add a TB to compare
   this structural version against `y_ref = ~(a ^ b)` for all 4 cases. */
module xnor_n_d_ref(
    input  wire a,
    input  wire b,
    output wire y
);
wire c,d,e;
nor g1(c, a, b);
nor g2(d, a, c);
nor g3(e, b, c);
nor g4(y, d, e);
endmodule

// [ ] src/dataflow/xnor2_d.v — Do: Make a 2‑input XNOR and verify the truth table
// --- write your code below ---
module xnor_d(
    input wire a,b,
    output wire y
);
assign y=~(a^b);
endmodule

/* Notes (xnor2_d):
   Logic is fine, but this reuses the name xnor_d, which collides with the
   previous task. Give each module a unique name. */
/* More notes (xnor2_d):
   A common naming scheme is suffixing by style (e.g., `_d`, `_b`, `_g`) and by
   variant (`_from_nand`). Keeping unique module names avoids link/ELAB errors
   when compiling multiple files together. Add a tiny TB to sweep inputs 00–11.
   `~^` is an idiomatic alternative to `~(a ^ b)`. */
module xnor2_d_ref(
    input  wire a,
    input  wire b,
    output wire y
);
assign y = ~(a ^ b);
endmodule

// [ ] src/dataflow/xor_n_d.v — Do: Make a 2‑input XOR without using a direct XOR operator; verify
// --- write your code below ---
module xor_d(
    input wire a,b,
    output wire y
);
wire c,d,e,f,g;
//5 gates needed
nor g1(c,a,b);
nor g2(d,a,c);
nor g3(e,b,c);
nor g4(f,d,e);
nor g5(g,f,f);
endmodule

/* Notes (xor_n_d):
   Same issue as the XNOR variant—g is the XOR result but y is never assigned,
   and the module name duplicates the next task. Wire y up to g and rename when
   you split the files. */
/* More notes (xor_n_d):
   The 5th NOR acts as an inverter of the XNOR stage, producing XOR. Keep gate
   fanout reasonable; in this small network it’s fine. Verify behavior via a TB
   that compares against `a ^ b`. Distinct module names prevent multiple
   definition conflicts at link/elaboration time. */
module xor_n_d_ref(
    input  wire a,
    input  wire b,
    output wire y
);
wire c,d,e,f,g;
nor g1(c, a, b);
nor g2(d, a, c);
nor g3(e, b, c);
nor g4(f, d, e); // f = XNOR(a,b)
nor g5(g, f, f); // g = XOR(a,b)
assign y = g;
endmodule

// [ ] src/dataflow/xor2_d.v — Do: Make a 2‑input XOR and verify the truth table
// --- write your code below ---
module xor_d(
    input wire a,b,
    output wire y
);
assign y=a^b;
endmodule

/* Notes (xor2_d):
   Behavior is right, but once again the module name duplicates xor_d above.
   Rename to keep each definition unique. */
/* More notes (xor2_d):
   When moving to separate files, align file and module names (e.g., xor2_d.v
   contains `module xor2_d`). This helps build systems and readers. For vector
   inputs, XOR applies bitwise; use a reduction XOR for parity calculations.
   Test all four scalar cases in a minimal TB for confidence. */
module xor2_d_ref(
    input  wire a,
    input  wire b,
    output wire y
);
assign y = a ^ b;
endmodule

// ===== Gate‑Level =====
// [ ] src/additions/gate/and2_g.v — Do: Build a 2‑input AND from basic gates; verify
// --- write your code below ---
module and_g(
    input wire a,b,
    output wire y
);
and g1(y,a,b);
endmodule

/* Notes (and_g):
   Correct gate-level AND instance. */
/* More notes (and_g):
   The primitive form `and (y, a, b);` also works and is idiomatic. Gate
   primitives are positional, not named, so maintain correct port order. In
   timing-aware sims, each primitive adds delay; here we assume zero delay.
   Add a TB to enumerate inputs and confirm the truth table. */

// [ ] src/additions/gate/mux2_g.v — Do: Build a 2:1 mux from basic gates; verify both paths
// --- write your code below ---
module mux_g(
    input wire a,b,
    input wire sel,
    output wire y
);
wire c,d,e;
not g1(c,sel);
and g2(d,a,sel);
and g3(e,c,b);
or g4(y,d,e);
endmodule

/* Notes (mux_g):
   This wiring makes sel=1 pick input a. If you want the more common sel=1 -> b
   convention, swap the paths as in the reference. */
/* More notes (mux_g):
   The structure is (~sel & a) | (sel & b). Double-check the NOT’s target to
   avoid polarity mistakes. Glitches can occur if multiple inputs toggle; add a
   small inertial delay in sim if you want to visualize hazards. TB should
   sweep a,b for both sel=0 and sel=1 and confirm outputs. */
module mux_g_ref(
    input  wire a,
    input  wire b,
    input  wire sel,
    output wire y
);
wire nsel, a_path, b_path;
not (nsel, sel);
and (a_path, a, nsel);
and (b_path, b, sel);
or  (y, a_path, b_path);
endmodule

// [ ] src/additions/gate/not1_g.v — Do: Build an inverter from gates; verify
// --- write your code below ---
module not_d(
    input wire a,
    output wire y
);

not g1(y,a);
endmodule

/* Notes (not1_g):
   Gate instantiation is fine, but the module is still named not_d. Rename it to
   not_g (or similar) to avoid clashes with the dataflow inverter. */
/* More notes (not1_g):
   Primitive inverter syntax is `not (y, a);`. Maintain unique module names per
   style to keep simulators and linkers happy. For buses, use generate loops or
   just `assign y = ~a;` unless you explicitly require gate-level structure.
   Minimal TB: drive 0 then 1 and observe inversion. */
module not_g_ref(
    input  wire a,
    output wire y
);
not (y, a);
endmodule

// [ ] src/additions/gate/or2_g.v — Do: Build a 2‑input OR from basic gates; verify
// --- write your code below ---
module or_g(
    input wire a,b,
    output wire y
);
or g1(y,a,b);
endmodule

/* Notes (or_g):
   Looks great. */
/* More notes (or_g):
   As with AND, the primitive syntax `or (y, a, b);` is common. Ensure there is
   no conflicting or_g elsewhere to avoid redefinition. Gate-level modules are
   helpful for teaching but dataflow is typically preferred in production RTL.
   Verify truth table with a short TB. */

// [ ] src/additions/gate/tri_buf_g.v — Do: Build a tri‑state buffer with enable; check high‑impedance when off
// --- write your code below ---
module triBuffer(
    input wire a,
    input enable b,
    output wire y
);
bufif1 (y,a,b);
endmodule

/* Notes (triBuffer gate-level):
   Port declaration "input enable b" is illegal syntax. Name the enable pin and
   pass it to bufif1(out, in, control). */
/* More notes (triBuffer gate-level):
   `bufif1` drives when control=1; `bufif0` drives when control=0. For FPGAs,
   internal tri-states are mapped to muxes—keep tri-states at I/O pads. In sim,
   an undriven net reads Z; conflicting drivers produce X. Add a TB that toggles
   en and confirms y is Z when disabled and equals a when enabled. */
module triBuffer_ref(
    input  wire a,
    input  wire en,
    output wire y
);
bufif1 (y, a, en);
endmodule

// [ ] src/additions/gate/xnor2_from_nand_g.v — Do: Build a 2‑input XNOR using only NANDs; verify
// --- write your code below ---
//5 gates needed
module xnor_g(
    input wire a,b,
    output wire y
);
wire c,d,e,f;
nand g1(c,a,b);
nand g2(d,a,c);
nand g3(e,b,c);
nand g4(f,d,e);
nand g5(y,f,f);
endmodule

/* Notes (xnor2_from_nand_g):
   Gate network is right, but the module name xnor_g duplicates other sections.
   Give the NAND version a unique name. */
/* More notes (xnor2_from_nand_g):
   This is the canonical 5-NAND XNOR: a and b feed a cross-coupled stage via
   their shared NAND, then a final self-NAND inverts the XNOR to stabilize. In
   TB, compare against `~(a ^ b)`. Keep wire names unique and one-bit. Rename
   consistently to avoid clashes with other xnor_g definitions. */
module xnor2_from_nand_g_ref(
    input  wire a,
    input  wire b,
    output wire y
);
wire p, q, r, s;
nand (p, a, b);
nand (q, a, p);
nand (r, b, p);
nand (s, q, r);
nand (y, s, s);
endmodule

// [ ] src/additions/gate/xnor2_from_nor_g.v — Do: Build a 2‑input XNOR using only NORs; verify
// --- write your code below ---
//4 gates needed
module xnor_g(
    input wire a,b,
    output wire y
);
wire c,d,e;
nor g1(c,a,b);
nor g2(d,a,c);
nor g3(e,b,c);
nor g4(y,d,e);
endmodule

/* Notes (xnor2_from_nor_g):
   Minimal 4-NOR implementation looks perfect. Just remember to rename it when
   you split files so it doesn’t clash with the NAND and primitive versions. */
/* More notes (xnor2_from_nor_g):
   Balanced NOR paths help match delays if you later care about hazards. This
   structural form is pedagogical; in real RTL prefer `assign y = a ~^ b;`.
   Add a TB with all four input combinations and an assertion vs a reference.
   Keep module names unique per implementation style. */
module xnor2_from_nor_g_ref(
    input  wire a,
    input  wire b,
    output wire y
);
wire c, d, e;
nor (c, a, b);
nor (d, a, c);
nor (e, b, c);
nor (y, d, e);
endmodule

// [ ] src/additions/gate/xnor2_g.v — Do: Build a 2‑input XNOR using gate primitives; verify
// --- write your code below ---
module xnor_g(
    input wire a,b,
    output wire y
);
xnor g1(y,a,b);
endmodule

/* Notes (xnor2_g):
   Primitive instantiation is spot-on; just give the wrapper module its own
   distinct name. */
/* More notes (xnor2_g):
   Primitive `xnor (y, a, b);` is concise and portable. Remember that primitives
   are purely combinational here (no delays specified). Match file and module
   names to simplify builds. Test with a tiny TB to cover 00–11 on {a,b}. */
module xnor2_g_ref(
    input  wire a,
    input  wire b,
    output wire y
);
xnor (y, a, b);
endmodule

// [ ] src/additions/gate/xor2_from_nand_g.v — Do: Build a 2‑input XOR using only NANDs; verify
// --- write your code below ---

module xnor_g(
    input wire a,b,
    output wire y
);
xor g1(y,a,b);
endmodule

/* Notes (xor2_from_nand_g):
   This still instantiates the XOR primitive and even names the module xnor_g.
   Use the four-NAND structure instead. */
/* More notes (xor2_from_nand_g):
   The XOR-from-NAND is 4 gates: p = nand(a,b); y = nand(nand(a,p), nand(b,p)).
   Ensure all wires are declared and drive y explicitly. Rename modules to avoid
   conflicts with XOR primitive wrappers. Verify via TB that matches `a ^ b`.
   Keep polarity straight; no inverters needed beyond NAND combinations. */
module xor2_from_nand_g_ref(
    input  wire a,
    input  wire b,
    output wire y
);
wire p, q, r;
nand (p, a, b);
nand (q, a, p);
nand (r, b, p);
nand (y, q, r);
endmodule

// [ ] src/additions/gate/xor2_from_nor_g.v — Do: Build a 2‑input XOR using only NORs; verify
// --- write your code below ---
//5 gates required
module xor_g(
    input wire a,b,
    output wire y
);
wire c,d,e,f;

nor g1(c,a,b);
nor g2(d,a,c);
nor g3(e,b,c);
nor g4(f,d,e);
nor g5(y,f,f);
endmodule

/* Notes (xor2_from_nor_g):
   Nicely done: 4 NORs for XNOR plus the final inverter gives XOR. Consider
   renaming to keep it distinct from the primitive XOR wrapper. */
/* More notes (xor2_from_nor_g):
   The last `nor (y, f, f);` is a compact inverter. Maintain symmetry to balance
   delays if observing hazards. Provide a TB that compares against `a ^ b` for
   all 4 cases. Keep module names distinct across styles to prevent clashes. */
module xor2_from_nor_g_ref(
    input  wire a,
    input  wire b,
    output wire y
);
wire c, d, e, f;
nor (c, a, b);
nor (d, a, c);
nor (e, b, c);
nor (f, d, e);
nor (y, f, f);
endmodule

// [ ] src/additions/gate/xor2_g.v - Do: Build a 2-input XOR using gate primitives; verify
// --- write your code below ---
module xor_g(
    input wire a,b,
    output wire y
);
xor g1(y,a,b);
endmodule

/* Notes (xor2_g):
   Logic is fine, but this shares the name xor_g with the NOR-only version.
   Give each wrapper a unique identifier. */
/* More notes (xor2_g):
   Primitive `xor (y, a, b);` is the simplest XOR form. Align file/module names
   (e.g., xor2_g.v -> module xor2_g) to keep toolchains happy. Write a tiny TB
   that iterates a,b through 00–11 and checks y equals `a ^ b`. */
module xor2_g_ref(
    input  wire a,
    input  wire b,
    output wire y
);
xor (y, a, b);
endmodule

// ===== Testbenches =====
// [ ] tb/common/assert.vh - Do: Ensure this macros file is available to your testbenches
// --- write your code below ---

/* Notes (tb/common/assert.vh):
   No content yet. Drop in your assertion macro definitions here when ready. */
/* More notes (tb/common/assert.vh):
   Include guards help: ``ifndef ASSERT_VH / ``define ASSERT_VH … ``endif. Add
   simple macros like `ASSERT_EQ(msg, got, exp)` that $fatal on mismatch. Place
   this file under tb/common and `include it from TBs. Consider also providing
   helper display and dumpfile macros to standardize wave capture. */

// [ ] tb/gates_all_styles_tb.v - Do: Test all gate styles and confirm expected outputs
// --- write your code below ---

/* Notes (tb/gates_all_styles_tb):
   Testbench stub is empty—add stimuli and checks covering each AND/OR/XOR
   flavor once the DUT modules are finalized. */
/* More notes (tb/gates_all_styles_tb):
   Add `timescale`, instantiate each DUT variant, and sweep inputs with a small
   for-loop over {a,b}. Use a common reference (behavioral) and compare outputs
   with assertions. Dump waves via $dumpfile/$dumpvars for debugging. Keep TBs
   self-checking so failures are obvious in CI. */

// [ ] tb/xor_xnor_tb.v - Do: Test XOR/XNOR modules with all input combos and confirm outputs
// --- write your code below ---

/* Notes (tb/xor_xnor_tb):
   Another placeholder. Build a simple loop over {a,b} values and compare each
   implementation against a reference model. */
/* More notes (tb/xor_xnor_tb):
   Instantiate structural (NAND/NOR) and primitive versions side-by-side.
   Drive all input permutations and assert each DUT matches a golden model.
   Include the assert.vh macros to keep the TB readable, and dump VCD to
   visualize mismatches. Keep module names unique to avoid ELAB collisions. */

// ===== Misc =====
// [ ] sample.v - Do: Use as a scratchpad for quick experiments as needed
// --- write your code below ---

/* Notes (sample.v):
   Empty scratch area—feel free to prototype snippets here before moving them
   into the structured sections above. */
/* More notes (sample.v):
   Add `timescale 1ns/1ps` at top when simulating scratch code. Avoid defining
   modules here that duplicate names used elsewhere to prevent redefinition
   errors. Use this file to iterate quickly, then promote stable designs to
   their respective style folders with aligned filenames. */
