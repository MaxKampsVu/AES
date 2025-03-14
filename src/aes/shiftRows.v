/* Shift Rows operation */
module shiftRows(
    input  wire [3:0]   round, 
    input  wire [127:0] text_in,
    output reg [127:0]  text_out
);

integer r; 

always @ * begin 
    if (round > 0 && round <= 10) begin
        // Column 0: Shift left by 3 positions
        text_out[0 +: 8]   = text_in[32 +: 8];   
        text_out[32 +: 8]  = text_in[64 +: 8];  
        text_out[64 +: 8]  = text_in[96 +: 8];  
        text_out[96 +: 8]  = text_in[0 +: 8];    
        
        // Column 1: Shift left by 2 positions
        text_out[8 +: 8]   = text_in[72 +: 8];   
        text_out[40 +: 8]  = text_in[104 +: 8];   
        text_out[72 +: 8]  = text_in[8 +: 8];    
        text_out[104 +: 8] = text_in[40 +: 8];   

        // Column 2: Shift left by 1 position 
        text_out[16 +: 8]  = text_in[112 +: 8];    
        text_out[48 +: 8]  = text_in[16 +: 8];    
        text_out[80 +: 8]  = text_in[48 +: 8];   
        text_out[112 +: 8] = text_in[80 +: 8];    

        // Column 3: No shift 
        text_out[24 +: 8]  = text_in[24 +: 8];   
        text_out[56 +: 8]  = text_in[56 +: 8];  
        text_out[88 +: 8]  = text_in[88 +: 8];  
        text_out[120 +: 8] = text_in[120 +: 8];   
    end
    else begin 
        text_out = text_in;
    end     
end

endmodule
