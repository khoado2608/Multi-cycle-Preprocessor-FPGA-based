module adder6bit (
    input  [5:0] A,
    input  [5:0] B,
    input        cin, // Initial carry input
    output [5:0] sum,
    output       cout // Final carry output
);

    wire c1, c2, c3, c4, c5; // Internal carry wires

    fulladder FA0 (
        .a(A[0]),
        .b(B[0]),
        .cin(cin),
        .sum(sum[0]),
        .cout(c1)
    );

    fulladder FA1 (
        .a(A[1]),
        .b(B[1]),
        .cin(c1),
        .sum(sum[1]),
        .cout(c2)
    );

    fulladder FA2 (
        .a(A[2]),
        .b(B[2]),
        .cin(c2),
        .sum(sum[2]),
        .cout(c3)
    );

    fulladder FA3 (
        .a(A[3]),
        .b(B[3]),
        .cin(c3),
        .sum(sum[3]),
        .cout(c4)
    );

    fulladder FA4 (
        .a(A[4]),
        .b(B[4]),
        .cin(c4),
        .sum(sum[4]),
        .cout(c5)
    );

    fulladder FA5 (
        .a(A[5]),
        .b(B[5]),
        .cin(c5),
        .sum(sum[5]),
        .cout(cout)
    );

endmodule