module IR_block(input clk, input rst, input ir_in, input [8:0] Din, output logic [8:0] Dout);
always_ff@(posedge clk, posedge rst) begin
    if(rst) 
    Dout <= 9'b0;
    else if(ir_in) begin Dout <= Din;
    end
end
endmodule