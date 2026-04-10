module sign_computation(
    input [8:0] a,
    input [8:0] b,
    input select,
    output logic result_sign
);
logic sign_A, sign_B, exp_check;
logic [3:0] fract_A, fract_B;
logic [3:0] exp_A, exp_B;
assign sign_A = a[8];
assign sign_B = b[8];
assign fract_A = a[3:0];
assign fract_B = b[3:0];
assign exp_A = a[7:4];
assign exp_B = b[7:4];
logic [4:0] exp_minus;
logic [4:0] fract_minus;
subtractor_exp se1(.a({1'b0, exp_A}), .b({1'b0, exp_B}), .diff(exp_minus), .borrow());
subtractor_fract sf1(.a({1'b0, fract_A}), .b({1'b0, fract_B}), .diff(fract_minus), .borrow());
always_comb begin
    if(~exp_minus[3]&~exp_minus[2]&~exp_minus[1]&~exp_minus[0]) begin //nếu hiệu exp = 0
        case({select, fract_minus[4]}) //fract_minus[4] = 0 -> fract A > fract B
            2'b00: result_sign = sign_A; // A > B
            2'b01: result_sign = sign_B; // A < B
            2'b10: result_sign = sign_A;
            2'b11: result_sign = ~sign_B;
            default: result_sign = 1'b0; // Default case
        endcase
    end else begin
        case({select, exp_minus[4]}) //case exp differ from 0
            2'b00: result_sign = sign_A; // A > B
            2'b01: result_sign = sign_B; // A < B
            2'b10: result_sign = sign_A;
            2'b11: result_sign = ~sign_B;
            default: result_sign = 1'b0; // Default case
        endcase
    end
end
endmodule

module checkequal0(input [3:0] datain, output z);
    assign z = ~(datain[0] | datain[1] | datain[2] | datain[3]);  // Check if all bits are 0 -> z = 1
endmodule
