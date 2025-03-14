module masking;

integer r;
integer d;

// creates 8 shares for an 8-bit value x 
task create_shares_8(
    input  [7:0] x, 
    input  [6:0][7:0] r_arr, 
    output reg [7:0][7:0] x_shares_out
);  
    begin
        // Assign shared d0 = r0, ..., d6 = r6
        for (r = 0; r < 7; r = r + 1) begin
            x_shares_out[r] = r_arr[r];
        end 
        // Assign share d7 = r0 ^ ... ^ r6 ^ x
        x_shares_out[7] = r_arr[0] ^ r_arr[1] ^ r_arr[2] ^ r_arr[3] ^ r_arr[4] ^ r_arr[5] ^ r_arr[6] ^ x;
    end
endtask

// recombines 8 shares for an 8-bit value x 
task recombine_shares_8(
    input  [7:0][7:0] x_shares_in, 
    output reg [7:0] x_out
);  
    begin
        // Recombine the shares by xoring them together 
        x_out = x_shares_in[0] ^ 
                x_shares_in[1] ^ 
                x_shares_in[2] ^ 
                x_shares_in[3] ^ 
                x_shares_in[4] ^ 
                x_shares_in[5] ^ 
                x_shares_in[6] ^ 
                x_shares_in[7];
    end
endtask

// masked xor on 8 shares for a 8-bit values x and y 
task masked_xor_8(
    output reg [7:0][7:0] z_shares_out,
    input  [7:0][7:0] x_shares_in, 
    input  [7:0][7:0] y_shares_in
);
    begin
        for (d = 0; d < 8; d = d + 1) begin
            z_shares_out[d] = x_shares_in[d] ^ y_shares_in[d];
        end
    end
endtask

// masked not on 8 shares for an 8-bit value
task masked_not_8(
    output reg [7:0][7:0] not_x_shares_out,
    input  [7:0][7:0]     x_shares_in
);
    begin
        // Negate the first share 
        not_x_shares_out[0] = ~x_shares_in;
        // Leave all other shares unchanged 
        for (d = 1; d < 8; d = d + 1) begin
            not_x_shares_out[d] = x_shares_in[d];
        end
    end
endtask

// masked ISW and on 8 shares for a 8-bit values x and y (requires 7 7-bit random values r_0, ..., r_6)
task masked_isw_and_8(
    output reg [7:0][7:0] z_out,
    input  [7:0][7:0]     x_in, 
    input  [7:0][7:0]     y_in, 
    input  [6:0]          r_0, 
    input  [6:0]          r_1, 
    input  [6:0]          r_2, 
    input  [6:0]          r_3, 
    input  [6:0]          r_4, 
    input  [6:0]          r_5, 
    input  [6:0]          r_6
);  
    begin
        // Compute the ISW AND for every share z_0, ..., z_7
        z_out[0] =  x_in[0] & y_in[0] ^
                    r_0[0] ^ 
                    r_0[1] ^ 
                    r_0[2] ^ 
                    r_0[3] ^ 
                    r_0[4] ^ 
                    r_0[5] ^ 
                    r_0[6];

        z_out[1] =  x_in[1] & y_in[1] ^ 
                    ((r_0[0] ^ x_in[0] & y_in[1]) ^ x_in[1] & y_in[0]) ^
                    r_1[1] ^ 
                    r_1[2] ^ 
                    r_1[3] ^ 
                    r_1[4] ^ 
                    r_1[5] ^ 
                    r_1[6];

        z_out[2] =  x_in[2] & y_in[2] ^ 
                    ((r_0[1] ^ x_in[0] & y_in[2]) ^ x_in[2] & y_in[0]) ^
                    ((r_1[1] ^ x_in[1] & y_in[2]) ^ x_in[2] & y_in[1]) ^ 
                    r_2[2] ^ 
                    r_2[3] ^ 
                    r_2[4] ^ 
                    r_2[5] ^ 
                    r_2[6];

        z_out[3] =  x_in[3] & y_in[3] ^ 
                    ((r_0[2] ^ x_in[0] & y_in[3]) ^ x_in[3] & y_in[0]) ^
                    ((r_1[2] ^ x_in[1] & y_in[3]) ^ x_in[3] & y_in[1]) ^ 
                    ((r_2[2] ^ x_in[2] & y_in[3]) ^ x_in[3] & y_in[2]) ^ 
                    r_3[3] ^ 
                    r_3[4] ^ 
                    r_3[5] ^ 
                    r_3[6];

        
        z_out[4] =  x_in[4] & y_in[4] ^ 
                    ((r_0[3] ^ x_in[0] & y_in[4]) ^ x_in[4] & y_in[0]) ^
                    ((r_1[3] ^ x_in[1] & y_in[4]) ^ x_in[4] & y_in[1]) ^ 
                    ((r_2[3] ^ x_in[2] & y_in[4]) ^ x_in[4] & y_in[2]) ^ 
                    ((r_3[3] ^ x_in[3] & y_in[4]) ^ x_in[4] & y_in[3]) ^ 
                    r_4[4] ^ 
                    r_4[5] ^ 
                    r_4[6];

        z_out[5] =  x_in[5] & y_in[5] ^ 
                    ((r_0[4] ^ x_in[0] & y_in[5]) ^ x_in[5] & y_in[0]) ^
                    ((r_1[4] ^ x_in[1] & y_in[5]) ^ x_in[5] & y_in[1]) ^ 
                    ((r_2[4] ^ x_in[2] & y_in[5]) ^ x_in[5] & y_in[2]) ^ 
                    ((r_3[4] ^ x_in[3] & y_in[5]) ^ x_in[5] & y_in[3]) ^ 
                    ((r_4[4] ^ x_in[4] & y_in[5]) ^ x_in[5] & y_in[4]) ^  
                    r_5[5] ^ 
                    r_5[6];

        z_out[6] =  x_in[6] & y_in[6] ^ 
                    ((r_0[5] ^ x_in[0] & y_in[6]) ^ x_in[6] & y_in[0]) ^
                    ((r_1[5] ^ x_in[1] & y_in[6]) ^ x_in[6] & y_in[1]) ^ 
                    ((r_2[5] ^ x_in[2] & y_in[6]) ^ x_in[6] & y_in[2]) ^ 
                    ((r_3[5] ^ x_in[3] & y_in[6]) ^ x_in[6] & y_in[3]) ^ 
                    ((r_4[5] ^ x_in[4] & y_in[6]) ^ x_in[6] & y_in[4]) ^  
                    ((r_5[5] ^ x_in[5] & y_in[6]) ^ x_in[6] & y_in[5]) ^  
                    r_6[6];


        z_out[7] =  x_in[7] & y_in[7] ^ 
                    ((r_0[6] ^ x_in[0] & y_in[7]) ^ x_in[7] & y_in[0]) ^ 
                    ((r_1[6] ^ x_in[1] & y_in[7]) ^ x_in[7] & y_in[1]) ^ 
                    ((r_2[6] ^ x_in[2] & y_in[7]) ^ x_in[7] & y_in[2]) ^ 
                    ((r_3[6] ^ x_in[3] & y_in[7]) ^ x_in[7] & y_in[3]) ^ 
                    ((r_4[6] ^ x_in[4] & y_in[7]) ^ x_in[7] & y_in[4]) ^ 
                    ((r_5[6] ^ x_in[5] & y_in[7]) ^ x_in[7] & y_in[5]) ^ 
                    ((r_6[6] ^ x_in[6] & y_in[7]) ^ x_in[7] & y_in[6]);
    end
endtask

endmodule
