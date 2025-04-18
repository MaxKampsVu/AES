/* The sBox implemented as a lookup table */
module sBox;


// Used as refrence for masked sBox 
task LOOKUP_BYTE(input [7:0] text_in, output [7:0] text_out);
    case (text_in[7:0])
        8'h0 : text_out[7:0] = 'h63;
        8'h1 : text_out[7:0] = 'h7c;
        8'h2 : text_out[7:0] = 'h77;
        8'h3 : text_out[7:0] = 'h7b;
        8'h4 : text_out[7:0] = 'hf2;
        8'h5 : text_out[7:0] = 'h6b;
        8'h6 : text_out[7:0] = 'h6f;
        8'h7 : text_out[7:0] = 'hc5;
        8'h8 : text_out[7:0] = 'h30;
        8'h9 : text_out[7:0] = 'h01;
        8'ha : text_out[7:0] = 'h67;
        8'hb : text_out[7:0] = 'h2b;
        8'hc : text_out[7:0] = 'hfe;
        8'hd : text_out[7:0] = 'hd7;
        8'he : text_out[7:0] = 'hab;
        8'hf : text_out[7:0] = 'h76;
        8'h10 : text_out[7:0] = 'hca;
        8'h11 : text_out[7:0] = 'h82;
        8'h12 : text_out[7:0] = 'hc9;
        8'h13 : text_out[7:0] = 'h7d;
        8'h14 : text_out[7:0] = 'hfa;
        8'h15 : text_out[7:0] = 'h59;
        8'h16 : text_out[7:0] = 'h47;
        8'h17 : text_out[7:0] = 'hf0;
        8'h18 : text_out[7:0] = 'had;
        8'h19 : text_out[7:0] = 'hd4;
        8'h1a : text_out[7:0] = 'ha2;
        8'h1b : text_out[7:0] = 'haf;
        8'h1c : text_out[7:0] = 'h9c;
        8'h1d : text_out[7:0] = 'ha4;
        8'h1e : text_out[7:0] = 'h72;
        8'h1f : text_out[7:0] = 'hc0;
        8'h20 : text_out[7:0] = 'hb7;
        8'h21 : text_out[7:0] = 'hfd;
        8'h22 : text_out[7:0] = 'h93;
        8'h23 : text_out[7:0] = 'h26;
        8'h24 : text_out[7:0] = 'h36;
        8'h25 : text_out[7:0] = 'h3f;
        8'h26 : text_out[7:0] = 'hf7;
        8'h27 : text_out[7:0] = 'hcc;
        8'h28 : text_out[7:0] = 'h34;
        8'h29 : text_out[7:0] = 'ha5;
        8'h2a : text_out[7:0] = 'he5;
        8'h2b : text_out[7:0] = 'hf1;
        8'h2c : text_out[7:0] = 'h71;
        8'h2d : text_out[7:0] = 'hd8;
        8'h2e : text_out[7:0] = 'h31;
        8'h2f : text_out[7:0] = 'h15;
        8'h30 : text_out[7:0] = 'h04;
        8'h31 : text_out[7:0] = 'hc7;
        8'h32 : text_out[7:0] = 'h23;
        8'h33 : text_out[7:0] = 'hc3;
        8'h34 : text_out[7:0] = 'h18;
        8'h35 : text_out[7:0] = 'h96;
        8'h36 : text_out[7:0] = 'h05;
        8'h37 : text_out[7:0] = 'h9a;
        8'h38 : text_out[7:0] = 'h07;
        8'h39 : text_out[7:0] = 'h12;
        8'h3a : text_out[7:0] = 'h80;
        8'h3b : text_out[7:0] = 'he2;
        8'h3c : text_out[7:0] = 'heb;
        8'h3d : text_out[7:0] = 'h27;
        8'h3e : text_out[7:0] = 'hb2;
        8'h3f : text_out[7:0] = 'h75;
        8'h40 : text_out[7:0] = 'h09;
        8'h41 : text_out[7:0] = 'h83;
        8'h42 : text_out[7:0] = 'h2c;
        8'h43 : text_out[7:0] = 'h1a;
        8'h44 : text_out[7:0] = 'h1b;
        8'h45 : text_out[7:0] = 'h6e;
        8'h46 : text_out[7:0] = 'h5a;
        8'h47 : text_out[7:0] = 'ha0;
        8'h48 : text_out[7:0] = 'h52;
        8'h49 : text_out[7:0] = 'h3b;
        8'h4a : text_out[7:0] = 'hd6;
        8'h4b : text_out[7:0] = 'hb3;
        8'h4c : text_out[7:0] = 'h29;
        8'h4d : text_out[7:0] = 'he3;
        8'h4e : text_out[7:0] = 'h2f;
        8'h4f : text_out[7:0] = 'h84;
        8'h50 : text_out[7:0] = 'h53;
        8'h51 : text_out[7:0] = 'hd1;
        8'h52 : text_out[7:0] = 'h00;
        8'h53 : text_out[7:0] = 'hed;
        8'h54 : text_out[7:0] = 'h20;
        8'h55 : text_out[7:0] = 'hfc;
        8'h56 : text_out[7:0] = 'hb1;
        8'h57 : text_out[7:0] = 'h5b;
        8'h58 : text_out[7:0] = 'h6a;
        8'h59 : text_out[7:0] = 'hcb;
        8'h5a : text_out[7:0] = 'hbe;
        8'h5b : text_out[7:0] = 'h39;
        8'h5c : text_out[7:0] = 'h4a;
        8'h5d : text_out[7:0] = 'h4c;
        8'h5e : text_out[7:0] = 'h58;
        8'h5f : text_out[7:0] = 'hcf;
        8'h60 : text_out[7:0] = 'hd0;
        8'h61 : text_out[7:0] = 'hef;
        8'h62 : text_out[7:0] = 'haa;
        8'h63 : text_out[7:0] = 'hfb;
        8'h64 : text_out[7:0] = 'h43;
        8'h65 : text_out[7:0] = 'h4d;
        8'h66 : text_out[7:0] = 'h33;
        8'h67 : text_out[7:0] = 'h85;
        8'h68 : text_out[7:0] = 'h45;
        8'h69 : text_out[7:0] = 'hf9;
        8'h6a : text_out[7:0] = 'h02;
        8'h6b : text_out[7:0] = 'h7f;
        8'h6c : text_out[7:0] = 'h50;
        8'h6d : text_out[7:0] = 'h3c;
        8'h6e : text_out[7:0] = 'h9f;
        8'h6f : text_out[7:0] = 'ha8;
        8'h70 : text_out[7:0] = 'h51;
        8'h71 : text_out[7:0] = 'ha3;
        8'h72 : text_out[7:0] = 'h40;
        8'h73 : text_out[7:0] = 'h8f;
        8'h74 : text_out[7:0] = 'h92;
        8'h75 : text_out[7:0] = 'h9d;
        8'h76 : text_out[7:0] = 'h38;
        8'h77 : text_out[7:0] = 'hf5;
        8'h78 : text_out[7:0] = 'hbc;
        8'h79 : text_out[7:0] = 'hb6;
        8'h7a : text_out[7:0] = 'hda;
        8'h7b : text_out[7:0] = 'h21;
        8'h7c : text_out[7:0] = 'h10;
        8'h7d : text_out[7:0] = 'hff;
        8'h7e : text_out[7:0] = 'hf3;
        8'h7f : text_out[7:0] = 'hd2;
        8'h80 : text_out[7:0] = 'hcd;
        8'h81 : text_out[7:0] = 'h0c;
        8'h82 : text_out[7:0] = 'h13;
        8'h83 : text_out[7:0] = 'hec;
        8'h84 : text_out[7:0] = 'h5f;
        8'h85 : text_out[7:0] = 'h97;
        8'h86 : text_out[7:0] = 'h44;
        8'h87 : text_out[7:0] = 'h17;
        8'h88 : text_out[7:0] = 'hc4;
        8'h89 : text_out[7:0] = 'ha7;
        8'h8a : text_out[7:0] = 'h7e;
        8'h8b : text_out[7:0] = 'h3d;
        8'h8c : text_out[7:0] = 'h64;
        8'h8d : text_out[7:0] = 'h5d;
        8'h8e : text_out[7:0] = 'h19;
        8'h8f : text_out[7:0] = 'h73;
        8'h90 : text_out[7:0] = 'h60;
        8'h91 : text_out[7:0] = 'h81;
        8'h92 : text_out[7:0] = 'h4f;
        8'h93 : text_out[7:0] = 'hdc;
        8'h94 : text_out[7:0] = 'h22;
        8'h95 : text_out[7:0] = 'h2a;
        8'h96 : text_out[7:0] = 'h90;
        8'h97 : text_out[7:0] = 'h88;
        8'h98 : text_out[7:0] = 'h46;
        8'h99 : text_out[7:0] = 'hee;
        8'h9a : text_out[7:0] = 'hb8;
        8'h9b : text_out[7:0] = 'h14;
        8'h9c : text_out[7:0] = 'hde;
        8'h9d : text_out[7:0] = 'h5e;
        8'h9e : text_out[7:0] = 'h0b;
        8'h9f : text_out[7:0] = 'hdb;
        8'ha0 : text_out[7:0] = 'he0;
        8'ha1 : text_out[7:0] = 'h32;
        8'ha2 : text_out[7:0] = 'h3a;
        8'ha3 : text_out[7:0] = 'h0a;
        8'ha4 : text_out[7:0] = 'h49;
        8'ha5 : text_out[7:0] = 'h06;
        8'ha6 : text_out[7:0] = 'h24;
        8'ha7 : text_out[7:0] = 'h5c;
        8'ha8 : text_out[7:0] = 'hc2;
        8'ha9 : text_out[7:0] = 'hd3;
        8'haa : text_out[7:0] = 'hac;
        8'hab : text_out[7:0] = 'h62;
        8'hac : text_out[7:0] = 'h91;
        8'had : text_out[7:0] = 'h95;
        8'hae : text_out[7:0] = 'he4;
        8'haf : text_out[7:0] = 'h79;
        8'hb0 : text_out[7:0] = 'he7;
        8'hb1 : text_out[7:0] = 'hc8;
        8'hb2 : text_out[7:0] = 'h37;
        8'hb3 : text_out[7:0] = 'h6d;
        8'hb4 : text_out[7:0] = 'h8d;
        8'hb5 : text_out[7:0] = 'hd5;
        8'hb6 : text_out[7:0] = 'h4e;
        8'hb7 : text_out[7:0] = 'ha9;
        8'hb8 : text_out[7:0] = 'h6c;
        8'hb9 : text_out[7:0] = 'h56;
        8'hba : text_out[7:0] = 'hf4;
        8'hbb : text_out[7:0] = 'hea;
        8'hbc : text_out[7:0] = 'h65;
        8'hbd : text_out[7:0] = 'h7a;
        8'hbe : text_out[7:0] = 'hae;
        8'hbf : text_out[7:0] = 'h08;
        8'hc0 : text_out[7:0] = 'hba;
        8'hc1 : text_out[7:0] = 'h78;
        8'hc2 : text_out[7:0] = 'h25;
        8'hc3 : text_out[7:0] = 'h2e;
        8'hc4 : text_out[7:0] = 'h1c;
        8'hc5 : text_out[7:0] = 'ha6;
        8'hc6 : text_out[7:0] = 'hb4;
        8'hc7 : text_out[7:0] = 'hc6;
        8'hc8 : text_out[7:0] = 'he8;
        8'hc9 : text_out[7:0] = 'hdd;
        8'hca : text_out[7:0] = 'h74;
        8'hcb : text_out[7:0] = 'h1f;
        8'hcc : text_out[7:0] = 'h4b;
        8'hcd : text_out[7:0] = 'hbd;
        8'hce : text_out[7:0] = 'h8b;
        8'hcf : text_out[7:0] = 'h8a;
        8'hd0 : text_out[7:0] = 'h70;
        8'hd1 : text_out[7:0] = 'h3e;
        8'hd2 : text_out[7:0] = 'hb5;
        8'hd3 : text_out[7:0] = 'h66;
        8'hd4 : text_out[7:0] = 'h48;
        8'hd5 : text_out[7:0] = 'h03;
        8'hd6 : text_out[7:0] = 'hf6;
        8'hd7 : text_out[7:0] = 'h0e;
        8'hd8 : text_out[7:0] = 'h61;
        8'hd9 : text_out[7:0] = 'h35;
        8'hda : text_out[7:0] = 'h57;
        8'hdb : text_out[7:0] = 'hb9;
        8'hdc : text_out[7:0] = 'h86;
        8'hdd : text_out[7:0] = 'hc1;
        8'hde : text_out[7:0] = 'h1d;
        8'hdf : text_out[7:0] = 'h9e;
        8'he0 : text_out[7:0] = 'he1;
        8'he1 : text_out[7:0] = 'hf8;
        8'he2 : text_out[7:0] = 'h98;
        8'he3 : text_out[7:0] = 'h11;
        8'he4 : text_out[7:0] = 'h69;
        8'he5 : text_out[7:0] = 'hd9;
        8'he6 : text_out[7:0] = 'h8e;
        8'he7 : text_out[7:0] = 'h94;
        8'he8 : text_out[7:0] = 'h9b;
        8'he9 : text_out[7:0] = 'h1e;
        8'hea : text_out[7:0] = 'h87;
        8'heb : text_out[7:0] = 'he9;
        8'hec : text_out[7:0] = 'hce;
        8'hed : text_out[7:0] = 'h55;
        8'hee : text_out[7:0] = 'h28;
        8'hef : text_out[7:0] = 'hdf;
        8'hf0 : text_out[7:0] = 'h8c;
        8'hf1 : text_out[7:0] = 'ha1;
        8'hf2 : text_out[7:0] = 'h89;
        8'hf3 : text_out[7:0] = 'h0d;
        8'hf4 : text_out[7:0] = 'hbf;
        8'hf5 : text_out[7:0] = 'he6;
        8'hf6 : text_out[7:0] = 'h42;
        8'hf7 : text_out[7:0] = 'h68;
        8'hf8 : text_out[7:0] = 'h41;
        8'hf9 : text_out[7:0] = 'h99;
        8'hfa : text_out[7:0] = 'h2d;
        8'hfb : text_out[7:0] = 'h0f;
        8'hfc : text_out[7:0] = 'hb0;
        8'hfd : text_out[7:0] = 'h54;
        8'hfe : text_out[7:0] = 'hbb;
        8'hff : text_out[7:0] = 'h16;
    endcase
endtask

endmodule