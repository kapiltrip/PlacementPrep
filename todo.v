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

// ===== Dataflow =====
// [ ] src/dataflow/and2_d.v — Do: Make a 2‑input AND and verify the truth table
// --- write your code below ---
module and_d(
    input wire a,b,
    output wire y
);
assign y=a&b;
endmodule 


// [ ] src/dataflow/mux2_d.v — Do: Make a 2:1 mux with select and verify both paths
// --- write your code below ---
module mux_d(
    input wire a,
    input wire sel,
    output wire y 
);
assign y=(sel) ? b:a;
endmodule 



// [ ] src/dataflow/not1_d.v — Do: Make an inverter and verify 0→1 and 1→0
// --- write your code below ---
module not_d(
    input wire a,
    output wire y
);
assign y=~a;
endmodule



// [ ] src/dataflow/or2_d.v — Do: Make a 2‑input OR and verify the truth table
// --- write your code below ---
module or_d(
    input wire a,b,
    output wire y
);
assign y=a|b;
endmodule 


// [ ] src/dataflow/tri_buf_d.v — Do: Make a tri‑state buffer with enable; check high‑impedance when disabled
// --- write your code below ---

module triState(
    input wire a,
    input wire en,
    output wire y
);
assign y=(en) ? a:1'bz;
endmodule 

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


// [ ] src/dataflow/xnor2_d.v — Do: Make a 2‑input XNOR and verify the truth table
// --- write your code below ---
module xnor_d(
    input wire a,b,
    output wire y
);
assign y=~(a^b);
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



// [ ] src/dataflow/xor2_d.v — Do: Make a 2‑input XOR and verify the truth table
// --- write your code below ---
module xor_d(
    input wire a,b,
    output wire y
);
assign y=a^b;
endmodule 

// ===== Gate‑Level =====
// [ ] src/gate_level/and2_g.v — Do: Build a 2‑input AND from basic gates; verify
// --- write your code below ---
module and_g(
    input wire a,b,
    output wire y
);
and g1(y,a,b);
endmodule 



// [ ] src/gate_level/mux2_g.v — Do: Build a 2:1 mux from basic gates; verify both paths
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
// [ ] src/gate_level/not1_g.v — Do: Build an inverter from gates; verify
// --- write your code below ---
module not_d(
    input wire a,
    output wire y
);

not g1(y,a);
endmodule 


// [ ] src/gate_level/or2_g.v — Do: Build a 2‑input OR from basic gates; verify
// --- write your code below ---
module or_g(
    input wire a,b,
    output wire y
);
or g1(y,a,b);
endmodule 

// [ ] src/gate_level/tri_buf_g.v — Do: Build a tri‑state buffer with enable; check high‑impedance when off
// --- write your code below ---
module triBuffer(
    input wire a,
    input enable b,
    output wire y
);
bufif1 (y,a,b);
endmodule 


// [ ] src/gate_level/xnor2_from_nand_g.v — Do: Build a 2‑input XNOR using only NANDs; verify
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

// [ ] src/gate_level/xnor2_from_nor_g.v — Do: Build a 2‑input XNOR using only NORs; verify
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



// [ ] src/gate_level/xnor2_g.v — Do: Build a 2‑input XNOR using gate primitives; verify
// --- write your code below ---
module xnor_g(
    input wire a,b,
    output wire y
);
xnor g1(y,a,b);
endmodule 


// [ ] src/gate_level/xor2_from_nand_g.v — Do: Build a 2‑input XOR using only NANDs; verify
// --- write your code below ---

module xnor_g(
    input wire a,b,
    output wire y
);
xor g1(y,a,b);
endmodule 

// [ ] src/gate_level/xor2_from_nor_g.v — Do: Build a 2‑input XOR using only NORs; verify
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

// [ ] src/gate_level/xor2_g.v - Do: Build a 2-input XOR using gate primitives; verify
// --- write your code below ---
module xor_g(
    input wire a,b,
    output wire y
);
xor g1(y,a,b);
endmodule 


// ===== Testbenches =====
// [ ] tb/common/assert.vh - Do: Ensure this macros file is available to your testbenches
// --- write your code below ---


// [ ] tb/gates_all_styles_tb.v - Do: Test all gate styles and confirm expected outputs
// --- write your code below ---


// [ ] tb/xor_xnor_tb.v - Do: Test XOR/XNOR modules with all input combos and confirm outputs
// --- write your code below ---


// ===== Misc =====
// [ ] sample.v - Do: Use as a scratchpad for quick experiments as needed
// --- write your code below ---


// ===== Review Notes and Corrections (Teacher Feedback) =====
// This section contains review notes and, where needed, corrected reference versions.
// Your originals above remain unchanged; compare with the *_ref modules below.

