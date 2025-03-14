`timescale 1ns / 1ps

module masking_tb;

    // Declare testbench variables
    reg [7:0] x, y;  // The 8-bit values for x and y
    reg [6:0][7:0] r_arr_x, r_arr_y;  // Array of 7 random 8-bit values for the shares
    reg [7:0][7:0] x_shares, y_shares;  // Shares for x and y 
    reg [7:0][7:0] z_shares_out;  // Result of XOR operation on shares
    reg [7:0] z_out, recombined_z, expected_x_xor_y;  // Outputs and expected results

    integer i;  

    // Instantiate the DUT (Device Under Test)
    masking uut();

    // Generate random 8-bit values for x, y, and r_arr, and perform tests
    initial begin
        // Initialize x and y with random 8-bit values
        x = 8'b10101010;
        y = 8'b11110000;

        // Generate random values for r_arr_x (7 random 8-bit values)
        for (i = 0; i < 7; i = i + 1) begin
            r_arr_x[i] = $random % 256;
        end

        // Generate random values for r_arr_y (7 random 8-bit values)
        for (i = 0; i < 7; i = i + 1) begin
            r_arr_y[i] = $random % 256;
        end

        // Call the create_shares_8 task for x and y
        uut.create_shares_8(x, r_arr_x, x_shares);  // Create shares for x
        uut.create_shares_8(y, r_arr_y, y_shares);  // Create shares for y

        // Perform masked XOR operation on shares
        uut.masked_xor_8(z_shares_out, x_shares, y_shares);

        // Recombine the shares for z and compare to the expected x XOR y
        uut.recombine_shares_8(z_shares_out, z_out);
        expected_x_xor_y = x ^ y;  // Compute the expected value of x XOR y

        // Display all values
        #1;  // Wait for results to settle
        $display("x = %b, y = %b", x, y);
        $display("Shares of x:");
        for (i = 0; i < 8; i = i + 1) begin
            $display("x_shares[%0d] = %b", i, x_shares[i]);
        end
        
        $display("Shares of y:");
        for (i = 0; i < 8; i = i + 1) begin
            $display("y_shares[%0d] = %b", i, y_shares[i]);
        end

        $display("Masked XOR Result (z_shares_out):");
        for (i = 0; i < 8; i = i + 1) begin
            $display("z_shares_out[%0d] = %b", i, z_shares_out[i]);
        end

        $display("Recombined z_out: %b", z_out);
        $display("Expected x XOR y: %b", expected_x_xor_y);

        // Compare recombined value with expected value
        if (z_out == expected_x_xor_y) begin
            $display("Test Passed: z_out matches x XOR y.");
        end else begin
            $display("Test Failed: z_out does not match x XOR y.");
        end

        // End simulation
        #10 $finish;
    end

endmodule
