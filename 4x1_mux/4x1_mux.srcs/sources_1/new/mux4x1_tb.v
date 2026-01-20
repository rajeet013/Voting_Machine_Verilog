// 4x1 MUX testbench

`timescale 1ns / 1ps

module mux4x1_tb;
    reg I0, I1, I2, I3;
    reg S0, S1;
    wire Y;
    mux4x1 DUT(I0, I1, I2, I3, S0, S1, Y);
    initial
                begin
                    $display("I0=%b, I1=%b, I2=%b. I3=%b, S0=%b, S1=%b, Y=%b", I0, I1, I2, I3, S0, S1, Y);
                    I0=1; I1=0; I2=0; I3=0; S0=0; S1=0;
                    $display("I0=%b, I1=%b, I2=%b. I3=%b, S0=%b, S1=%b, Y=%b", I0, I1, I2, I3, S0, S1, Y);
                    #100
                    I0=0; I1=1; I2=0; I3=0; S0=0; S1=1;
                    $display("I0=%b, I1=%b, I2=%b. I3=%b, S0=%b, S1=%b, Y=%b", I0, I1, I2, I3, S0, S1, Y);
                    #100
                    I0=0; I1=0; I2=1; I3=0; S0=1; S1=0;
                    $display("I0=%b, I1=%b, I2=%b. I3=%b, S0=%b, S1=%b, Y=%b", I0, I1, I2, I3, S0, S1, Y);
                    #100
                    I0=0; I1=0; I2=0; I3=1; S0=1; S1=1;
                    $display("I0=%b, I1=%b, I2=%b. I3=%b, S0=%b, S1=%b, Y=%b", I0, I1, I2, I3, S0, S1, Y);
                end
endmodule