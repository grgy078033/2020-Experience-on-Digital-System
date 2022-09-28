module lab6(in, out)
    input [3:0] in; // SW0~SW3
    output [6:0] out; // HEX06(g)~HEX00(a)
    reg [6:0] out;
    always@(in) begin
        case({in})
            4'b0000: begin
            out = 7'b1000000; //0
            end
            4'b0001: begin
            out = 7'b1111001; // 1
            end
            4'b0010: begin
            out = 7'b0100100; // 2
            end
            4'b0011: begin
            out = 7'b0010010; // 5 (3*2-1=5)
            end
            4'b0100: begin
            out = 7'b1111000; // 7 (4*2-1=7)
            end
            4'b0101: begin
            out = 7'b0010000; // 9 (5*2-1=9)
            end
            4'b0110: begin
            out = 7'b0100001; // D (6*2+1=13=D)
            end
            4'b0111: begin
            out = 7'b0001110; // F (7*2+1=15=F)
            end
            default: begin
            out = 7'b1000000; // default = 0
            end
        endcase
    end
endmodule

module lab6(in, out1, out2, out3)
    input [1:0] in; // SW0~SW1
    output [6:0] out1; // HEX06(g)~HEX00(a)
    output [6:0] out2; // HEX16(g)~HEX10(a)
    output [6:0] out3; // HEX26(g)~HEX20(a)
    reg [6:0] out1;
    reg [6:0] out2;
    reg [6:0] out3;
    always@(in) begin
        case({in})
            2'b00: begin
            out1 = 7'b0100100; //2
            out2 = 7'b1111001; //1
            out3 = 7'b1000000; //0
            end
            2'b01: begin
            out1 = 7'b0000000; //8
            out2 = 7'b1111000; //7
            out3 = 7'b0000010; //6
            end
            2'b10: begin
            out1 = 7'b1000000; //1
            out2 = 7'b0100100; //2
            out3 = 7'b0110000; //3
            end
            2'b11: begin
            out1 = 7'b1000000; //R
            out2 = 7'b1000000; //R
            out3 = 7'b0000110; //E
            end
        endcase
    end
endmodule