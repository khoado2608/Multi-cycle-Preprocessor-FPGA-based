module counterr7(
    input [8:0] pc,
    input R7_in, rst, clk, incr_pc,
    output logic [8:0] R7_wire, pc_now
);

always_ff @(posedge clk or posedge rst) begin 
    if (rst) begin 
        pc_now = 1'b0;
    end else if (incr_pc == 0 && R7_in == 0) begin 
        pc_now = pc_now;
    end else if (incr_pc == 1 && R7_in == 0) begin 
        pc_now = pc_now + 1'b1;
    end else if ( incr_pc== 0 && R7_in == 1) begin 
        pc_now = pc;
    end else if (incr_pc == 1 && R7_in == 1) begin
        pc_now = pc + 1'b1;
    end
    R7_wire = pc_now;
end

endmodule
