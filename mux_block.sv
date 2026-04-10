module mux_block(
    input [8:0] din,
    input [8:0] r0,
    input [8:0] r1,
    input [8:0] r2,
    input [8:0] r3,
    input [8:0] r4,
    input [8:0] r5,
    input [8:0] r6,
    input [8:0] r7,
    input [8:0] g_addsub,
    input [8:0] r0out,
    input _R0out,
    input _R1out,
    input _R2out,
    input _R3out,
    input _R4out,
    input _R5out,
    input _R6out,
    input _R7out,
    input _Gout ,
    input _Dinout,
	 input _GFout,
	 input [8:0] gf_addsub,
    output reg [8:0] bus_wires
);

always_comb begin
  // Default assignment to avoid uninitialized state
    bus_wires = 9'b0;
    // Ensure that only one assignment happens at a time
    if (_R0out)   bus_wires = r0;
    else if (_R1out)   bus_wires = r1;
    else if (_R2out)   bus_wires = r2;
    else if (_R3out)   bus_wires = r3;
    else if (_R4out)   bus_wires = r4;
    else if (_R5out)   bus_wires = r5;
    else if (_R6out)   bus_wires = r6;
    else if (_R7out)   bus_wires = r7;
    else if (_Gout)    bus_wires = g_addsub;
    else if (_Dinout)  bus_wires = din;
	 else if (_GFout)	  bus_wires = gf_addsub;
end

endmodule
