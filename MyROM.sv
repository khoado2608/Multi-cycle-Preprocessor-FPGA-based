module MyROM (
    input logic CLK,              // Clock input
    input logic [4:0] ADDRESS,    // Address input (5 bits for 32 locations)
    input logic [8:0] DATAIN,
    input logic wr_en,
    output logic [8:0] DATAOUT    // 9-bit output data
);

    reg [8:0] ROM [0:31];         // Declare ROM with 32 addresses (9 bits wide)

    // Initialize ROM from MIF file
    initial begin
        $readmemb("rom.mif", ROM); // Load MIF file into ROM
    end

    // Read from ROM on clock edge
    always_ff @(posedge CLK) begin
        if (wr_en) begin
            ROM[ADDRESS] <= DATAIN;
        end else begin
            DATAOUT <= ROM[ADDRESS];    // Output data from ROM at the specified address
        end
    end

endmodule : MyROM