/* Notes: and_b
Good combinational behavioral implementation. You used always @(*) and a reg output, so no latch is inferred. Spacing and clarity are fine. No change required. */

/* Notes: mux_b
Works functionally for sel=0/1. However, with case and no default, sel being X/Z in simulation would leave y unassigned in that cycle (latch-like behavior). Add a default or pre-assign y to avoid this. */
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
        default: y = 1'b0; // avoids X/Z propagating a latch in sim
    endcase
end
endmodule

/* Notes: not_b
Minor syntax issue: the module port list is missing a semicolon after ")". Otherwise the idea is correct. */
module not_b_ref(
    input  wire a,
    output reg  y
);
always @(*) begin
    y = ~a;
end
endmodule

/* Notes: or_b
Looks good: combinational block with reg output and clear expression. No change required. */

/* Notes: triStateBuffer (behavioral)
Two issues: (1) always needs @(*), not just (*). (2) Driving a tri-state ('z) from a procedural assignment to a reg is usually not synthesizable on FPGAs; prefer a continuous assignment or bufif* primitive. Reference below uses a continuous assign. */
module triStateBuffer_ref(
    input  wire en,
    input  wire a,
    output wire y
);
assign y = en ? a : 1'bz;
endmodule

/* Notes: exnor_b
Spelling "exnor" is okay but typically named XNOR. Also same always @(*) note: use @(*), not bare (*). */
module xnor_b_ref(
    input  wire a,
    input  wire b,
    output reg  y
);
always @(*) begin
    y = ~(a ^ b);
end
endmodule

/* Notes: xor_b
Solid: combinational always with reg output. No change required. */

/* Notes: and_d
Correct continuous assignment. No change required. */

/* Notes: mux_d
You use b in the expression but did not declare b in the port list. Add it. Also clarify selection sense in a comment. */
module mux_d_ref(
    input  wire a,
    input  wire b,
    input  wire sel,
    output wire y
);
assign y = sel ? b : a; // sel=1 -> b, sel=0 -> a
endmodule

/* Notes: not_d
Good. No change required. */

/* Notes: or_d
Good. No change required. */

/* Notes: triState (dataflow)
Good use of continuous assign for tri-state. No change required. */

/* Notes: xnor_n_d (NOR-only XNOR, dataflow/gates mixed)
You built the 4-NOR network but didn’t drive y. Either connect g4 directly to y or assign y=f. Reference below connects g4 to y. */
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

/* Notes: xnor2_d
Functionally fine, but you reused the module name xnor_d earlier. Duplicate module names in one compile cause redefinition errors. Give this one a unique name. */
module xnor2_d_ref(
    input  wire a,
    input  wire b,
    output wire y
);
assign y = ~(a ^ b);
endmodule

/* Notes: xor_n_d (NOR-only XOR)
Network computes XOR but you don’t drive y. If f is XNOR, your final g inverts it to XOR — connect y=g. Reference below wires the output. */
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

/* Notes: xor2_d
Looks good. No change required. */

/* Notes: and_g
Gate-level AND is correct. No change required. */

/* Notes: mux_g
Implementation is correct but note the selection sense: y = (a & sel) | (b & ~sel) => sel=1 selects a. If you prefer sel=1 selects b (common), use the reference below. */
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

/* Notes: not1_g
Module is named not_d here but it’s in gate-level section; rename to avoid confusion/duplication. */
module not_g_ref(
    input  wire a,
    output wire y
);
not (y, a);
endmodule

/* Notes: or_g
Gate-level OR is correct. No change required. */

/* Notes: triBuffer (gate-level)
Port declaration has a syntax error: "input enable b" isn’t valid. Use a named enable like en. bufif1 takes (out, in, control). */
module triBuffer_ref(
    input  wire a,
    input  wire en,
    output wire y
);
bufif1 (y, a, en);
endmodule

/* Notes: xnor2_from_nand_g
Functional structure is fine, but you named the module xnor_g (duplicated elsewhere) and used five NANDs with final self-NAND to invert. Reference below uses a unique name. */
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
nand (y, s, s); // invert to get XNOR
endmodule

/* Notes: xnor2_from_nor_g
Your 4-NOR implementation is the canonical minimal form. No change required. */

/* Notes: xnor2_g
Primitive instantiation is fine. To avoid name clashes, give the module a unique name. */
module xnor2_g_ref(
    input  wire a,
    input  wire b,
    output wire y
);
xnor (y, a, b);
endmodule

/* Notes: xor2_from_nand_g
This section currently instantiates the XOR primitive and the module is named xnor_g by mistake. For a NAND-only XOR, use the 4-NAND network below with a correct name. */
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

/* Notes: xor2_from_nor_g
Correct 5-NOR implementation (XNOR in 4 NOR + invert). No change required. */

/* Notes: xor2_g
Primitive instantiation is correct. No change required. */

