/* Add the roundKey to the cipherstate */

module addRoundKey(
    input  wire [127:0] roundkey_in, 
    input  wire [127:0] text_in,
    output reg  [127:0] text_out
);

integer r, c, i; 

always @ * begin
        text_out = text_in ^ roundkey_in;
end

endmodule