`timescale 1ns / 1ps
/*
 * Written by: yellokrow
 * Last modified: Mar 30, 2014
 * FreeBSD license
 */

module main(
	input clk,
	input btn,
	output[3:0] led,
	output[6:0] cathodes,
	output[3:0] anodes
    );

// the number to be displayed
reg[3:0] counter = 0;

// this counter is to wait a number of seconds
reg[15:0] timer_counter = 0;

// state is necessary to see if the button is being held down
reg state = 1;

// the anode to be displayed. on the basys2 board it would be the
// far right anode
assign anodes[3:0] = 4'b0111;

// assign the number currently on to display as the binary representation
assign led[3:0] = counter[3:0];

// map the number currently on to the correct cathodes on the Basys2 board
Digit_Decoder d(.number(counter), .digit(cathodes));

// every positive clock cycle
always@(posedge clk)
begin
	// because of bouncing of the button switch when pressed i
	// decided to wait every 1/128 seconds per cycle
	if(timer_counter[7:0] == 8'b10000000)
	begin
		// if the button is in the down position(positive 1)
		// and the state is also one, then continue.
		if(btn == 1 && state == 1)
		begin
			// don't go beyond 9
			if(counter == 9)
				counter <= 0;
			else
				counter <= counter + 1;
			
			// button has been pressed
			state <= 0;
		end
		// button has been released
		else if(btn == 0 && state == 0)
			state <= 1;
		
	end
	else
		timer_counter <= timer_counter + 1;
end

endmodule

// END!