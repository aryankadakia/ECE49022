// ----------------------------------------------------------
// twiddle.sv -> 64-point twiddle table 
// ----------------------------------------------------------
module twiddle #(
        parameter TW_FF = 1,
        parameter WIDTH = 16,
        parameter TABLE_SIZE = 64
    )(
        input  logic             clk,
        input  logic [3:0]       addr,
        output logic [WIDTH-1:0] tw_real,
        output logic [WIDTH-1:0] tw_imag
    );
        logic [WIDTH-1:0] wn_real [0:TABLE_SIZE-1]; // Twiddle Table (Real)
        logic [WIDTH-1:0] wn_imag [0:TABLE_SIZE-1]; // Twiddle Table (Imag)
        logic [WIDTH-1:0] sel_real;                 // Multiplexer output (Real)
        logic [WIDTH-1:0] sel_imag;                 // Multiplexer output (Imag)
        logic [WIDTH-1:0] reg_real;                 // Register Output (Real)
        logic [WIDTH-1:0] reg_imag;                 // Register Output (Imag)

        assign sel_real = wn_real[addr];
        assign sel_imag = wn_imag[addr];

        always_ff @(posedge clk) begin
            reg_real <= sel_real;
            reg_imag <= sel_imag;
        end

        assign tw_real = TW_FF ? reg_real : sel_real;
        assign tw_imag = TW_FF ? reg_imag : sel_imag;

        // ----------------------------------------------------------
        // Twiddle Factor Table 
        // ----------------------------------------------------------

        //      wn_real = cos(-2pi*n/16)          wn_imag = sin(-2pi*n/16)
        assign  wn_real[ 0] = 16'h7fff;   assign  wn_imag[ 0] = 16'h0000;   //  0  1.000   0.000
        assign  wn_real[ 1] = 16'h7fd8;   assign  wn_imag[ 1] = 16'hf9b8;   //  1  0.999  -0.098
        assign  wn_real[ 2] = 16'h7f62;   assign  wn_imag[ 2] = 16'hf374;   //  2  0.981  -0.195
        assign  wn_real[ 3] = 16'h7e9d;   assign  wn_imag[ 3] = 16'hed37;   //  3  0.956  -0.290
        assign  wn_real[ 4] = 16'h7d8a;   assign  wn_imag[ 4] = 16'he707;   //  4  0.924  -0.383
        assign  wn_real[ 5] = 16'h7c29;   assign  wn_imag[ 5] = 16'he0ec;   //  5  0.881  -0.471
        assign  wn_real[ 6] = 16'h7a7d;   assign  wn_imag[ 6] = 16'hdae0;   //  6  0.831  -0.556
        assign  wn_real[ 7] = 16'h7884;   assign  wn_imag[ 7] = 16'hd4f2;   //  7  0.773  -0.634
        assign  wn_real[ 8] = 16'h7641;   assign  wn_imag[ 8] = 16'hcf05;   //  8  0.707  -0.707
        assign  wn_real[ 9] = 16'h73b6;   assign  wn_imag[ 9] = 16'hc945;   //  9  0.634  -0.773
        assign  wn_real[10] = 16'h70e2;   assign  wn_imag[10] = 16'hc3d3;   // 10  0.556  -0.831
        assign  wn_real[11] = 16'h6dca;   assign  wn_imag[11] = 16'hbe9b;   // 11  0.471  -0.881
        assign  wn_real[12] = 16'h6a6e;   assign  wn_imag[12] = 16'hb9aa;   // 12  0.383  -0.924
        assign  wn_real[13] = 16'h66cf;   assign  wn_imag[13] = 16'hb502;   // 13  0.290  -0.956
        assign  wn_real[14] = 16'h62f2;   assign  wn_imag[14] = 16'hb0a1;   // 14  0.195  -0.981
        assign  wn_real[15] = 16'h5ed7;   assign  wn_imag[15] = 16'hac89;   // 15  0.098  -0.999
        assign  wn_real[16] = 16'h5a82;   assign  wn_imag[16] = 16'ha57e;   // 16  0.000  -1.000
        assign  wn_real[17] = 16'h55ea;   assign  wn_imag[17] = 16'ha89d;   // 17 -0.098  -0.999
        assign  wn_real[18] = 16'h5132;   assign  wn_imag[18] = 16'habd7;   // 18 -0.195  -0.981
        assign  wn_real[19] = 16'h4c59;   assign  wn_imag[19] = 16'haf2d;   // 19 -0.290  -0.956
        assign  wn_real[20] = 16'h4766;   assign  wn_imag[20] = 16'hb2a6;   // 20 -0.383  -0.924
        assign  wn_real[21] = 16'h4255;   assign  wn_imag[21] = 16'hb641;   // 21 -0.471  -0.881
        assign  wn_real[22] = 16'h3d30;   assign  wn_imag[22] = 16'hb9fd;   // 22 -0.556  -0.831
        assign  wn_real[23] = 16'h37f9;   assign  wn_imag[23] = 16'hbdd9;   // 23 -0.634  -0.773
        assign  wn_real[24] = 16'h32b5;   assign  wn_imag[24] = 16'hc1d5;   // 24 -0.707  -0.707
        assign  wn_real[25] = 16'h2d66;   assign  wn_imag[25] = 16'hc5ef;   // 25 -0.773  -0.634
        assign  wn_real[26] = 16'h280f;   assign  wn_imag[26] = 16'hca26;   // 26 -0.831  -0.556
        assign  wn_real[27] = 16'h22b2;   assign  wn_imag[27] = 16'hce79;   // 27 -0.881  -0.471
        assign  wn_real[28] = 16'h1d51;   assign  wn_imag[28] = 16'hd2e7;   // 28 -0.924  -0.383
        assign  wn_real[29] = 16'h17f0;   assign  wn_imag[29] = 16'hd76e;   // 29 -0.956  -0.290
        assign  wn_real[30] = 16'h1291;   assign  wn_imag[30] = 16'hdc0d;   // 30 -0.981  -0.195
        assign  wn_real[31] = 16'h0d37;   assign  wn_imag[31] = 16'he0c3;   // 31 -0.999  -0.098
        assign  wn_real[32] = 16'h0000;   assign  wn_imag[32] = 16'h8001;   // 32 -1.000  -0.000
        assign  wn_real[33] = 16'hf2c9;   assign  wn_imag[33] = 16'he0c3;   // 33 -0.999   0.098
        assign  wn_real[34] = 16'hedae;   assign  wn_imag[34] = 16'hdc0d;   // 34 -0.981   0.195
        assign  wn_real[35] = 16'hea10;   assign  wn_imag[35] = 16'hd76e;   // 35 -0.956   0.290
        assign  wn_real[36] = 16'hdfaf;   assign  wn_imag[36] = 16'hd2e7;   // 36 -0.924   0.383
        assign  wn_real[37] = 16'hdd4e;   assign  wn_imag[37] = 16'hce79;   // 37 -0.881   0.471
        assign  wn_real[38] = 16'hd7f1;   assign  wn_imag[38] = 16'hca26;   // 38 -0.831   0.556
        assign  wn_real[39] = 16'hd29a;   assign  wn_imag[39] = 16'hc5ef;   // 39 -0.773   0.634
        assign  wn_real[40] = 16'hcd4b;   assign  wn_imag[40] = 16'hc1d5;   // 40 -0.707   0.707
        assign  wn_real[41] = 16'hc807;   assign  wn_imag[41] = 16'hbdd9;   // 41 -0.634   0.773
        assign  wn_real[42] = 16'hc2d0;   assign  wn_imag[42] = 16'hb9fd;   // 42 -0.556   0.831
        assign  wn_real[43] = 16'hbda9;   assign  wn_imag[43] = 16'hb641;   // 43 -0.471   0.881
        assign  wn_real[44] = 16'hb892;   assign  wn_imag[44] = 16'hb2a6;   // 44 -0.383   0.924
        assign  wn_real[45] = 16'hb39f;   assign  wn_imag[45] = 16'haf2d;   // 45 -0.290   0.956
        assign  wn_real[46] = 16'haec6;   assign  wn_imag[46] = 16'habd7;   // 46 -0.195   0.981
        assign  wn_real[47] = 16'haa0e;   assign  wn_imag[47] = 16'ha89d;   // 47 -0.098   0.999
        assign  wn_real[48] = 16'ha57e;   assign  wn_imag[48] = 16'h0000;   // 48 -0.000   1.000
        assign  wn_real[49] = 16'ha08a;   assign  wn_imag[49] = 16'hac89;   // 49  0.098   0.999
        assign  wn_real[50] = 16'h9b0d;   assign  wn_imag[50] = 16'hb0a1;   // 50  0.195   0.981
        assign  wn_real[51] = 16'h9611;   assign  wn_imag[51] = 16'hb502;   // 51  0.290   0.956
        assign  wn_real[52] = 16'h9192;   assign  wn_imag[52] = 16'hb9aa;   // 52  0.383   0.924
        assign  wn_real[53] = 16'h8d96;   assign  wn_imag[53] = 16'hbe9b;   // 53  0.471   0.881
        assign  wn_real[54] = 16'h8a1e;   assign  wn_imag[54] = 16'hc3d3;   // 54  0.556   0.831
        assign  wn_real[55] = 16'h8739;   assign  wn_imag[55] = 16'hc945;   // 55  0.634   0.773
        assign  wn_real[56] = 16'h84ef;   assign  wn_imag[56] = 16'hcf05;   // 56  0.707   0.707
        assign  wn_real[57] = 16'h8335;   assign  wn_imag[57] = 16'hd4f2;   // 57  0.773   0.634
        assign  wn_real[58] = 16'h8217;   assign  wn_imag[58] = 16'hdae0;   // 58  0.831   0.556
        assign  wn_real[59] = 16'h8196;   assign  wn_imag[59] = 16'he0ec;   // 59  0.881   0.471
        assign  wn_real[60] = 16'h81a3;   assign  wn_imag[60] = 16'he707;   // 60  0.924   0.383
        assign  wn_real[61] = 16'h824e;   assign  wn_imag[61] = 16'hed37;   // 61  0.956   0.290
        assign  wn_real[62] = 16'h839e;   assign  wn_imag[62] = 16'hf374;   // 62  0.981   0.195
        assign  wn_real[63] = 16'h8586;   assign  wn_imag[63] = 16'hf9b8;   // 63  0.999   0.098

endmodule
