module lab10(clk,rst,btn_left,btn_right,dot_row,dot_col,move_left,move_right);
	input clk,rst,btn_left,btn_right;
	output reg [7:0] dot_row;
	output reg [15:0] dot_col;
	
	output move_left,move_right;

	reg [31:0] cnt_div,cnt_dot;
	reg [15:0] dot_col_buff[0:7];
	reg [2:0] row_count;
	reg clk_div,clk_dot;

	btn_control left_btn_control(clk,rst,btn_left,move_left);
	btn_control right_btn_control(clk,rst,btn_right,move_right);
	
	
	always@(posedge clk)
	begin
		if (~rst)
		begin
			cnt_div <= 32'b0;
			cnt_dot <= 32'b0;
			clk_div <= 1'b0;
			clk_dot <= 1'b0;
		end
		else
		begin
			if(cnt_dot == 5000) begin
				cnt_dot <= 32'b0;
				clk_dot <= ~clk_dot;
			end
			else begin
				cnt_dot <= cnt_dot + 1;
			end
			if(cnt_div == 6250000) begin
				cnt_div <= 32'b0;
				clk_div <= ~clk_div;
			end
			else begin
				cnt_div <= cnt_div + 1;
			end
		end
	end
	
	always@ (posedge clk_dot or negedge rst)
	begin
		if (~rst)
		begin
			dot_row <= 8'd0;
			dot_col <= 16'd0;
			row_count <= 3'd0;
		end
		else
		begin
			if(row_count == 3'd7) begin
				row_count <= 3'd0;
				end
			else begin
		    row_count <= row_count + 1;
			 dot_col <= dot_col_buff[row_count];
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
			end
		end
	end

	always@ (posedge clk_div or negedge rst)
	begin
		if (~rst) begin
			dot_col_buff[0] = 15'b0001110000000000;
			dot_col_buff[1] = 15'b0001011000000000;
			dot_col_buff[2] = 15'b0001111000000000;
			dot_col_buff[3] = 15'b0011100000000000;
			dot_col_buff[4] = 15'b1011111000000000;
			dot_col_buff[5] = 15'b1111100000000000;
			dot_col_buff[6] = 15'b0111100000000000;
			dot_col_buff[7] = 15'b0010100000000000;
		end
		else begin
			if(move_left == 1) begin
			dot_col_buff[0] <= {dot_col_buff[0][14:0], dot_col_buff[0][15]};
			dot_col_buff[1] <= {dot_col_buff[1][14:0], dot_col_buff[1][15]};
			dot_col_buff[2] <= {dot_col_buff[2][14:0], dot_col_buff[2][15]};
			dot_col_buff[3] <= {dot_col_buff[3][14:0], dot_col_buff[3][15]};
			dot_col_buff[4] <= {dot_col_buff[4][14:0], dot_col_buff[4][15]};
			dot_col_buff[5] <= {dot_col_buff[5][14:0], dot_col_buff[5][15]};
			dot_col_buff[6] <= {dot_col_buff[6][14:0], dot_col_buff[6][15]};
			dot_col_buff[7] <= {dot_col_buff[7][14:0], dot_col_buff[7][15]};
			end
			else if(move_right == 1) begin
			dot_col_buff[0] <= {dot_col_buff[0][0], dot_col_buff[0][15:1]};
			dot_col_buff[1] <= {dot_col_buff[1][0], dot_col_buff[1][15:1]};
			dot_col_buff[2] <= {dot_col_buff[2][0], dot_col_buff[2][15:1]};
			dot_col_buff[3] <= {dot_col_buff[3][0], dot_col_buff[3][15:1]};
			dot_col_buff[4] <= {dot_col_buff[4][0], dot_col_buff[4][15:1]};
			dot_col_buff[5] <= {dot_col_buff[5][0], dot_col_buff[5][15:1]};
			dot_col_buff[6] <= {dot_col_buff[6][0], dot_col_buff[6][15:1]};
			dot_col_buff[7] <= {dot_col_buff[7][0], dot_col_buff[7][15:1]};
			end
		end
		end
endmodule

module btn_control(clk,rst,btn_signal,move);
	input clk,rst,btn_signal;
	output reg move;

	reg [31:0] cnt;

	always@(posedge clk or negedge rst)
	begin
		if (~rst)
		begin
			move <= 1'b0;
			cnt <= 32'd0;
		end
		else
		begin

			if (cnt == 12500000)
			begin
				move <= 1'b0;
				cnt <= 32'd0;
			end
			else if(cnt[7:0] == 8'd0)
			begin
				move <= (!btn_signal)? 1'b1 : move;
				cnt <= cnt + 32'b1;
			end
			else
			begin
				cnt <= cnt + 32'b1;
			end
		end
	end

endmodule
