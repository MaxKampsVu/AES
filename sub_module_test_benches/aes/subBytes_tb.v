`timescale 1ns/1ps

module tb_subBytes();

    reg clk, rst_n;
    reg [127:0] text_in; 
    wire [127:0] text_out;

    // Clock generation
    initial begin
        clk = 1'b0;
        forever #4 clk = ~clk;
    end

    // Instantiate DUT 
    subBytes dut(
        .rst_n(rst_n),
        .text_in(text_in),
        .text_out(text_out)
    );

    // Stimulus
    initial begin
        rst_n = 1'b0;  // Apply reset
        #10 rst_n = 1'b1; // Release reset after 10ns
        
        text_in = 128'h6745D86D118E82A067BB782373D6A853;

        #20; // Wait for output to stabilize

        if (text_out !== 128'h856e613c821913e085eabc268ff6c2ed) begin
            $display("ERROR: text_out is incorrect! Value: %h", text_out);
            $stop;
        end else begin
            $display("SUCCESS");
        end

        $finish;
    end

    initial begin
        $dumpfile("subBytes.vcd");
        $dumpvars(0, tb_subBytes);
    end

endmodule