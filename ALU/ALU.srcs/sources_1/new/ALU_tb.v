// ALU 8-bit testbench

`timescale 1ns / 1ps


module ALU_tb;
    // inputs
    reg [7:0] A, B;
    reg [3:0] ALU_Sel;
    
    // outputs
    wire [7:0] ALU_Out;
    wire CarryOut;
    
    // Verilog code for ALU
    integer i;
    ALU DUT (A, B,  // ALU 8-bit inputs 
             ALU_Sel, // ALU Selection
             ALU_Out, // ALU 8-bit Output 
             CarryOut // Carry Out Flag
    );
    initial 
    begin
    // hold reset state for 100 ns
    A = 8'h0A;  // A = 10
    B = 8'h02;  // B = 2
    ALU_Sel = 4'b0000; #100;
    
    A = 8'h0A;
    B = 8'h02;
    ALU_Sel = 4'b0001; #100;
    
    A = 8'h0A;
    B = 4'h02;
    ALU_Sel = 4'b0010; #100;
    
    A = 8'h0A;
    B = 4'h02;
    ALU_Sel = 4'b0011; #100;
    
    A = 8'h0A;
    B = 4'h02;
    ALU_Sel = 4'b0100; #100;
    
    A = 8'h0A;
    B = 4'h02;
    ALU_Sel = 4'b0101; #100;
    
    A = 8'h0A;
    B = 4'h02;
    ALU_Sel = 4'b0110; #100;
    
    A = 8'h0A;
    B = 4'h02;
    ALU_Sel = 4'b0111; #100;
    
    A = 8'h0A;
    B = 4'h02;
    ALU_Sel = 4'b1000; #100;
    
    A = 8'h0A;
    B = 4'h02;
    ALU_Sel = 4'b1001; #100;
    
    A = 8'h0A;
    B = 4'h02;
    ALU_Sel = 4'b1010; #100;
    
    A = 8'h0A;
    B = 4'h02;
    ALU_Sel = 4'b1011; #100;
    
    A = 8'h0A;
    B = 4'h02;
    ALU_Sel = 4'b1100; #100;
    
    A = 8'h0A;
    B = 4'h02;
    ALU_Sel = 4'b1101; #100;
    
    A = 8'h0A;
    B = 4'h02;
    ALU_Sel = 4'b1110; #100;
    
    A = 8'h0A;
    B = 4'h02;
    ALU_Sel = 4'b1111; #100;
    end
endmodule
