Verilog Practice Codebase (3 Styles + Self‑Checking TB)

This repo is a compact playground to practice Verilog in three coding styles with self‑checking testbenches.

Contents
- src/additions/gate: Primitive/structural (and/or/not, mux2, tri-state)
- src/dataflow: Continuous assignment style
- src/behavioral: always @* procedural style
- tb: One consolidated, self‑checking testbench that sweeps all input combinations
- docs/NOTES.md: Quick notes distilled from your notebook pages
- run_all.ps1: Convenience script to compile/run all tests with Icarus Verilog

Prereqs
- Any Verilog simulator. Examples use Icarus Verilog (iverilog + vvp).

Quick Start (PowerShell)
1) Optional: Install Icarus Verilog and add it to PATH
2) From repo root run:
   `./run_all.ps1`

What you’ll Practice
- Modeling the same logic in 3 styles and cross‑checking equivalence
- High‑Z tri‑state behavior
- Clean, self‑checking testbenches with tiny assert macros

Next Ideas
- Add more blocks (full adder, comparators, encoders/decoders)
- Write random/ranged tests and functional coverage (if using SystemVerilog)
- Try a ring‑oscillator (odd inverters) for simulation only and study Z->X behavior
