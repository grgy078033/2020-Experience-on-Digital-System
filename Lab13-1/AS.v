`include "FA.v"
module AS(sel, A, B, S, O);
input [3:0] A, B;
input sel;
output [3:0] S;
output O;
wire c1, c2, c3,c4;
wire xor0,xor1,xor2,xor3;
xor u_xor0(xor0,B[0],sel);
xor u_xor1(xor1,B[1],sel);
xor u_xor2(xor2,B[2],sel);
xor u_xor3(xor3,B[3],sel);

FA fa_0(.s(S[0]), .c_out(c1), .x(A[0]), .y(xor0), .c_in(sel));
FA fa_1(.s(S[1]), .c_out(c2), .x(A[1]), .y(xor1), .c_in(c1));
FA fa_2(.s(S[2]), .c_out(c3), .x(A[2]), .y(xor2), .c_in(c2));
FA fa_3(.s(S[3]), .c_out(c4), .x(A[3]), .y(xor3), .c_in(c3));

xor u_xor4(O,c4,c3);
endmodule


