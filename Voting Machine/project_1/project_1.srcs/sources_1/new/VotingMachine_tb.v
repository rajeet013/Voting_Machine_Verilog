`timescale 1ns / 1ps


module test;

    // inputs
    reg CLK;
    reg RST;
    reg MODE;
    reg BTN1;
    reg BTN2;
    reg BTN3;
    reg BTN4;
    
    // outputs
    wire [7:0] LEDS;
    
    // Instantiate the Design Under Test
    
    VotingMachine DUT(
        CLK,
        RST,
        MODE,
        BTN1,
        BTN2,
        BTN3,
        BTN4,
        LEDS
    );
    
    initial
        begin
            CLK = 0;
            forever #5 CLK = ~CLK;
        end
        
        initial begin
            // Initialize Inputs
            RST = 1; MODE = 0; BTN1 = 0; BTN2 = 0; BTN3 = 0; BTN4 = 0;
            // Wait 100 ns for global reset to finish
            #100;
            
            // Add stimulus here
            
            #100; RST = 0; MODE = 0; BTN1 = 0; BTN2 = 0; BTN3 = 0; BTN4 = 0;
            #5;   RST = 0; MODE = 0; BTN1 = 1; BTN2 = 0; BTN3 = 0; BTN4 = 0;
            #10; RST = 0; MODE = 0; BTN1 = 0; BTN2 = 0; BTN3 = 0; BTN4 = 0;
            #5;   RST = 0; MODE = 0; BTN1 = 1; BTN2 = 0; BTN3 = 0; BTN4 = 0;
            #200; RST = 0; MODE = 0; BTN1 = 0; BTN2 = 0; BTN3 = 0; BTN4 = 0;
            #5;   RST = 0; MODE = 0; BTN1 = 0; BTN2 = 0; BTN3 = 0; BTN4 = 0;
            #10; RST = 0; MODE = 0; BTN1 = 0; BTN2 = 0; BTN3 = 0; BTN4 = 0;
            #5;   RST = 0; MODE = 0; BTN1 = 0; BTN2 = 0; BTN3 = 0; BTN4 = 0;
            
            #5; RST = 0; MODE = 0; BTN1 = 0; BTN2 = 1; BTN3 = 0; BTN4 = 0;
            #200;   RST = 0; MODE = 0; BTN1 = 0; BTN2 = 0; BTN3 = 0; BTN4 = 0;
            #5;   RST = 0; MODE = 0; BTN1 = 0; BTN2 = 0; BTN3 = 0; BTN4 = 0;
            #10; RST = 0; MODE = 0; BTN1 = 0; BTN2 = 0; BTN3 = 0; BTN4 = 0;
            #5;   RST = 0; MODE = 0; BTN1 = 0; BTN2 = 0; BTN3 = 0; BTN4 = 0;
            
            #5; RST = 0; MODE = 0; BTN1 = 0; BTN2 = 1; BTN3 = 1; BTN4 = 0;
            #200;   RST = 0; MODE = 0; BTN1 = 0; BTN2 = 0; BTN3 = 0; BTN4 = 0;
            #5;   RST = 0; MODE = 0; BTN1 = 0; BTN2 = 0; BTN3 = 0; BTN4 = 0;
            #10; RST = 0; MODE = 0; BTN1 = 0; BTN2 = 0; BTN3 = 0; BTN4 = 0;
            #5;   RST = 0; MODE = 0; BTN1 = 0; BTN2 = 0; BTN3 = 0; BTN4 = 0;
            
            #5; RST = 0; MODE = 1; BTN1 = 0; BTN2 = 1; BTN3 = 0; BTN4 = 0;
            #200;   RST = 0; MODE = 1; BTN1 = 0; BTN2 = 0; BTN3 = 1; BTN4 = 0;
            #5;   RST = 0; MODE = 0; BTN1 = 0; BTN2 = 0; BTN3 = 0; BTN4 = 0;
            #10; RST = 0; MODE = 0; BTN1 = 0; BTN2 = 0; BTN3 = 0; BTN4 = 0;
            #5;   RST = 0; MODE = 0; BTN1 = 0; BTN2 = 0; BTN3 = 0; BTN4 = 0;
            
            #5; RST = 0; MODE = 0; BTN1 = 0; BTN2 = 0; BTN3 = 1; BTN4 = 0;
            #200;   RST = 0; MODE = 0; BTN1 = 0; BTN2 = 0; BTN3 = 0; BTN4 = 0;
            #5;   RST = 0; MODE = 0; BTN1 = 0; BTN2 = 0; BTN3 = 0; BTN4 = 0;
            #10; RST = 0; MODE = 0; BTN1 = 0; BTN2 = 0; BTN3 = 0; BTN4 = 0;
            #5;   RST = 0; MODE = 0; BTN1 = 0; BTN2 = 0; BTN3 = 0; BTN4 = 0;
            
            $finish;
        end
        
        initial
            begin
            $dumpvars;
                $dumpfile("dump.vcd");
            
            end
        initial
            $monitor($time, "mode=%b, button1=%b, button2=%b, button3=%b, button4=%b, led=%d", MODE, BTN1, BTN2, BTN3, BTN4,LEDS);
endmodule
