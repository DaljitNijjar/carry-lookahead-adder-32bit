# 32-Bit Carry Lookahead Adder (SystemVerilog)

## Overview
This project implements a **32-bit Carry Lookahead Adder (CLA)** in **SystemVerilog**, designed for high-performance arithmetic by reducing carry propagation delay compared to ripple-carry adders.

The design is **hierarchical**, built from reusable **4-bit CLA blocks**, and includes a self-checking testbench verified using **Vivado simulation**.

This project demonstrates:
- Digital logic design
- Hierarchical RTL design
- Timing-aware adder architecture
- Verification using SystemVerilog testbenches

---

## Architecture
The 32-bit CLA is composed of:
- **Eight 4-bit CLA blocks**
- Group propagate and generate logic
- Parallel carry computation

### Carry Lookahead Principle
Instead of waiting for carries to ripple through each bit, carries are computed in parallel using:
- **Generate:** `G = A & B`
- **Propagate:** `P = A ^ B`
- **Carry:** `C(i+1) = G(i) | (P(i) & C(i))`

This significantly improves speed for wide adders.

---

## File Structure
carry-lookahead-adder-32bit/
├── cla4.sv           # 4-bit carry lookahead adder block
├── cla32.sv          # 32-bit CLA built from 8 × cla4 blocks
├── cla32_tb.sv       # Self-checking testbench
├── README.md
├── LICENSE
└── .gitignore

---

## Module Descriptions

### `cla4.sv`
- Implements a **4-bit carry lookahead adder**
- Computes sum and carry-out using generate/propagate logic
- Reusable building block for larger adders

### `cla32.sv`
- Top-level **32-bit CLA**
- Instantiates eight `cla4` modules
- Computes carries hierarchically
- Outputs:
  - `sum[31:0]`
  - `cout`

### `cla32_tb.sv`
- Self-checking SystemVerilog testbench
- Randomized and directed test vectors
- Automatically detects mismatches
- Designed for use with **Vivado XSIM**

---

## Simulation & Verification
- Simulated using **Vivado 2025.x**
- Testbench verifies:
  - Correct sum output
  - Correct carry-out
  - Random and edge-case inputs
- Waveform inspection confirms parallel carry computation

Example waveform signals:
- `a[31:0]`
- `b[31:0]`
- `cin`
- `sum[31:0]`
- `cout`

---

## Tools Used
- **SystemVerilog**
- **AMD Vivado**
- RTL simulation (XSIM)

---

## Why This Project Matters
This project demonstrates:
- Understanding of **fast arithmetic hardware**
- Clean RTL coding practices
- Hierarchical design methodology
- Hardware verification skills

These skills are directly relevant to:
- FPGA design
- ASIC RTL roles
- Digital design internships
- CPU / accelerator development teams

---

## Possible Extensions
- Parameterized N-bit CLA
- Pipelined CLA
- Carry-select or hybrid adders
- FPGA resource and timing analysis
- Integration into a CPU datapath

---

## Author
**Daljit Nijjar**  
Electrical Engineering — University of Calgary (Schulich School of Engineering)  
SystemVerilog | RTL Design | Basys 3 FPGA
