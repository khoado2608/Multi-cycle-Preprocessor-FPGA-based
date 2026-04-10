module fpu(
	input [8:0] so_a,
	input [8:0] so_b,
	input select,
	output logic [8:0] nor_res,
	output logic zero_dectect,
	output [5:0] kqshift,
	output [3:0] day_small_fract,
	output [3:0] abs_diff,
	output [5:0] kq_adder,
	output [3:0] day_big_fract,
	output [5:0] day_modified,
	output [3:0] day_offset,
	output day_control
);
sign_computation si(.a(so_a), .b(so_b), .select(select), .result_sign(nor_res[8]));
logic [3:0] ea;
logic [3:0] eb;
logic [3:0] fr_a;
logic [3:0] fr_b;
assign ea = so_a[7:4];
assign eb = so_b[7:4];
assign fr_a = so_a[3:0];
assign fr_b = so_b[3:0];
logic [4:0] abs_expdif;
logic [3:0] f_b, f_sm;
logic [5:0] shift_resultne;
logic [3:0] mux_fin_res;
logic [5:0] adder_fin_res;
logic day_cout_ne;
exponent eee(.exp_A(ea), .exp_B(eb), .fract_A(fr_a), .fract_B(fr_b), .abs_exp_diff(abs_expdif),
			.fract_bigger(f_b), .fract_smaller(f_sm), .day_cout(day_cout_ne));
rightshift rfi(.smaller_fract(f_sm), .exp_diff(abs_expdif), .shifted_fract_final(shift_resultne),
 .modified_not_shift(day_modified), .offset(day_offset));
bottom  bb1(.shift_result(shift_resultne), .big_fract(f_b), .EA(ea), .EB(eb), .signed_A(so_a[8]), .signed_B(so_b[8]), .select(select), .large_2(mux_fin_res),
					.large_1(adder_fin_res), .control_now(day_control));
exp_fract_normalize ketthuc(.temp_fract(adder_fin_res), .final_exp(mux_fin_res), .result_fract(nor_res[3:0]), .result_exp(nor_res[7:4]));
assign abs_diff = abs_expdif;
assign day_small_fract = f_sm;
assign kqshift = shift_resultne;
assign kq_adder = adder_fin_res;
assign day_big_fract = f_b;
logic [3:0] xorfr;
assign xorfr  = fr_a ^ fr_b;
logic [2:0] xore;
assign xore = ea ^ eb;
logic [3:0] checking;
assign checking = {1'b0, xore};
logic zerodet;
assign zerodet = xorfr[0] | xorfr[1] | xorfr[2] | xorfr[3] | checking[1] | checking[2] | checking[3] | checking[0];
assign zero_dectect = (~zerodet) ? day_control : 1'b0;
endmodule
