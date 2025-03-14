# Protection of the implementation

## Overview

This project implements a **bitsliced AES S-box** with **8-share boolean masking** to protect against **side-channel attacks** such as **Differential Power Analysis (DPA)** and **Correlation Power Analysis (CPA)**.

## Generating the wave and output file from the test bench
The src files for the aes implementation are in `src/masked_sbox`. The testbenches for the entire implementation is in the the file: `maskedSbox-protected_tb.v`. 

The `a.out` file and the `maskedSbox-protected.vcd` for the testbench `maskedSbox-protected_tb.v` can be generated using the command: 

    iverilog src/masked_sbox/masking.v src/masked_sbox/maskedSbox-protected.v src/masked_sbox/sBox.v maskedSbox-protected_tb.v

## Attack Model

The attack model assumes an attacker can measure power traces of the AES operations and extract secret key information by analyzing intermediate values. **DPA** and **CPA** are the primary attacks considered, targeting vulnerable points in the AES S-box computation.

## Technique

To thwart these attacks, **boolean masking** of the sBox is used. 


## Implementation

Each input byte to the AES S-box is split into 8 shares at the beginning of the sBox lookup. 

The lookup is performed with a **bitsliced** AES S-box (using the Boyar and Peralta Sbox https://eprint.iacr.org/2011/332.pdf), where each byte is processed bit by bit.  

All AND, NOT, XOR operations in the S-box have been replaced by masked counterparts, where for the AND operation the ISW method is used. The bitsliced sBox is based on the C code from https://gist.github.com/oreparaz/939f83695aab0e3ca0a0. At the end of the lookup the shares are recombined.  

*Note*: For the spitting of shares and the ISW ANDs random numbers are required. For the sake of simplicity these habe been predefined. Moreover, the same random numbers have been used for all AND operations (again to keep it simple). This is insecure, because it leads to recombinations of operations, leaking side channel information. In a secure implementation, we would require a True-Random-Number generator, generating unique values in every round of the cipher for every operation (that requires random numbers). 





    