`timescale 1ns / 1ps

module maskedSbox_tb;

    // Testbench signals
    reg [7:0] byte_in;            // Input byte
    reg [7:0] byte_out;           // Output byte 
    reg [7:0] expected_byte_out;  // Expected output byte
    
    // Instantiate the DUT (Device Under Test)
    maskedSbox uut();
    sBox sBox_instance();
    
    // Test vector list
    reg [7:0] test_vectors [0:3];  
    integer i;  
    
    // Stimulus generation
    initial begin
        // Initialize the test vectors
        test_vectors[0] = 8'b11110010;  // Test vector 1
        test_vectors[1] = 8'b00001101;  // Test vector 2
        test_vectors[2] = 8'b10101010;  // Test vector 3
        test_vectors[3] = 8'b01010101;  // Test vector 4
        
        // Loop through each test case
        for (i = 0; i < 4; i = i + 1) begin
            byte_in = test_vectors[i];  // Get the current test vector
            
            // Call the DUT to get the byte_out
            uut.LOOKUP_BYTE(byte_in, byte_out);
            
            // Call the reference sBox for expected output
            sBox_instance.LOOKUP_BYTE(byte_in, expected_byte_out);
            
            // Check if the output matches the expected value
            if (byte_out == expected_byte_out) begin
                $display("Test Passed for byte_in = %b: Expected %b, Got %b", byte_in, expected_byte_out, byte_out);
            end else begin
                $display("Test Failed for byte_in = %b: Expected %b, Got %b", byte_in, expected_byte_out, byte_out);
            end
        end
        
        // Finish the simulation
        #10 $finish;
    end

    initial begin
        $dumpfile("maskedSbox-protected.vcd");
        $dumpvars(0, maskedSbox_tb);
    end
endmodule
