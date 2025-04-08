`timescale 1ns / 1ps
`include "register_file_if.vh"


module register_file_tb;

    parameter PERIOD = 10;
    
    logic CLK = 0, nRST;

    // clock
    always #(PERIOD/2) CLK++;

    // interface
    register_file_if rfif ();
    // test program
    // DUT
    register_file DUT(CLK, nRST, rfif);

    initial begin 
        parameter PERIOD = 10;
        integer i;
        nRST = 1'b0;
        #(PERIOD);
        //write testing 
        // write to reg 0 
        nRST = 1'b1;
        rfif.WEN = 1'b1;
        rfif.wsel = 0;
        rfif.wdat = 32'h11110001;
        #(PERIOD);
        rfif.WEN = 1'b0;
        #(PERIOD*3);
        rfif.rsel1 = 0;
        rfif.rsel2 = 0;
        if(rfif.rdat1 == 0 && rfif.rdat2 == 0)begin 
            $display("Correct");
        end
        else begin 
            $display("Incorrect");
        end 

         // write to rest of regs
        for(i = 1; i < 32; i++) begin 
        nRST = 1'b1;
        rfif.WEN = 1'b1;
        rfif.wsel = i[4:0];
        rfif.wdat = i;
        #(PERIOD);
        rfif.WEN = 1'b0;
        #(PERIOD*3);
        rfif.rsel1 = i[4:0];
        rfif.rsel2 = i[4:0];
        #(PERIOD/2);
        if(rfif.rdat1 == i && rfif.rdat2 == i)begin 
            $display("Correct");
        end
        else begin 
            $display("Incorrect");
        end      
        end 
        $finish;
    end 

endmodule

