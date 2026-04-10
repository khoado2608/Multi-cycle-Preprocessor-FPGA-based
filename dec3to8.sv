module dec3to8(W, En, Y);
    input [2:0] W;    // W = IR[5:3]
    input En;
    output [7:0] Y;   // Now Y[0] corresponds to R0 and Y[7] to R7.
    logic [7:0] Y;

    always @(W or En) begin
        if (En)
            case (W)
                3'b000: Y = 8'b00000001; // Y[0] = 1 (R0)
                3'b001: Y = 8'b00000010; // Y[1] = 1 (R1)
                3'b010: Y = 8'b00000100; // Y[2] = 1 (R2)
                3'b011: Y = 8'b00001000; // Y[3] = 1 (R3)
                3'b100: Y = 8'b00010000; // Y[4] = 1 (R4)
                3'b101: Y = 8'b00100000; // Y[5] = 1 (R5)
                3'b110: Y = 8'b01000000; // Y[6] = 1 (R6)
                3'b111: Y = 8'b10000000; // Y[7] = 1 (R7)
            endcase
        else
            Y = 8'b00000000; // All outputs disabled
    end
endmodule