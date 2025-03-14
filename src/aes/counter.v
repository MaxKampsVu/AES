/* 4-bit counter used to keep track of the AES rounds */

module counter(
    input  wire clk,
    input  wire rst_n,
    input  wire start,
    input  wire stop,
    output wire [3:0] count
);

reg state;
reg [3:0] val;

always @ (posedge clk) begin
    if (!rst_n || stop)
        state <= 1'b0;
    else if (start)
        state <= 1'b1;
end

always @ (posedge clk) begin
    if (!rst_n)
        val <= 4'b0;
    else if (state == 1'b1)
        val <= val + 4'b1;
end
          
assign count = val;

endmodule