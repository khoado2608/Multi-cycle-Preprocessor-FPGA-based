module led7doan(
    input logic  [3:0]  i_data,
    output logic [6:0]  o_hex
);

	always_comb begin
    unique case(i_data)
      4'd0: o_hex = 7'b1000000;
      4'd1: o_hex = 7'b1111001;
      4'd2: o_hex = 7'b0100100;
      4'd3: o_hex = 7'b0110000;
      4'd4: o_hex = 7'b0011001;
      4'd5: o_hex = 7'b0010010;
      4'd6: o_hex = 7'b0000010;
      4'd7: o_hex = 7'b1111000;
      4'd8: o_hex = 7'b0000000;
      4'd9: o_hex = 7'b0010000;
      4'd10: o_hex = 7'b0001000;
      4'd11: o_hex = 7'b0000011;
      4'd12: o_hex = 7'b1000110;
      4'd13: o_hex = 7'b0100001;
      4'd14: o_hex = 7'b0000110;
      4'd15: o_hex = 7'b0001110;
      default: o_hex = 7'b0111111;
    endcase
  end
endmodule


