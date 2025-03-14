`timescale 1ns/1ps

module tb_shiftRows();

    reg clk, rst_n;
    reg [127:0] text_in;  
    wire [127:0] text_out;

    // Clock generation
    initial begin
        clk = 1'b0;
        forever #4 clk = ~clk;
    end

    // Instantiate DUT 
    shiftRows dut(
        .rst_n(rst_n),
        .text_in(text_in),
        .text_out(text_out)
    );

    // Stimulus
    initial begin
        rst_n = 1'b0;  // Apply reset
        #10 rst_n = 1'b1; // Release reset after 10ns
        
        text_in = 128'h11223344112233441122334411223344;

        #20; // Wait for output to stabilize

        if (text_out !== 128'h44112233334411222233441111223344) begin
            $display("ERROR: text_out is incorrect! Value: %h", text_out);
            $stop;
        end else begin
            $display("SUCCESS");
        end

        $finish;
    end

    initial begin
        $dumpfile("shiftRows.vcd");
        $dumpvars(0, tb_shiftRows);
    end

endmodule