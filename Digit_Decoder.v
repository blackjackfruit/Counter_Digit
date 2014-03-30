`timescale 1ns / 1ps
/*
 * Written by: yellokrow
 * Last modified: Mar 30, 2014
 * FreeBSD license
 */

module Digit_Decoder(
	input[3:0] number,
	output reg[6:0] digit
    );

always@(number)
begin
	case(number)
	4'b0000: digit <= 7'b1000000; // 0
	4'b0001: digit <= 7'b1111001; // 1
	4'b0010: digit <= 7'b0100100; // 2
	4'b0011: digit <= 7'b0110000; // 3
	4'b0100: digit <= 7'b0011001; // 4
	4'b0101: digit <= 7'b0010010; // 5
	4'b0110: digit <= 7'b0000010; // 6
	4'b0111: digit <= 7'b1111000; // 7
	4'b1000: digit <= 7'b0000000; // 8
	4'b1001: digit <= 7'b0011000; // 9
	default: digit <= 7'b0110110; // out of bounds. just in case
	endcase
end

endmodule
