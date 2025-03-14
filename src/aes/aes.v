/* Main AES encryption module */

module aes(
    input  wire         clk,
    input  wire         rst_n,
    input  wire         valid_in,
    output wire         ready_in,
    input  wire [127:0]  plaintext_in,
    input  wire [127:0] key_in,
    input  wire         ready_out,
    output wire         valid_out,
    output wire [127:0]  ciphertext_out
);


// initial round = 0
// main rounds = 1-9
// final round = 10
reg [3:0] round;

reg ready_in_reg;
reg valid_out_reg;

reg processing; // Used to set wires in the ready valid protocol. While processing = 1, do not accept input or return input 

reg [127:0] roundkey_prev;
wire [127:0] roundkey_cur;


reg [127:0] text_prev;
wire [127:0] text_sub_bytes;
wire [127:0] text_shift_rows;
wire [127:0] text_mix_columns;
wire [127:0] text_add_round_key;

reg [127:0] ciphertext_out_reg;

roundKey rK(
    .round(round),
    .key_in(roundkey_prev),
    .key_out(roundkey_cur)
);


subBytes subB(
    .round(round),
    .text_in(text_prev),
    .text_out(text_sub_bytes)
);

shiftRows shiftR(
    .round(round),
    .text_in(text_sub_bytes),
    .text_out(text_shift_rows)
);

mixColumns mixC(
    .round(round),
    .text_in(text_shift_rows),
    .text_out(text_mix_columns)
);

addRoundKey addRk(
    .roundkey_in(roundkey_cur),
    .text_in(text_mix_columns),
    .text_out(text_add_round_key)
);

// Ready/Valid in protocol


always @ (posedge clk) begin
    if (!rst_n) begin
        round <= 4'b0;
    end 
    else begin 
        // Accept inputs 
        if (valid_in && ready_in) begin
            roundkey_prev <= key_in;
            text_prev <= plaintext_in;
            ready_in_reg <= 1'b0;
            processing <= 1'b1;
        end 
        // Do aes processing 
        else if (processing) begin
            processing <= 1'b1;
            roundkey_prev <= roundkey_cur; 
            
            round <= round + 4'b0001;

            text_prev <= text_add_round_key;

            if (round == 10) begin
                valid_out_reg <= 1'b1;
                ciphertext_out_reg <= text_add_round_key;
                processing <= 1'b0;
            end 
        end 
        // Invalidate output 
        else begin 
            processing <= 1'b0;
            valid_out_reg <= 1'b0;
        end 
    end 
end 


// Ready input logic: AES module is ready when it is not processing data
always @(posedge clk) begin
    if (!rst_n) begin
        ready_in_reg <= 1'b0;
    end
    else begin
        if (!processing) begin
            // The module is ready to accept new input when no valid input is present or ready_out is high
            ready_in_reg <= 1'b1;
        end
        else begin
            ready_in_reg <= 1'b0;
        end
    end
end

// Output assignment
assign valid_out = valid_out_reg;
assign ciphertext_out = ciphertext_out_reg;
assign ready_in = ready_in_reg;

endmodule


