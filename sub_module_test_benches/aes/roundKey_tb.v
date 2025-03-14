`timescale 1ns/1ps

module tb_roundKey();

    reg clk, rst_n;
    reg [3:0] round;
    reg [127:0] key_in;  
    wire [127:0] key_out;

    // Clock generation
    initial begin
        clk = 1'b0;
        forever #4 clk = ~clk;
    end

    // Instantiate DUT (Fixed missing commas)
    roundKey dut(
        .round(round),
        .key_in(key_in),
        .key_out(key_out)
    );

    // Stimulus
    initial begin
        rst_n = 1'b0;  // Apply reset
        #10 rst_n = 1'b1; // Release reset after 10ns
        
        key_in = 128'h3d80477d4716fe3e1e237e446d7a883b;

        round = 4'd4;

        #20; // Wait for output to stabilize

        if (key_out !== 128'ha0fafe1788542cb123a339392a6c7605) begin
            $display("ERROR: key_out is incorrect! Value: %h", key_out);
            $stop;
        end else begin
            $display("SUCCESS");
        end

        $finish;
    end

    initial begin
        $dumpfile("roundKey.vcd");
        $dumpvars(0, tb_roundKey);
    end

endmodule