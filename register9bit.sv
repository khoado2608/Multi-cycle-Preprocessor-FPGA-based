module register9bit(
    input [8:0] d_in,
    input clk,
    input rst,
    input enable,
    output logic [8:0] d_out
);
always_ff@(posedge clk, posedge rst) begin
    if(rst) d_out <= 9'b0;
    else if(enable) begin d_out <= d_in;
    end
end
endmodule