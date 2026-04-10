module exponent(
	input [3:0] exp_A,	// 4 bit
	input [3:0] exp_B,	//4 bit 
	input [3:0] fract_A,
	input [3:0] fract_B,
	output [4:0] abs_exp_diff,
	output [3:0] fract_bigger,
	output [3:0] fract_smaller,
	output day_cout
);
logic cout;
logic [4:0] exp_diff;
logic [4:0] fract_diff;
subtractor_exp aomachua(.a({1'b0, exp_A}), .b({1'b0, exp_B}), .diff(exp_diff[4:0]));
subtractor_fract aomanuane(.a({1'b0, fract_A}), .b({1'b0, fract_B}), .diff(fract_diff[4:0]));
logic [4:0] two_comp;
logic temp;
assign temp = exp_diff[4] | exp_diff[3] | exp_diff[2] | exp_diff[1] | exp_diff[0];
twocompliment t1(.into(exp_diff), .outto(two_comp));
assign abs_exp_diff = (~exp_diff[4])? exp_diff[4:0] : two_comp[4:0];	//do bị ngược
assign fract_bigger = (temp)? ((exp_diff[4])? fract_B : fract_A) : ((~fract_diff[4])? fract_A : fract_B);
assign fract_smaller = (temp)? ((exp_diff[4])? fract_A : fract_B) : ((~fract_diff[4])? fract_B : fract_A);
assign day_cout = exp_diff[4];
endmodule


module twocompliment(input [4:0] into, output [4:0] outto);
logic c1,c2,c3,c4, c5;
	fulladder f(~into[0], 1'b1, 1'b0, outto[0],c1);
	fulladder ff(~into[1], 1'b0, c1, outto[1], c2);
	fulladder fff(~into[2], 1'b0, c2, outto[2], c3);
	fulladder ffff(~into[3], 1'b0, c3, outto[3], c4);
	fulladder fffff(~into[4], 1'b0, c4, outto[4], c5);
endmodule
