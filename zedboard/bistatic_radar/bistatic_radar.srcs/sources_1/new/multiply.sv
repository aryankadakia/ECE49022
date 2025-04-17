// ----------------------------------------------------------
// multiply.sv -> multiples two sample inputs (a + ja)*(b + jb)
// ----------------------------------------------------------
module multiply #(
        parameter WIDTH = 16
    )(
        input  logic signed [WIDTH-1:0] a_real,
        input  logic signed [WIDTH-1:0] a_imag,
        input  logic signed [WIDTH-1:0] b_real,
        input  logic signed [WIDTH-1:0] b_imag,
        output logic signed [WIDTH-1:0] m_real,
        output logic signed [WIDTH-1:0] m_imag
    );
        logic signed [WIDTH-1:0] arbr, arbi, aibr, aibi;

        assign arbr = a_real * b_real;
        assign arbi = a_real * b_imag;
        assign aibr = a_imag * b_real;
        assign aibi = a_imag * b_imag;

        assign m_real = arbr - aibi;
        assign m_imag = arbi + aibr;
         
endmodule
