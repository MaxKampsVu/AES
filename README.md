# AES Hardware Implementation

This project contains a hardware implementation of the AES encryption algorithm, including both a standard design and a side-channel resistant masked S-box version.

## 🔐 Project Overview

- **Standard AES Implementation**: Located in `src/aes/`, this includes all AES core modules and a testbench for simulation and area analysis.
- **Masked S-box Implementation**: Found in `src/masked_sbox/`, this design protects against Differential Power Analysis (DPA) and Correlation Power Analysis (CPA) using 8-share boolean masking.

## 📂 More Information

- 📘 [AES Core README](AES_README.md) – Details on modules, simulation, and synthesis.
- 📘 [Masked S-box README](SBoxProtection_README.md) – Information on the protection technique, masking strategy, and attack model.

---
