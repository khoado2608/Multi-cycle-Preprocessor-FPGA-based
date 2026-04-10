//phần từ right shift trở xuống
module bottom(
	input [5:0] shift_result,
	input [3:0] big_fract,
	input [3:0] EA,
	input [3:0] EB,
	input signed_A,
	input signed_B,
	input select,
	output [3:0] large_2, //kq của mux 
	output [5:0] large_1,	//kq của add, 
	output control_now
);
logic [5:0] wi1;
logic [5:0] extended_sel;

logic work_mode;
assign work_mode = (signed_A ^ select) ^ signed_B;
//or work_mode = 
assign control_now = work_mode;
assign extended_sel[0] = work_mode;
assign extended_sel[1] = work_mode;
assign extended_sel[2] = work_mode;
assign extended_sel[3] = work_mode;
assign extended_sel[4] = work_mode;
assign extended_sel[5] = work_mode;
logic [5:0] input_adder;
assign input_adder[0] = extended_sel[0] ^ shift_result[0];
assign input_adder[1] = extended_sel[1] ^ shift_result[1];
assign input_adder[2] = extended_sel[2] ^ shift_result[2];
assign input_adder[3] = extended_sel[3] ^ shift_result[3];
assign input_adder[4] = extended_sel[4] ^ shift_result[4];
assign input_adder[5] = extended_sel[5] ^ shift_result[5];
adder6bit aoma(.A(input_adder) , .B({1'b0, 1'b1, big_fract}), .cin(work_mode), .sum(large_1));
logic cout_cua_exp;
exponent aomanuaroi(.exp_A(EA), .exp_B(EB), .day_cout(cout_cua_exp));
assign large_2 = (cout_cua_exp)? EB : EA;
endmodule
