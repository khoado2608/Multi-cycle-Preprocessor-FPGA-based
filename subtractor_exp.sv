module subtractor_exp(input [4:0] a, b, output [4:0] diff, output borrow);
    wire c1, c2, c3,c4;
    // Perform subtraction using full adders
    fulladder fa1(a[0], ~b[0], 1'b1, diff[0], c1);
    fulladder fa2(a[1], ~b[1], c1, diff[1], c2);
    fulladder fa3(a[2], ~b[2], c2, diff[2], c3);
    fulladder fa4(a[3], ~b[3], c3, diff[3], c4);
	 fulladder fa5(a[4], ~b[4], c4, diff[4], borrow);
endmodule