`timescale 10ns / 1ps
module HA(s, c, x, y);
input x, y;
output s, c;

	xor u_xor(s,x,y);
	and u_and(c,x,y);

endmodule
