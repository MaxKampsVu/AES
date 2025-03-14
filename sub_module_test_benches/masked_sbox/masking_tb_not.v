`timescale 1ns / 1ps

module masking_tb;

    // Declare testbench variables
    reg [7:0] x;
    reg [6:0][7:0] r_arr_x;
    reg [7:0][7:0] x_shares;
    reg [7:0][7:0] z_shares_out;  // Result of not operation on the shares
    reg [7:0] z_out, recombined_z, expected_x_not;  // Outputs and expected results

    integer i; 

    // Instantiate the DUT (Device Under Test)
    masking uut();

    // Generate random 8-bit values for x, y, and r_arr, and perform tests
    initial begin
        // Initialize x and y with random 8-bit values
        x = 8'b10101010;

        // Generate random values for r_arr (7 random 8-bit values)
        for (i = 0; i < 7; i = i + 1) begin
            r_arr_x[i] = $random % 256;
        end

        uut.create_shares_8(x, r_arr_x, x_shares);  // Create shares for x

        uut.masked_not_8(z_shares_out, x_shares);

        uut.recombine_shares_8(z_shares_out, z_out);
        expected_x_not = ~x;  // Compute the expected value of not x 

        // Display all values
        #1;  // Wait for results to settle
        $display("x = %b", x);
        $display("Shares of x:");
        for (i = 0; i < 8; i = i + 1) begin
            $display("x_shares[%0d] = %b", i, x_shares[i]);
        end

        $display("Masked XOR Result (z_shares_out):");
        for (i = 0; i < 8; i = i + 1) begin
            $display("z_shares_out[%0d] = %b", i, z_shares_out[i]);
        end

        $display("Recombined z_out: %b", z_out);
        $display("Expected not x : %b", expected_x_not);

        // Compare recombined value with expected value
        if (z_out == expected_x_not) begin
            $display("Test Passed: z_out matches not x.");
        end else begin
            $display("Test Failed: z_out does not match not x.");
        end

        // End simulation
        #10 $finish;
    end

endmodule
