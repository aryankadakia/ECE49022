`timescale 1ns / 1ps

module multiply_tb();
    parameter WIDTH = 16;
    logic signed [WIDTH-1:0] a_real, a_imag, b_real, b_imag; 
    logic signed [WIDTH-1:0] m_real, m_imag;

    multiply #(.WIDTH(WIDTH)) DUT (.a_real(a_real), 
                                  .a_imag(a_imag),
                                  .b_real(b_real),
                                  .b_imag(b_imag),
                                  .m_real(m_real),
                                  .m_imag(m_imag));

    initial begin
        a_real = 0;
        a_imag = 0;
        b_real = 0;
        b_imag = 0;
        #(2ns);

        a_real = 16'h7F62;
        a_imag = 2;
        b_real = 6;
        b_imag = 3;
        #(5ns);
        $finish;
    end
endmodule
