module rightshift (
    input [3:0] smaller_fract,
    input [4:0] exp_diff,
    output logic [5:0] shifted_fract_final,
	 output logic [5:0] modified_not_shift,
	 output logic [3:0] offset
);
logic [5:0] fin_sim;
logic [5:0] shifted_fract;
logic cout; // Declare a wire for cout
sumbit s1(smaller_fract, 4'b0, 1'b0, fin_sim[3:0], cout); // Connect cout properly
assign fin_sim[4] = 1'b1;
assign fin_sim[5] = 1'b0;
logic [5:0] out_mux;
decoder4to16 m0(exp_diff, out_mux);
mux21 m0m(fin_sim[0], 1'b0, out_mux[0], shifted_fract[0]);
mux21 m1(fin_sim[1], 1'b0, out_mux[1], shifted_fract[1]);
mux21 m2(fin_sim[2], 1'b0, out_mux[2], shifted_fract[2]);
mux21 m3(fin_sim[3], 1'b0, out_mux[3], shifted_fract[3]);
mux21 m4(fin_sim[4], 1'b0, out_mux[4], shifted_fract[4]);
mux21 m5(fin_sim[5], 1'b0, out_mux[5], shifted_fract[5]);
logic [3:0] deci;
assign offset = deci;
assign modified_not_shift = shifted_fract;
decodershifted_fract d1(exp_diff[3:0], deci);
 always_comb begin
        case (deci)
            4'd0: shifted_fract_final =  shifted_fract[5:0]; // Keep all bits
            4'd1: shifted_fract_final = {1'b0, shifted_fract[5:1]}; // Remove 1 bit
            4'd2: shifted_fract_final = {2'b0, shifted_fract[5:2]}; // Remove 2 bits
            4'd3: shifted_fract_final = {3'b0, shifted_fract[5:3]}; // Remove 3 bits
            4'd4: shifted_fract_final = {4'b0, shifted_fract[5:4]}; // Remove 4 bits
            4'd5: shifted_fract_final = {5'b0, shifted_fract[5]};   // Remove 5 bits
            default: shifted_fract_final = 6'b000000; // Default to zero
        endcase
    end
assign check = fin_sim;
endmodule

module decoder4to16 (input [4:0] in, output logic [5:0] outmux);
always_comb begin
    case(in) 
	  4'b0000: outmux = 6'b000000; // Bit 0
        4'b0001: outmux = 6'b000001; // Bit 1
        4'b0010: outmux = 6'b000011; // Bit 2
        4'b0011: outmux = 6'b000111; // Bit 3
        4'b0100: outmux = 6'b001111; // Bit 4
        4'b0101: outmux = 6'b011111; // Bit 5
        default: outmux = 6'b000000; // Handle invalid cases
endcase
end
endmodule

module mux21(input a, input b, input sel, output y);
    assign y = (sel)? b:a;
endmodule

module decodershifted_fract(input [3:0] in, output logic [3:0] exp_diff_decimal);
 always @(*) begin
        case (in[3:0])
            4'b0000: exp_diff_decimal = 4'd0;
            4'b0001: exp_diff_decimal = 4'd1;
            4'b0010: exp_diff_decimal = 4'd2;
            4'b0011: exp_diff_decimal = 4'd3;
            4'b0100: exp_diff_decimal = 4'd4;
            4'b0101: exp_diff_decimal = 4'd5;
            4'b0110: exp_diff_decimal = 4'd6;
            4'b0111: exp_diff_decimal = 4'd7;
            4'b1000: exp_diff_decimal = 4'd8;
            4'b1001: exp_diff_decimal = 4'd9;
            default: exp_diff_decimal = 4'd0; // Handle invalid cases
        endcase
    end
endmodule 

module sumbit(input [4:0] a, input [4:0] b,input cin, output [4:0] sum, output cout);
    wire w1, w2, w3, w4, w5;
        adder u1(a[0], b[0], cin, sum[0], w1);
        adder u2(a[1], b[1], w1, sum[1], w2);
        adder u3(a[2], b[2], w2, sum[2], w3);
        adder u4(a[3], b[3], w3, sum[3], cout);
endmodule

module adder(input X, input Y, input Ci, output S, output Co);
    wire w1, w2, w3;
    xor G1(w1, X, Y);
    xor G2(S, w1, Ci);
    and G3(w2, w1, Ci);
    and G4(w3, X, Y);
    or G5(Co, w2, w3);
endmodule

