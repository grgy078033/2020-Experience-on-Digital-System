//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/12 07:51:12
// Design Name: 
// Module Name: lab8
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`define TimeExpire 32'd50000000
module lab8(pause, in, reset, clock, out);
	 input pause, in, reset, clock;
	 output [6:0]out;
    wire [3:0]tmp;
    wire [6:0]out;
    Moore_machine(.pause(pause), .in(in), .reset(reset), .clock(clock), .tmp(tmp));
    Seven_Display(.tmp(tmp), .out(out));
endmodule

module Moore_machine(pause, in, reset, clock, tmp);
    input pause, in, reset, clock;
    output [3:0]tmp;

    reg [3:0]tmp;
    reg [31:0]count;

    always@(posedge clock)
    begin
        if(!reset)
        begin
            tmp = 4'b0000;
        end

        if(pause)
        begin
            count <= 32'd0;
        end

        else
        begin
            if(count == `TimeExpire)
            begin
                count <= 32'd0;
                if(in)
                begin
                    case({tmp})
                        4'b0000 : begin
                            tmp = 4'b0001;
                        end
                        4'b0001 : begin
                            tmp = 4'b0010;
                        end
                        4'b0010 : begin
                            tmp = 4'b0100;
                        end
                        4'b0011 : begin
                            tmp = 4'b0011;
                        end
                        4'b0100 : begin
                            tmp = 4'b0101;
                        end
                        4'b0101 : begin
                            tmp = 4'b0101;
                        end
                    endcase
                end

                else
                begin
                    case({tmp})
                        4'b0000 : begin
                            tmp = 4'b0000;
                        end
                        4'b0001 : begin
                            tmp = 4'b0000;
                        end
                        4'b0010 : begin
                            tmp = 4'b0011;
                        end
                        4'b0011 : begin
                            tmp = 4'b0100;
                        end
                        4'b0100 : begin
                            tmp = 4'b0001;
                        end
                        4'b0101 : begin
                            tmp = 4'b0010;
                        end
                    endcase
                end
            end

            else
            begin
                count <= count + 32'd1;
            end
        end
    end
endmodule

module Seven_Display(tmp, out);
    input [3:0]tmp;
    output [6:0]out;
    reg [6:0]out;

    always@(tmp)
    begin
        case({tmp})
            4'b0000 : begin
                out = 7'b1000000;
            end
            4'b0001 : begin
                out = 7'b1111001;
            end
            4'b0010 : begin
                out = 7'b0100100;
            end
            4'b0011 : begin
                out = 7'b0110000;
            end
            4'b0100 : begin
                out = 7'b0011001;
            end
            4'b0101 : begin
                out = 7'b0010010;
            end
            4'b0110 : begin
                out = 7'b0000010;
            end
            4'b0111 : begin
                out = 7'b1111000;
            end
            4'b1000 : begin
                out = 7'b0000000;
            end
            4'b1001 : begin
                out = 7'b0010000;
            end
            4'b1010 : begin
                out = 7'b0001000;
            end
            4'b1011 : begin
                out = 7'b0000011;
            end
            4'b1100 : begin
                out = 7'b1000110;
            end
            4'b1101 : begin
                out = 7'b0100001;
            end
            4'b1110 : begin
                out = 7'b0000110;
            end
            4'b1111 : begin
                out = 7'b0001110;
            end
        endcase
    end
endmodule

