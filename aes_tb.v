`timescale 1ns/1ps

module tb_aes();
    reg clk, rst_n;
    reg valid_in;
    wire ready_in;
    reg ready_out;
    wire valid_out;
    reg [127:0] key_in;
    reg [127:0] text_in; 
    wire [127:0] text_out;
    reg [127:0] text_out_expected;
    
    integer test_case;
    reg [127:0] test_inputs [0:2][0:2]; // [test_case][0:plaintext, 1:key, 2:expected_output]

    // Clock generation
    initial begin
        clk = 1'b0;
        forever #4 clk = ~clk;
    end

    // Instantiate DUT 
    aes dut(
        .clk(clk),
        .rst_n(rst_n),
        .valid_in(valid_in),
        .ready_in(ready_in),
        .plaintext_in(text_in),
        .key_in(key_in),
        .ready_out(ready_out),
        .valid_out(valid_out),
        .ciphertext_out(text_out)
    );

    // Stimulus
    initial begin
        // Initialize test cases
        // Test case 1
        test_inputs[0][0] = 128'hD50F91ECB37BF79A804BB6BC3FBF8C63; // plaintext
        test_inputs[0][1] = 128'hF0F34A2B53422D415F4BDC952E15EADA; // key
        test_inputs[0][2] = 128'ha4e1183ba88abbeff971415195c0b975; // expected output
        
        // Test case 2
        test_inputs[1][0] = 128'h23216D96FE77AC6771DAD1F66C5C595D; // plaintext
        test_inputs[1][1] = 128'h14367CFBF6A3F8DE3716ECAAB0D02FEF; // key
        test_inputs[1][2] = 128'h9793d5b514c8771736f6fbf7b6b0dc67; // expected output
        
        // Test case 3
        test_inputs[2][0] = 128'h68F59AFD7D4E254ADEF48016113A2CC9; // plaintext
        test_inputs[2][1] = 128'hB1A231EC2C908683129C3B3ABD2906BE; // key
        test_inputs[2][2] = 128'hf613d062033dfb45e9cf002fd22d7f22; // expected output

        // Initialize signals
        rst_n = 1'b0;
        valid_in = 1'b0;
        ready_out = 1'b1;
        
        // Apply reset
        #10 rst_n = 1'b1; // Release reset after 10ns
        #20; // Wait for reset to settle
        
        for (test_case = 0; test_case < 3; test_case = test_case + 1) begin
            // Apply stimulus for current test case
            text_in = test_inputs[test_case][0];
            key_in = test_inputs[test_case][1];
            text_out_expected = test_inputs[test_case][2];
            
            // Wait until the module is ready to accept input
            wait(ready_in == 1'b1);
            
            // Start the input transfer
            valid_in = 1'b1; // Indicate input data is valid
            
            // Wait until ready_in goes low, indicating input was accepted
            wait(ready_in == 1'b0);
            
            // De-assert valid_in after input is accepted
            valid_in = 1'b0;
            
            // Wait for AES module to finish processing and assert valid_out
            wait(valid_out == 1'b1);
            
            // Assertion: Check if text_out is as expected
            if (text_out !== text_out_expected) begin
                $display("ERROR: Test case %0d failed! Expected: %h, Got: %h", 
                         test_case+1, text_out_expected, text_out);
            end else begin
                $display("SUCCESS: Test case %0d passed! Value: %h", 
                         test_case+1, text_out);
            end
            
            // Complete the output handshake
            ready_out = 1'b1;
            
            // Wait for valid_out to be de-asserted
            wait(valid_out == 1'b0);
            
            // Reset for next test case
            ready_out = 1'b1;
            
            // Add a full reset between test cases to ensure clean state
            rst_n = 1'b0;
            #10;
            rst_n = 1'b1;
            #20;
        end
        
        $display("All tests completed!");
        $finish;
    end
    
    initial begin
        $dumpfile("aes.vcd");
        $dumpvars(0, tb_aes);
    end

endmodule
