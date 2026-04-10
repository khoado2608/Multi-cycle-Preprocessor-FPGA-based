module testbench();
	logic clock;
	logic reset;
	logic run;
	logic [8:0] bus;
	logic [8:0] R1, R2, R3, R4, R5, R6, R7, R0, GReg, IR;
	logic [8:0] led;
	logic [4:0] state;
	xong DUT(.clk(clock), .reset(reset), .run(run), .day_bus_cu(bus),
			.r0reg(R0), .r1reg(R1), .r2reg(R2), .r3reg(R3), .r4reg(R4),
				.r5reg(R5), .r6reg(R6), .r7reg(R7), .day_tu_g(GReg), .IR(IR), .leds(led), .statenow(state));

	always begin 
		clock = 0; #20;
		clock = 1; #20;
	end
	
	initial begin
		reset = 1;
		run = 0;
		#40;
		reset = 0;
		run = 1;
		#1800;
	end
endmodule
