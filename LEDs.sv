module LEDs (
    input clk,
    input reset,
		input enable,
    input [8:0] D,
    output reg [8:0] Q
);

    always_ff @( posedge clk or posedge reset ) begin
        if (reset) begin
            Q <= 9'b0;
        end else if(enable) begin
            Q <= D;
        end
    end

endmodule