`timescale 1ns/1ps

module tb_mixColumns();

    reg clk, rst_n;
    reg [127:0] text_in; 
    wire [127:0] text_out;
    reg[3:0] round;

    // Clock generation
    initial begin
        clk = 1'b0;
        forever #4 clk = ~clk;
    end

    // Instantiate DUT 
    mixColumns dut(
        .round(round),
        .text_in(text_in),
        .text_out(text_out)
    );

    // Stimulus
    initial begin
        rst_n = 1'b0;  // Apply reset
        #10 rst_n = 1'b1; // Release reset after 10ns
        
        round = 4'd2;
        text_in = 128'heabc2a099769808101d6c915c3980f3b;

        #20; // Wait for output to stabilize

        if (text_out !== 128'h6b85d3f040adbb828ad89131cdc42cb3) begin
            $display("ERROR: text_out is incorrect! Value: %h", text_out);
            $stop;
        end else begin
            $display("SUCCESS");
        end

        $finish;
    end

    initial begin
        $dumpfile("mixColumns.vcd");
        $dumpvars(0, tb_mixColumns);
    end

endmodule