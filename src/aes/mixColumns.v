/* Mix columns operation */

module mixColumns(
    input  wire [3:0]   round,
    input  wire [127:0] text_in,
    output reg [127:0]  text_out
);

integer r, c; 


function [7:0] mb2; //multiply by 2
	input [7:0] x;
	begin 
			if(x[7] == 1) mb2 = ((x << 1) ^ 8'h1b);
			else mb2 = x << 1; 
	end 	
endfunction


function [7:0] mb3; //multiply by 3
	input [7:0] x;
	begin 
			
			mb3 = mb2(x) ^ x;
	end 
endfunction

always @ * begin
    // Only apply the operation in the round 1-9
    if (round > 0 && round < 10) begin
        // Iterate over columns c
        for (c = 0; c < 128; c = c + 32) begin 
            // Compute first cell in column
            text_out[c + 0 +: 8] =  mb3(text_in[c + 24 +: 8]) ^ 
                                    (text_in[c + 16 +: 8]) ^
                                    (text_in[c + 8 +: 8])    ^
                                    mb2(text_in[c + 0 +: 8]);
            // Compute second cell in column
            text_out[c + 8 +: 8] =  (text_in[c + 24 +: 8]) ^ 
                                    (text_in[c + 16 +: 8]) ^
                                    mb2(text_in[c + 8 +: 8])    ^
                                    mb3(text_in[c + 0 +: 8]);
            // Compute third cell in column// Compute first cell in column
            text_out[c + 16 +: 8] = (text_in[c + 24 +: 8]) ^ 
                                    mb2(text_in[c + 16 +: 8]) ^
                                    mb3(text_in[c + 8 +: 8])    ^
                                    (text_in[c + 0 +: 8]);
            // Compute forth cell in column
            text_out[c + 24 +: 8] = mb2(text_in[c + 24 +: 8]) ^ 
                                    mb3(text_in[c + 16 +: 8]) ^
                                    (text_in[c + 8 +: 8])    ^
                                    (text_in[c + 0 +: 8]);
        end 
    end 
    else begin
        text_out = text_in;
    end 
end

endmodule