module connect_reg(
    input [8:0] bus_wire,
    input clk,
    input rst,
    input R0_in,
    input R1_in,
    input R2_in,
    input R3_in,
    input R4_in,
    input R5_in,
    input R6_in,
    input addr_in,
    input dout_in,
    output logic [8:0] R0_wire,
    output logic [8:0] R1_wire,
    output logic [8:0] R2_wire,
    output logic [8:0] R3_wire,
    output logic [8:0] R4_wire,
    output logic [8:0] R5_wire,
    output logic [8:0] R6_wire,
    output logic [8:0] addr_wire,
    output logic [8:0] dout_wire
);

register9bit block_R0(.d_in(bus_wire), .clk(clk), .rst(rst), .enable(R0_in), .d_out(R0_wire));
register9bit block_R1(.d_in(bus_wire), .clk(clk), .rst(rst), .enable(R1_in), .d_out(R1_wire));
register9bit block_R2(.d_in(bus_wire), .clk(clk), .rst(rst), .enable(R2_in), .d_out(R2_wire));
register9bit block_R3(.d_in(bus_wire), .clk(clk), .rst(rst), .enable(R3_in), .d_out(R3_wire));
register9bit block_R4(.d_in(bus_wire), .clk(clk), .rst(rst), .enable(R4_in), .d_out(R4_wire));
register9bit block_R5(.d_in(bus_wire), .clk(clk), .rst(rst), .enable(R5_in), .d_out(R5_wire));
register9bit block_R6(.d_in(bus_wire), .clk(clk), .rst(rst), .enable(R6_in), .d_out(R6_wire));
register9bit block_addr(.d_in(bus_wire), .clk(clk), .rst(rst), .enable(addr_in), .d_out(addr_wire));  // Address register
register9bit block_dout(.d_in(bus_wire), .clk(clk), .rst(rst), .enable(dout_in), .d_out(dout_wire));
endmodule
