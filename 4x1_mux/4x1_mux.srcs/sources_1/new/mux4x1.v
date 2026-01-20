// 4x1 MUX using 2x1 MUX 

`timescale 1ns / 1ps

module mux4x1(
input I0, I1, I2, I3,
input S0, S1,
output Y
    );
    wire Y0, Y1;
    mux2x1 m1(I0, I1, S0, Y0);
    mux2x1 m2(I2, I3, S0, Y1);
    mux2x1 m3(Y0, Y1, S1, Y);
endmodule

module mux2x1(
    input I0,
    input I1,
    input S,
    output Y
    );
    assign Y = S ? I0 : I1;
endmodule