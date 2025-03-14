/* Bitsliced masked AES sbox as per Boyar and Peralta
    Based on C code for bitsliced sbox from: 
    https://gist.github.com/oreparaz/939f83695aab0e3ca0a0
    And the Boyar and Peralta Sbox: 
    https://eprint.iacr.org/2011/332.pdf
*/
module maskedSbox;

masking m_i();

// Shares for masking 
reg [7:0][7:0] byte_shares_in, byte_shares_out;
// Temporary registers for bit-slicing operations
reg [7:0][7:0] U0,U1,U2,U3,U4,U5,U6,U7;
reg [7:0][7:0] T1,T2,T3,T4,T5,T6,T7,T8,T9,T10,T11,T12,T13,T14,T15,T16,T17,T18,T19,T20,T21,T22,T23,T24,T25,T26,T27;
reg [7:0][7:0] M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12,M13,M14,M15,M16,M17,M18,M19,M20,M21,M22,M23,M24,M25,M26,M27,M28,M29,M30,M31,M32,M33,M34,M35,M36,M37,M38,M39,M40,M41,M42,M43,M44,M45,M46,M47,M48,M49,M50,M51,M52,M53,M54,M55,M56,M57,M58,M59,M60,M61,M62,M63;
reg [7:0][7:0] L0,L1,L2,L3,L4,L5,L6,L7,L8,L9,L10,L11,L12,L13,L14,L15,L16,L17,L18,L19,L20,L21,L22,L23,L24,L25,L26,L27,L28,L29;
reg [7:0][7:0] S0,S1,S2,S3,S4,S5,S6,S7;
reg [7:0][7:0] NS1,NS2,NS6,NS7;

// Random values for share generation and ands -> WARNING: This is not secure, has to be replaced with a TRNG
reg [6:0][7:0] r_shares;
// WARNING: Reusing random values for all ANDs introduced recombinations 
reg [7:0] r0_and, r1_and, r2_and, r3_and, r4_and, r5_and, r6_and;
// For the sake of simplicity, random numbers are reused nonetheless

integer i;

