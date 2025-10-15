# Combinational Circuits — Folder 2 / Part 1 Build Notes

## Implemented Modules

### Part 1 (Fundamentals)
- 3-input majority and minority detectors.
- Half adder and half subtractor blocks.
- Full adder (direct propagate/generate) and full adder built from half adders.
- XOR implementation using only NAND gates.
- Invalid BCD (10–15) detector and the active-low automobile alarm logic.

### Part 2 (Adder Architecture Extensions)
- Full subtractor (direct and half-subtractor composition).
- Parameterisable ripple-carry adder and two's-complement adder/subtractor.
- Four-bit carry look-ahead adder and a sequential serial adder model.

### Part 4 (Code Converters & Checkers)
- Binary→BCD digit converter with invalid flag.
- BCD→Excess-3 code converter.
- Generic magnitude comparator.
- Parity generator/checker pair configurable for even or odd parity.

## Future Improvements
- Provide dedicated testbenches for each module to exercise edge cases and demonstrate usage.
- Expand converters to multi-digit pipelines (e.g., full binary→BCD double dabble implementation).
- Offer parameterised majority/minority detectors that scale beyond three inputs via generate blocks.
- Add gate-level only variants (NAND/NOR exclusive) for the comparator and converters to mirror lecture emphasis on universal gates.
- Document typical propagation delay assumptions for each architecture to complement the provided RTL.
