// ALU 8-bit

`timescale 1ns / 1ps

module ALU(
    input [7:0] A, B,   // 8-bit ALU inputs 
    input [3:0] ALU_Sel, // ALU Selection
    output [7:0] ALU_out, // 8-bit ALU output
    output CarryOut // Carry Out Flag
    );
    reg [7:0] ALU_Result;
    wire [8:0] tmp;
    assign ALU_Out = ALU_Result; // ALU out
    assign tmp = {1'b0,A} + {1'b0,B};
    assign CarryOut = tmp[8]; // Carryout flag
    always @(*)
    begin
        case(ALU_Sel)
            4'b0000: // Addition
                ALU_Result = A + B;
            4'b0001: // Subtraction
                ALU_Result = A - B;
            4'b0010: // Multiplication
                ALU_Result = A * B;
            4'b0011: // Division
                ALU_Result = A / B;
            4'b0100: // Logical Shift Left
                ALU_Result = A << 1;
            4'b0101: // Logical Shift Right
                ALU_Result = A >> 1;
            4'b0110: // Rotate Left
                ALU_Result = {A[6:0],A[7]};
            4'b0111: // Rotate Right
                ALU_Result = {A[0],A[7:1]};
            4'b1000: // Logical AND
                ALU_Result = A & B;
            4'b1001: // Logical OR
                ALU_Result = A | B;
            4'b1010: // Logical XOR
                ALU_Result = A ^ B;
            4'b1011: // Logical NOR
                ALU_Result = ~(A | B);
            4'b1100: // Logical NAND
                ALU_Result = ~(A & B);
            4'b1101: // Logical XNOR
                ALU_Result = ~(A ^ B);
            4'b1110: // Greater Comparison
                ALU_Result = (A>B)?8'd1:8'd0;
            4'b1111: // Equal Comparison
                ALU_Result = (A==B)?8'd1:8'd0;
            default : ALU_Result = A + B;
         endcase
    end
endmodule
