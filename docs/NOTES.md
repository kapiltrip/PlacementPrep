Logic Gates and Tri‑State — Interview Notes

- Logic Gate: Combinational element that implements a Boolean function mapping {0,1}^n → {0,1}. Two logic levels: 0 (low), 1 (high).
- Tri‑State Buffer: Output can be 0, 1, or Z (high‑impedance). Control input determines if the input value reaches the output.
  - Enabled: Y = A
  - Disabled: Y = Z (acts like an open circuit)
  - Built‑in primitives: `bufif1`, `bufif0`
- Floating Inputs: Avoid. An unconnected input can pick up noise and lead to undefined logic (X). If an input must be inactive, tie it to a defined 0/1 using a resistor, constant, or pull devices.
- Fan‑Out: Number of gate inputs that one output can drive while remaining within spec. Excessive fan‑out → slow edges, potential logic errors.
- Odd Inversions → Ring Oscillator: A feedback loop with an odd number of NOTs has no stable DC solution and oscillates (simulation ok; not synthesizable as a clock source).
- Algebraic Properties: Commutative (A+B=B+A, A·B=B·A), Associative ((A+B)+C=A+(B+C), (A·B)·C=A·(B·C)). Useful for simplification.
- Impedance Concept: In AC, Z = R + jX; capacitors and inductors affect phase/magnitude. In digital I/O modeling, Z state represents effective “open” (infinite impedance) at the logical level.

Verilog Modeling Styles (for the same logic)
- Gate‑level/Structural: Instantiates primitives (`and`, `or`, `not`, `bufif1`). Good for transistor‑close reasoning and library mapping.
- Dataflow: Uses continuous assignments (assign) expressing Boolean equations directly.
- Behavioral: Uses `always @*` (combinational) or clocked blocks; clearer for complex control/data paths.

Self-Checking Testbench Tips
- Drive all input combinations with small loops; compute expected results in the TB and compare using `===` to catch Z/X.
- Keep a running error counter; end with PASS/FAIL and non-zero exit code.
- Dump a VCD only when needed to keep runs fast.

XOR / XNOR Essentials
- XOR (^) = 1 when inputs differ; XNOR = 1 when inputs are equal.
- Identities: A^A=0, A^0=A, A^1=~A; commutative and associative.
- Multi-input: reduction XOR `^vec` → 1 for odd ones; reduction XNOR `~^vec` (or `^~`) → 1 for even ones.
- Build from universal gates:
  - XOR from NAND (4 NANDs): p=~(A&B); q=~(A&p); r=~(B&p); Y=~(q&r)
  - XOR from NOR  (5 NORs): Ā=~(A+A); B̄=~(B+B); t1=~(A+B̄); t2=~(Ā+B); Y=~~(t1+t2)
  - XNOR via NAND/NOR: invert XOR using self‑NAND/NOR.

Input Bubbling (De Morgan)
- Push inversion bubbles across a gate and swap AND↔OR:
- (Ā·B̄) = ¯(A+B); (Ā+ B̄) = ¯(A·B).
- Applies to NAND/NOR symbols; helpful for quick schematic transforms.
