`timescale 1ns / 1ps

module butterfly_tb();
    parameter WIDTH = 16;
    logic signed [WIDTH-1:0] x0_real, x0_imag, x1_real, x1_imag; 
    logic signed [WIDTH-1:0] y0_real, y0_imag, y1_real, y1_imag;

    butterfly #(.WIDTH(WIDTH)) DUT (.x0_real(x0_real), 
                                    .x0_imag(x0_imag),
                                    .x1_real(x1_real),
                                    .x1_imag(x1_imag),
                                    .y0_real(y0_real),
                                    .y0_imag(y0_imag),
                                    .y1_real(y1_real),
                                    .y1_imag(y1_imag));

    initial begin
        x0_real = 0;
        x0_imag = 0;
        x1_real = 0;
        x1_imag = 0;
        #(2ns);

        x0_real = 0.1;
        x0_imag = 3;
        x1_real = 10;
        x1_imag = 5;
        #(5ns);
        $finish;

    end 
endmodule
