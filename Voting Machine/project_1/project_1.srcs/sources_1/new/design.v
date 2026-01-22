`timescale 1ns / 1ps

// Button Control


module ButtonControl(
    input CLK,
    input RST,
    input BTN,
    output reg VALID_VOTE
    );
    
    reg[30:0] COUNTER;
    
    always @(posedge CLK)
    begin
        if (RST)
            COUNTER <= 0;
        else
        begin
            if (BTN & COUNTER < 11)
                COUNTER <= COUNTER + 1;
            else if (!BTN)
                COUNTER <= 0;
        end
     end
     
     always @(posedge CLK)
     begin
        if (RST)
            VALID_VOTE <= 1'b0;
        else
        begin
            if (COUNTER == 10)
                VALID_VOTE <= 1'b1;
            else
                VALID_VOTE <= 1'b0;
        end
     end         
endmodule

module ModeControl (
    input CLK,
    input RST,
    input MODE,
    input VALID_VOTE_CASTED,
    input [7:0] CAND1_VOTE,
    input [7:0] CAND2_VOTE,
    input [7:0] CAND3_VOTE,
    input [7:0] CAND4_VOTE,
    input CAND1_BTN_PRESS,
    input CAND2_BTN_PRESS,
    input CAND3_BTN_PRESS,
    input CAND4_BTN_PRESS,
    output reg [7:0] LEDS
);
    reg [30:0] COUNTER;
    
    always @(posedge CLK)
    begin
        if(RST)
            COUNTER <=0; // Whenever reset is pressed counter starts from 0
        else if (VALID_VOTE_CASTED)
            COUNTER <= COUNTER + 1; // If valid vote is casted, counter adds 1
        else if (COUNTER != 0 & COUNTER < 10)
            COUNTER <= COUNTER + 1; // If counter is not 0 increase it till 10
        else
            COUNTER <= 0; // Once counter becomes 10, reset it to zero
     end
    
     always @(posedge CLK)
     begin
        if (RST)
            LEDS <= 0;
        else
        begin
     end
   end 
   
   always @(posedge CLK)
   begin
      if(RST)
          LEDS <= 0;
      else
      begin
        if(MODE == 0 & COUNTER > 0) // Mode0 -> Voting mode, Mode1 -> Result Mode
            LEDS <= 8'hFF;
        else if (MODE == 0)
            LEDS <= 8'H00;
        else if (MODE == 1) // Result Mode
        begin
            if (CAND1_BTN_PRESS)
                LEDS <= CAND1_VOTE;
            else if (CAND2_BTN_PRESS)
                LEDS <= CAND2_VOTE;
            else if (CAND3_BTN_PRESS)
                LEDS <= CAND3_VOTE;
            else if (CAND4_BTN_PRESS)
                LEDS <= CAND4_VOTE;
         end
        end
     end
endmodule

module VoteLogger (
    input CLK,
    input RST,
    input MODE,
    input CAND1_VOTE_VALID,
    input CAND2_VOTE_VALID,
    input CAND3_VOTE_VALID,
    input CAND4_VOTE_VALID,
    output reg [7:0] CAND1_VOTE_RCVD,
    output reg [7:0] CAND2_VOTE_RCVD,
    output reg [7:0] CAND3_VOTE_RCVD,
    output reg [7:0] CAND4_VOTE_RCVD
    );
    
    always @(posedge CLK)
    begin
        if (RST)
        begin
            CAND1_VOTE_RCVD <= 0;
            CAND2_VOTE_RCVD <= 0;
            CAND3_VOTE_RCVD <= 0;
            CAND4_VOTE_RCVD <= 0;
        end 
        else
        begin
            if(CAND1_VOTE_VALID & MODE == 0)
                CAND1_VOTE_RCVD <= CAND1_VOTE_RCVD + 1;
            else if(CAND2_VOTE_VALID & MODE == 0)
                CAND2_VOTE_RCVD <= CAND2_VOTE_RCVD + 1;
            else if(CAND3_VOTE_VALID & MODE == 0)
                CAND3_VOTE_RCVD <= CAND3_VOTE_RCVD + 1;
            else if(CAND4_VOTE_VALID & MODE == 0)
                CAND4_VOTE_RCVD <= CAND4_VOTE_RCVD + 1;
        end
     end  
endmodule

module VotingMachine(
    input CLK,
    input RST,
    input MODE,
    input BTN1,
    input BTN2,
    input BTN3,
    input BTN4,
    output [7:0] LEDS
);

    wire VALID_VOTE_1;
    wire VALID_VOTE_2;
    wire VALID_VOTE_3;
    wire VALID_VOTE_4;
    wire [7:0] CAND1_VOTE_RCVD;
    wire [7:0] CAND2_VOTE_RCVD;
    wire [7:0] CAND3_VOTE_RCVD;
    wire [7:0] CAND4_VOTE_RCVD;
    wire ANYVALIDVOTE;
    
    assign ANYVALIDVOTE = VALID_VOTE_1 | VALID_VOTE_2 | VALID_VOTE_3 | VALID_VOTE_4;
    
    ButtonControl BC1(
        CLK, 
        RST,
        BTN,
        VALID_VOTE_1
    );
    
    ButtonControl BC2(
        CLK, 
        RST,
        BTN,
        VALID_VOTE_2
    );
    
    ButtonControl BC3(
        CLK, 
        RST,
        BTN,
        VALID_VOTE_3
    );
    
    ButtonControl BC4(
        CLK, 
        RST,
        BTN,
        VALID_VOTE_4
    );
    
    VoteLogger VL(
        CLK,
        RST,
        MODE,
        VALID_VOTE_1,
        VALID_VOTE_2,
        VALID_VOTE_3,
        VALID_VOTE_4,
        CAND1_VOTE_RCVD,
        CAND2_VOTE_RCVD,
        CAND3_VOTE_RCVD,
        CAND4_VOTE_RCVD
    );
    
    ModeControl MC(
        CLK,
        RST,
        MODE,
        VALID_VOTE_CASTED,
        CAND1_VOTE_RCVD,
        CAND2_VOTE_RCVD,
        CAND3_VOTE_RCVD,
        CAND4_VOTE_RCVD,
        VALID_VOTE_1,
        VALID_VOTE_2,
        VALID_VOTE_3,
        VALID_VOTE_4,
        LEDS
    );


endmodule