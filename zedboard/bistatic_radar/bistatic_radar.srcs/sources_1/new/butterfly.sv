// ----------------------------------------------------------
// butterfly.sv -> adds and subs two inputs
// ----------------------------------------------------------
module butterfly #(
        parameter WIDTH = 16
    )(
        input  logic signed [WIDTH-1:0] x0_real,
        input  logic signed [WIDTH-1:0] x0_imag,
        input  logic signed [WIDTH-1:0] x1_real,
        input  logic signed [WIDTH-1:0] x1_imag, 
        output logic signed [WIDTH-1:0] y0_real,
        output logic signed [WIDTH-1:0] y0_imag,
        output logic signed [WIDTH-1:0] y1_real,
        output logic signed [WIDTH-1:0] y1_imag
    );
        assign y0_real = x0_real + x1_real;
        assign y0_imag = x0_imag + x1_imag;
        assign y1_real = x0_real - x1_real;
        assign y1_imag = x0_imag - x1_imag;
endmodule
