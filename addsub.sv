module addsub(
    input [8:0] from_A,
    input clk,
    input rst,
    input A_in,
    input G_in,
    input [8:0] from_bus,
    input addsub,
    output logic [8:0] from_G
);
logic [8:0] A_out, add_sub_out;
register9bit regfromA(.d_in(from_A), .clk(clk), .rst(rst), .enable(A_in), .d_out(A_out));
add_sub_block add_sub(.a(A_out), .b(from_bus), .cin(addsub), .result(add_sub_out));
register9bit regfromG(.d_in(add_sub_out), .clk(clk), .rst(rst), .enable(G_in), .d_out(from_G));
endmodule

module add_sub_block(input [8:0] a, b, input cin, output [8:0] result, output cout);
    logic c1,c2,c3,c4,c5,c6,c7,c8;
    fulladder fa1(a[0], b[0] ^ cin, cin, result[0], c1);
    fulladder fa2(a[1], b[1] ^ cin, c1, result[1], c2);
    fulladder fa3(a[2], b[2] ^ cin, c2, result[2], c3);
    fulladder fa4(a[3], b[3] ^ cin, c3, result[3], c4);
    fulladder fa5(a[4], b[4] ^ cin, c4, result[4], c5);
    fulladder fa6(a[5], b[5] ^ cin, c5, result[5], c6);
    fulladder fa7(a[6], b[6] ^ cin, c6, result[6], c7);
    fulladder fa8(a[7], b[7] ^ cin, c7, result[7], c8);
    fulladder fa9(a[8], b[8] ^ cin, c8, result[8], cout);
endmodule

//module fulladder(input a,b, cin, output sum, cout);
//    assign sum = a ^ b ^ cin;
//    assign cout = (a & b) | (cin & (a ^ b));
//endmodule