task LOOKUP_BYTE(
    input[7:0] byte_in, 
    output reg [7:0] byte_out
);
    begin
        //Assign random numbers
        r_shares[0] = 8'b10000010;
        r_shares[1] = 8'b00111011;
        r_shares[2] = 8'b01100111;
        r_shares[3] = 8'b00110011;
        r_shares[4] = 8'b10111100;
        r_shares[5] = 8'b10011110;
        r_shares[6] = 8'b10000111;
        r0_and = 8'b00001100;
        r1_and = 8'b11110100;
        r2_and = 8'b01101010;
        r3_and = 8'b10010000;
        r4_and = 8'b10001111;
        r5_and = 8'b01010101;
        r6_and = 8'b01101110;
        

        // Create shares from input byte
        m_i.create_shares_8(byte_in, r_shares, byte_shares_in);
        
        // Create bit slices for every share
        // Note: Bit order was reversed in C-implentation
        for (i = 0; i < 8; i = i + 1) begin 
            U0[i] = (byte_shares_in[i] >> 7) & 1;
            U1[i] = (byte_shares_in[i] >> 6) & 1;
            U2[i] = (byte_shares_in[i] >> 5) & 1;
            U3[i] = (byte_shares_in[i] >> 4) & 1;
            U4[i] = (byte_shares_in[i] >> 3) & 1;
            U5[i] = (byte_shares_in[i] >> 2) & 1;
            U6[i] = (byte_shares_in[i] >> 1) & 1;
            U7[i] = (byte_shares_in[i] >> 0) & 1;
        end


        // Compute the lookup
        m_i.masked_xor_8(T1,U0,U3);
        m_i.masked_xor_8(T2,U0,U5);
        m_i.masked_xor_8(T3,U0,U6);
        m_i.masked_xor_8(T4,U3,U5);
        m_i.masked_xor_8(T5,U4,U6);
        m_i.masked_xor_8(T6,T1,T5);
        m_i.masked_xor_8(T7,U1,U2);
        m_i.masked_xor_8(T8,U7,T6);
        m_i.masked_xor_8(T9,U7,T7);
        m_i.masked_xor_8(T10,T6,T7);
        m_i.masked_xor_8(T11,U1,U5);
        m_i.masked_xor_8(T12,U2,U5);
        m_i.masked_xor_8(T13,T3,T4);
        m_i.masked_xor_8(T14,T6,T11);
        m_i.masked_xor_8(T15,T5,T11);
        m_i.masked_xor_8(T16,T5,T12);
        m_i.masked_xor_8(T17,T9,T16);
        m_i.masked_xor_8(T18,U3,U7);
        m_i.masked_xor_8(T19,T7,T18);
        m_i.masked_xor_8(T20,T1,T19);
        m_i.masked_xor_8(T21,U6,U7);
        m_i.masked_xor_8(T22,T7,T21);
        m_i.masked_xor_8(T23,T2,T22);
        m_i.masked_xor_8(T24,T2,T10);
        m_i.masked_xor_8(T25,T20,T17);
        m_i.masked_xor_8(T26,T3,T16);
        m_i.masked_xor_8(T27,T1,T12);

        m_i.masked_isw_and_8(M1,T13,T6,r0_and,r1_and,r2_and,r3_and,r4_and,r5_and,r6_and);
        m_i.masked_isw_and_8(M2,T23,T8,r0_and,r1_and,r2_and,r3_and,r4_and,r5_and,r6_and);
        m_i.masked_xor_8(M3,T14,M1);
        m_i.masked_isw_and_8(M4,T19,U7,r0_and,r1_and,r2_and,r3_and,r4_and,r5_and,r6_and);
        m_i.masked_xor_8(M5,M4,M1);
        m_i.masked_isw_and_8(M6,T3,T16,r0_and,r1_and,r2_and,r3_and,r4_and,r5_and,r6_and);
        m_i.masked_isw_and_8(M7,T22,T9,r0_and,r1_and,r2_and,r3_and,r4_and,r5_and,r6_and);
        m_i.masked_xor_8(M8,T26,M6);
        m_i.masked_isw_and_8(M9,T20,T17,r0_and,r1_and,r2_and,r3_and,r4_and,r5_and,r6_and);
        m_i.masked_xor_8(M10,M9,M6);
        m_i.masked_isw_and_8(M11,T1,T15,r0_and,r1_and,r2_and,r3_and,r4_and,r5_and,r6_and);
        m_i.masked_isw_and_8(M12,T4,T27,r0_and,r1_and,r2_and,r3_and,r4_and,r5_and,r6_and);
        m_i.masked_xor_8(M13,M12,M11);
        m_i.masked_isw_and_8(M14,T2,T10,r0_and,r1_and,r2_and,r3_and,r4_and,r5_and,r6_and);
        m_i.masked_xor_8(M15,M14,M11);
        m_i.masked_xor_8(M16,M3,M2);
        m_i.masked_xor_8(M17,M5,T24);
        m_i.masked_xor_8(M18,M8,M7);
        m_i.masked_xor_8(M19,M10,M15);
        m_i.masked_xor_8(M20,M16,M13);
        m_i.masked_xor_8(M21,M17,M15);
        m_i.masked_xor_8(M22,M18,M13);
        m_i.masked_xor_8(M23,M19,T25);
        m_i.masked_xor_8(M24,M22,M23);
        m_i.masked_isw_and_8(M25,M22,M20,r0_and,r1_and,r2_and,r3_and,r4_and,r5_and,r6_and);
        m_i.masked_xor_8(M26,M21,M25);
        m_i.masked_xor_8(M27,M20,M21);
        m_i.masked_xor_8(M28,M23,M25);
        m_i.masked_isw_and_8(M29,M28,M27,r0_and,r1_and,r2_and,r3_and,r4_and,r5_and,r6_and);
        m_i.masked_isw_and_8(M30,M26,M24,r0_and,r1_and,r2_and,r3_and,r4_and,r5_and,r6_and);
        m_i.masked_isw_and_8(M31,M20,M23,r0_and,r1_and,r2_and,r3_and,r4_and,r5_and,r6_and);
        m_i.masked_isw_and_8(M32,M27,M31,r0_and,r1_and,r2_and,r3_and,r4_and,r5_and,r6_and);
        m_i.masked_xor_8(M33,M27,M25);
        m_i.masked_isw_and_8(M34,M21,M22,r0_and,r1_and,r2_and,r3_and,r4_and,r5_and,r6_and);
        m_i.masked_isw_and_8(M35,M24,M34,r0_and,r1_and,r2_and,r3_and,r4_and,r5_and,r6_and);
        m_i.masked_xor_8(M36,M24,M25);
        m_i.masked_xor_8(M37,M21,M29);
        m_i.masked_xor_8(M38,M32,M33);
        m_i.masked_xor_8(M39,M23,M30);
        m_i.masked_xor_8(M40,M35,M36);
        m_i.masked_xor_8(M41,M38,M40);
        m_i.masked_xor_8(M42,M37,M39);
        m_i.masked_xor_8(M43,M37,M38);
        m_i.masked_xor_8(M44,M39,M40);
        m_i.masked_xor_8(M45,M42,M41);
        m_i.masked_isw_and_8(M46,M44,T6,r0_and,r1_and,r2_and,r3_and,r4_and,r5_and,r6_and);
        m_i.masked_isw_and_8(M47,M40,T8,r0_and,r1_and,r2_and,r3_and,r4_and,r5_and,r6_and);
        m_i.masked_isw_and_8(M48,M39,U7,r0_and,r1_and,r2_and,r3_and,r4_and,r5_and,r6_and);
        m_i.masked_isw_and_8(M49,M43,T16,r0_and,r1_and,r2_and,r3_and,r4_and,r5_and,r6_and);
        m_i.masked_isw_and_8(M50,M38,T9,r0_and,r1_and,r2_and,r3_and,r4_and,r5_and,r6_and);
        m_i.masked_isw_and_8(M51,M37,T17,r0_and,r1_and,r2_and,r3_and,r4_and,r5_and,r6_and);
        m_i.masked_isw_and_8(M52,M42,T15,r0_and,r1_and,r2_and,r3_and,r4_and,r5_and,r6_and);
        m_i.masked_isw_and_8(M53,M45,T27,r0_and,r1_and,r2_and,r3_and,r4_and,r5_and,r6_and);
        m_i.masked_isw_and_8(M54,M41,T10,r0_and,r1_and,r2_and,r3_and,r4_and,r5_and,r6_and);
        m_i.masked_isw_and_8(M55,M44,T13,r0_and,r1_and,r2_and,r3_and,r4_and,r5_and,r6_and);
        m_i.masked_isw_and_8(M56,M40,T23,r0_and,r1_and,r2_and,r3_and,r4_and,r5_and,r6_and);
        m_i.masked_isw_and_8(M57,M39,T19,r0_and,r1_and,r2_and,r3_and,r4_and,r5_and,r6_and);
        m_i.masked_isw_and_8(M58,M43,T3,r0_and,r1_and,r2_and,r3_and,r4_and,r5_and,r6_and);
        m_i.masked_isw_and_8(M59,M38,T22,r0_and,r1_and,r2_and,r3_and,r4_and,r5_and,r6_and);
        m_i.masked_isw_and_8(M60,M37,T20,r0_and,r1_and,r2_and,r3_and,r4_and,r5_and,r6_and);
        m_i.masked_isw_and_8(M61,M42,T1,r0_and,r1_and,r2_and,r3_and,r4_and,r5_and,r6_and);
        m_i.masked_isw_and_8(M62,M45,T4,r0_and,r1_and,r2_and,r3_and,r4_and,r5_and,r6_and);
        m_i.masked_isw_and_8(M63,M41,T2,r0_and,r1_and,r2_and,r3_and,r4_and,r5_and,r6_and);

        m_i.masked_xor_8(L0,M61,M62);
        m_i.masked_xor_8(L1,M50,M56);
        m_i.masked_xor_8(L2,M46,M48);
        m_i.masked_xor_8(L3,M47,M55);
        m_i.masked_xor_8(L4,M54,M58);
        m_i.masked_xor_8(L5,M49,M61);
        m_i.masked_xor_8(L6,M62,L5);
        m_i.masked_xor_8(L7,M46,L3);
        m_i.masked_xor_8(L8,M51,M59);
        m_i.masked_xor_8(L9,M52,M53);
        m_i.masked_xor_8(L10,M53,L4);
        m_i.masked_xor_8(L11,M60,L2);
        m_i.masked_xor_8(L12,M48,M51);
        m_i.masked_xor_8(L13,M50,L0);
        m_i.masked_xor_8(L14,M52,M61);
        m_i.masked_xor_8(L15,M55,L1);
        m_i.masked_xor_8(L16,M56,L0);
        m_i.masked_xor_8(L17,M57,L1);
        m_i.masked_xor_8(L18,M58,L8);
        m_i.masked_xor_8(L19,M63,L4);
        m_i.masked_xor_8(L20,L0,L1);
        m_i.masked_xor_8(L21,L1,L7);
        m_i.masked_xor_8(L22,L3,L12);
        m_i.masked_xor_8(L23,L18,L2);
        m_i.masked_xor_8(L24,L15,L9);
        m_i.masked_xor_8(L25,L6,L10);
        m_i.masked_xor_8(L26,L7,L9);
        m_i.masked_xor_8(L27,L8,L10);
        m_i.masked_xor_8(L28,L11,L14);
        m_i.masked_xor_8(L29,L11,L17);

        m_i.masked_xor_8(S0,L6,L24);
        m_i.masked_xor_8(S1,L16,L26);
        m_i.masked_xor_8(S2,L19,L28);
        m_i.masked_xor_8(S3,L6,L21);
        m_i.masked_xor_8(S4,L20,L22);
        m_i.masked_xor_8(S5,L25,L29);
        m_i.masked_xor_8(S6,L13,L27);
        m_i.masked_xor_8(S7,L6,L23);

        m_i.masked_not_8(NS1, S1);
        m_i.masked_not_8(NS2, S2);
        m_i.masked_not_8(NS6, S6);
        m_i.masked_not_8(NS7, S7);
        
        // Recombine bitslices in individual shares 
        for (i = 0; i < 8; i = i + 1) begin 
            byte_shares_out[i] = ((S0[i]  & 1) << 7) ^
                                 ((NS1[i] & 1) << 6) ^
                                 ((NS2[i] & 1) << 5) ^ 
                                 ((S3[i]  & 1) << 4) ^
                                 ((S4[i]  & 1) << 3) ^ 
                                 ((S5[i]  & 1) << 2) ^ 
                                 ((NS6[i] & 1) << 1) ^ 
                                 ((NS7[i] & 1) << 0);
        end 

        // Recombine the shares 
        m_i.recombine_shares_8(byte_shares_out, byte_out);
    end
endtask

endmodule