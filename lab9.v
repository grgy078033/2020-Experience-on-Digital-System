`define TimeExpire1 32'd50000000
`define TimeExpire2 32'd5000
module lab9( clk, reset, out, dot_row, dot_col);
    input  clk, reset;
    output [7:0]dot_row, dot_col;
	 output [6:0]out;
    wire [1:0]mode;
    wire [3:0]tmp;
    wire [2:0]row_count;

    Mode(.clk(clk), .reset(reset), .tmp(tmp), .mode(mode));
    LED_Dot_Matrix_Display(.mode(mode), .clock(clk), .reset(reset), .dot_row(dot_row), .dot_col(dot_col));
    Seven_Display(.tmp(tmp), .out(out));
endmodule

module Mode(clk, reset, tmp, mode);
    input clk, reset;
    output [3:0]tmp;
	 output [1:0]mode;

    reg [1:0]mode;
	 reg [3:0]tmp;
    reg [31:0]count;

    always@(posedge clk) begin
        if(~reset) begin
            count <= 32'd0;
            tmp <= 4'b0001;
            mode <= 2'b00;
        end
        else begin
            if(count == `TimeExpire1) begin
                count <= 32'd0;
                if(mode == 2'b00) begin
                    if(tmp == 4'b1111) begin
                        mode <= 2'b01;
                        tmp <= 4'b0001;
                    end
						  else begin
								tmp <= tmp + 4'b0001;
						  end
                end
                else if(mode == 2'b01) begin
                    if(tmp == 4'b0101) begin
                        mode <= 2'b10;
                        tmp <= 4'b0001;
                    end
						  else begin
								tmp <= tmp + 4'b0001;
						  end
                end
                else if(mode == 2'b10) begin
                    if(tmp == 4'b1010) begin
                        mode <= 2'b00;
                        tmp <= 4'b0001;
                    end
						  else begin
								tmp <= tmp + 4'b0001;
						  end
                end
            end
            else begin
                count <= count + 32'd1;
            end
        end
    end
endmodule

module LED_Dot_Matrix_Display(mode, clock, reset, dot_row, dot_col);
    input clock, reset;
	 input [1:0]mode;
    output [7:0]dot_row, dot_col;

	 reg [7:0]dot_row;
	 reg [7:0]dot_col;
    reg [31:0]count;
    reg [2:0]row_count;

    always@(posedge clock or negedge reset) begin
        if(~reset) begin
            dot_row <= 8'b0;
            dot_col <= 8'b0;
            row_count <= 0;
        end
        else begin
            if(count == `TimeExpire2) begin
                count <= 32'd0;
                if(row_count == 3'd7) begin
                    row_count <= 3'd0;
                end
                row_count <= row_count + 1;
            end
				else begin
					count <= count + 1;
				end
            case (row_count)
                3'd0: dot_row <= 8'b01111111;
                3'd1: dot_row <= 8'b10111111;
                3'd2: dot_row <= 8'b11011111;
                3'd3: dot_row <= 8'b11101111;
                3'd4: dot_row <= 8'b11110111;
                3'd5: dot_row <= 8'b11111011;
                3'd6: dot_row <= 8'b11111101;
                3'd7: dot_row <= 8'b11111110;
            endcase
            
				if(mode == 2'b00) begin
					case (row_count)
                    3'd0: dot_col <= 8'b00001100;
                    3'd1: dot_col <= 8'b00001100;
                    3'd2: dot_col <= 8'b00011001;
                    3'd3: dot_col <= 8'b01111110;
                    3'd4: dot_col <= 8'b10011000;
                    3'd5: dot_col <= 8'b00011000;
                    3'd6: dot_col <= 8'b00101000;
                    3'd7: dot_col <= 8'b01001000;
               endcase
				end
            
				else if(mode == 2'b01) begin
					 case (row_count)
                    3'd0: dot_col <= 8'b00000000;
                    3'd1: dot_col <= 8'b00100100;
                    3'd2: dot_col <= 8'b00111100;
                    3'd3: dot_col <= 8'b10111101;
                    3'd4: dot_col <= 8'b11111111;
                    3'd5: dot_col <= 8'b00111100;
                    3'd6: dot_col <= 8'b00111100;
                    3'd7: dot_col <= 8'b00000000;
					 endcase
            end
            
				else if(mode == 2'b10) begin
					 case (row_count)
                    3'd0: dot_col <= 8'b00011000;
                    3'd1: dot_col <= 8'b00011000;
                    3'd2: dot_col <= 8'b00111100;
                    3'd3: dot_col <= 8'b00111100;
                    3'd4: dot_col <= 8'b01011010;
                    3'd5: dot_col <= 8'b00011000;
                    3'd6: dot_col <= 8'b00011000;
                    3'd7: dot_col <= 8'b00100100;
                endcase
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
