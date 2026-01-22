`timescale 1ns / 1ps

// Button Control


module ButtonControl(
    input CLK,  // CLK
    input RST,  // RST
    input BTN,  // BTN
    output reg VALID_VOTE // Valid Vote
    );
    
    reg[30:0] COUNTER; // Counts Number of votes
    
    always @(posedge CLK)
    begin
        if (RST)
            COUNTER <= 0;   // Resets Counter to zero when Reset is 0
        else
        begin
            if (BTN & COUNTER < 11)
                COUNTER <= COUNTER + 1;   // Adds till 10
            else if (!BTN)
                COUNTER <= 0;   // Resets Counter to zero if Button is not pushed
        end
     end
     
     always @(posedge CLK)
     begin
        if (RST)
            VALID_VOTE <= 1'b0;   // Resets Vote to zero
        else
        begin
            if (COUNTER == 10)
                VALID_VOTE <= 1'b1;    // Set Vote to 1 when counter reaches 10
            else
                VALID_VOTE <= 1'b0;     // Resets Vote to zero
        end
     end         
endmodule

module ModeControl (
    input CLK,  // CLK
    input RST,  // RST
    input MODE, // MODE
    input VALID_VOTE_CASTED,    // Valid vote casted
    input [7:0] CAND1_VOTE,     // Candidate 1 vote
    input [7:0] CAND2_VOTE,     // Candidate 2 vote
    input [7:0] CAND3_VOTE,     // Candidate 3 vote
    input [7:0] CAND4_VOTE,     // Candidate 4 vote
    input CAND1_BTN_PRESS,      // Candidate 1 vote button
    input CAND2_BTN_PRESS,      // Candidate 2 vote button
    input CAND3_BTN_PRESS,      // Candidate 3 vote button
    input CAND4_BTN_PRESS,      // Candidate 4 vote button
    output reg [7:0] LEDS       // LEDS
);
    reg [30:0] COUNTER;     // Counter
    
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