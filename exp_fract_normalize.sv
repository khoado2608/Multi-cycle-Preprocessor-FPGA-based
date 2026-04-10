//////////////////////////////////////////////////////////////////////////////
// Standard form of normalized goal is
// 1.0xxxxxx * 2^exp (number >= 1.0)
// or 0.1xxxxxx * 2^exp (number < 1.0) 
// number >= 1.0 or < 1.0 is determined by the first bit of the fraction
// if the first bit is 1, we need to shift right 
// and subtract 1 from the exponent
// Case: temp_fract = 101010 and exp = 100
// first "1" is at position 5, so we need to 
// shift right 1 time and add 1 to the exponent
//
//Case: temp_fract = 010101 and exp = 101
// first "1" is at position 4, so we need to keep it
// and the to fom 0.1 (0101) -> fract = 0101 and exp = 101
// 
//
//
//////////////////////////////////////////////////////////////////////////////
module exp_fract_normalize (
    input [5:0] temp_fract,
    input [3:0] final_exp,
    output logic [3:0] result_fract,
    output logic [3:0] result_exp
);
    reg [2:0] offset;
    reg addsub;

    // Determine offset (shift amount) based on leading '1'
    always_comb begin
        if      (temp_fract[5]) offset = 3'b001;  // shift right by 1
        else if (temp_fract[4]) offset = 3'b000;  // no shift
        else if (temp_fract[3]) offset = 3'b001;  // shift left by 1
        else if (temp_fract[2]) offset = 3'b010;  // shift left by 2
        else if (temp_fract[1]) offset = 3'b011;  // shift left by 3
        else if (temp_fract[0]) offset = 3'b100;  // shift left by 4
        else                    offset = 3'b000;  // all zeros (no shift)
    end

    // Determine if we add or subtract the offset
    always_comb begin
        addsub = ~temp_fract[5];  // subtract if MSB=1, else add
    end

    // Adjust exponent
    adder_3_bit result_exp_adder (
        .a(final_exp),
        .b({1'b0,offset}),
        .addsub(addsub),
        .sum(result_exp)
    );

    // Normalize fraction
    always_comb begin
        if (temp_fract[5]) begin
            result_fract = temp_fract[4:1];  // shift right by 1
        end
        else begin
            case (offset)
                3'b000: result_fract = temp_fract[3:0];  // no shift
                3'b001: result_fract = {temp_fract[2:0], 1'b0};  // shift left 1
                3'b010: result_fract = {temp_fract[1:0], 2'b00};  // shift left 2
                3'b011: result_fract = {temp_fract[0], 3'b000};  // shift left 3
                3'b100: result_fract = 4'b0000;  // shift left 4 (but only 1 bit left)
                default: result_fract = 4'b0000;
            endcase
        end
    end
endmodule

module adder_3_bit (
    input [3:0] a,
    input [3:0] b,
	 input addsub,
    output [3:0] sum
);

    wire c_out_0;
    wire c_out_1;
	 wire c_out_2;

    full_adder adder_0 (.a(a[0]), .b(b[0] ^ addsub), .carry_in(addsub), .sum(sum[0]), .carry_out(c_out_0));
    full_adder adder_1 (.a(a[1]), .b(b[1] ^ addsub), .carry_in(c_out_0), .sum(sum[1]), .carry_out(c_out_1));
    full_adder adder_2 (.a(a[2]), .b(b[2] ^ addsub), .carry_in(c_out_1), .sum(sum[2]), .carry_out(c_out_2));
	 full_adder adder_3 (.a(a[3]), .b(b[3] ^ addsub), .carry_in(c_out_2), .sum(sum[3]), .carry_out());
    
endmodule

module full_adder (
    input a,
    input b,
    input carry_in,
    output sum, 
    output carry_out
);
    
    assign sum = a ^ b ^ carry_in;
    assign carry_out = (a & b) | (a & carry_in) | (b & carry_in);

endmodule
