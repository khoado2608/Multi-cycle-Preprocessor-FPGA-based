module chaykit(
    input logic [0:0] SW,  	//run      
    input logic [0:0] KEY,         // Tín hiệu reset
	 input CLOCK_50,
    output logic [6:0] HEX0,     
    output logic [6:0] HEX1, 
	output logic [6:0] HEX2, 
		output logic [4:0] LEDR
);
logic [8:0] temp;
xong het(.clk(CLOCK_50), .reset(~KEY[0]), .run(SW[0]), .leds(temp), .statenow(LEDR));
led7doan hex0(.i_data(temp[3:0]), .o_hex(HEX0));
led7doan hex1(.i_data(temp[7:4]), .o_hex(HEX1));
led7doan hex2(.i_data({3'b0,temp[8]}), .o_hex(HEX2));
endmodule
