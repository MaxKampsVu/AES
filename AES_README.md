
### Location of the implementation

The src files for the aes implementation are in `src/aes`. The testbenches for the entire implementation is in the the file: `aes_tb.v`. 

### Generating the wave and output file from the test bench 

The `a.out` file and the `aes.vcd` for the testbench `aes_tb.v` can be generated using the command: 

    iverilog src/aes/addRoundKey.v src/aes/aes.v src/aes/counter.v src/aes/mixColumns.v src/aes/roundKey.v src/aes/shiftRows.v src/aes/subBytes.v aes_tb.v

### Synthesis and estimating the Area of the design 

The area of a NAND2_X1 gate is 0.798000 μm².

The total chip area for the AES design is 13289.626000 μm².

GE = Total Chip Area / NAND2_X1 Area
GE = 13289.626000 μm² / 0.798000 μm²
GE = 16653.67 ≈ 16654 GE

Module breakdown:

- subBytes: 7189.448000 μm² (≈9010 GE)
- roundKey: 2244.774000 μm² (≈2813 GE)
- mixColumns: 969.570000 μm² (≈1215 GE)
- addRoundKey: 204.288000 μm² (≈256 GE)
- shiftRows: 183.008000 μm² (≈229 GE)

The subBytes module consumes the largest portion of the total area (about 54% of the design), because it uses 16 sBoxes implemented as lookup tables. 




