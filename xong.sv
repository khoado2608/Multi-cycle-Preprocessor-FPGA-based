module xong(
    input clk,
    input reset,
    input run,
    output logic [8:0] day_bus_cu,
    output logic done_out,
    output logic [8:0] r0reg,
    output logic [8:0] r1reg,
	 output logic [8:0] r2reg,
	 output logic [8:0] r3reg,
	 output logic [8:0] r4reg,
	 output logic [8:0] r5reg,
	 output logic [8:0] r6reg,
	 output logic [8:0] r7reg,
	 output logic [8:0] dout_reg,
	 output logic [8:0] day_tu_g,
	 output logic [4:0] statenow,
	 output logic [8:0] address,
	 output logic [8:0] IR,
	 output logic [8:0] dout,
	 output logic [8:0] leds,
	 output logic [8:0] day_tu_gfin,
	 output day_gfin,
	 output day_afin,
	 output day_gfout,
	 output day_addsubf,
	 output logic wd,
	 output logic incre_pc,
	 output logic addrin_signal,
	 output logic dout_signal,
	 output logic r7_en_signal,
	 output logic r7_out_signal,
	 output logic r7test,
	 output logic g_signal,
	 output logic a_signal,
	 output logic en_rom,
	 output logic en_led,
	 output logic [8:0] pc
);
logic [8:0] R0_from_reg;
logic [8:0] R1_from_reg;
logic [8:0] R2_from_reg;
logic [8:0] R3_from_reg;
logic [8:0] R4_from_reg;
logic [8:0] R5_from_reg;
logic [8:0] R6_from_reg;
logic [8:0] R7_from_reg;
logic [8:0] G_from_adder;
logic [8:0] A_from_bus;
logic [7:0] Rinmoi;
logic [7:0] Routmoi;
logic goutwire;
logic dinoutwire;
logic ainwire;
logic ginwire;
logic addsubwire;
logic addrinwire;
logic doutinwire;
logic wdwire;
logic incrpcwire;

logic addsubf_wire;
logic afin_wire;
logic gfin_wire;
logic gfout_wire;

logic [8:0] R7_to_mux;
assign addrin_signal = addrinwire;
assign dout_signal = doutinwire;
assign r0reg = R0_from_reg;
assign r1reg = R1_from_reg;
assign r2reg = R2_from_reg;
assign r3reg = R3_from_reg;
assign r4reg = R4_from_reg;
assign r5reg = R5_from_reg;
assign r6reg = R6_from_reg;
assign r7reg = R7_to_mux;
assign day_tu_g = G_from_adder;
assign dout = dout_reg;
assign incre_pc = incrpcwire;
logic en1, en2ne, en3, en4;
logic [8:0] GFin_from_adder;
MyROM banhmiramram(.CLK(clk), .ADDRESS(address), .DATAIN(dout), .wr_en(en2ne), .DATAOUT(IR));
mux_block bus_mux (
    .din(IR),
    .r0(R0_from_reg), .r1(R1_from_reg), .r2(R2_from_reg), .r3(R3_from_reg),
    .r4(R4_from_reg), .r5(R5_from_reg), .r6(R6_from_reg), .r7(R7_to_mux),
    .g_addsub(G_from_adder), .gf_addsub(GFin_from_adder), 
    ._R0out(Routmoi[0]), ._R1out(Routmoi[1]), ._R2out(Routmoi[2]), 
    ._R3out(Routmoi[3]), ._R4out(Routmoi[4]), ._R5out(Routmoi[5]), 
    ._R6out(Routmoi[6]), ._R7out(r7test|r7_out_signal), ._GFout(gfout_wire),
    ._Gout(goutwire),
    ._Dinout(dinoutwire),
    .bus_wires(day_bus_cu)
);

// Register Update with Correct Control Signals
connect_reg mulreg(
    .bus_wire(day_bus_cu),
    .clk(clk),
    .rst(reset),
    .R0_in(Rinmoi[0]), .R1_in(Rinmoi[1]),
    .R2_in(Rinmoi[2]), .R3_in(Rinmoi[3]),
    .R4_in(Rinmoi[4]), .R5_in(Rinmoi[5]),
    .R6_in(Rinmoi[6]), .addr_in(addrinwire), .dout_in(doutinwire),
    .R0_wire(R0_from_reg), .R1_wire(R1_from_reg),
    .R2_wire(R2_from_reg), .R3_wire(R3_from_reg),
    .R4_wire(R4_from_reg), .R5_wire(R5_from_reg),
    .R6_wire(R6_from_reg), .addr_wire(address), .dout_wire(dout_reg)
);

D_flipflop wdff(.clk(clk), .reset(reset), .D(wdwire), .Q(wd));

counterr7 cclemon(.pc(day_bus_cu), .R7_in(Rinmoi[7]), .rst(reset), .incr_pc(incrpcwire), .clk(clk),
             .R7_wire(R7_to_mux), .pc_now(pc));
             
addsub au(.from_A(day_bus_cu), .clk(clk), .rst(reset), .A_in(ainwire),
            .G_in(ginwire), .from_bus(day_bus_cu),
             .addsub(addsubwire), .from_G(G_from_adder));

processor proc(.IR(IR), .clk(clk), .rst(reset), .run(run), .done(done_out), 
             .Rinnew(Rinmoi), .Routnew(Routmoi), .goutsig(goutwire), .ainsig(ainwire), .addsubsig(addsubwire), .ginsig(ginwire),
				 .dinsig(dinoutwire), .cur_st(statenow), .addrinsig(addrinwire), .doutinsig(doutinwire), 
                 .wdsig(wdwire), .incrpcsig(incrpcwire), .afin(afin_wire), .gfin(gfin_wire), .gfout(gfout_wire),
					 .addsubf(addsubf_wire), .r7_test(r7test), .G(G_from_adder));
					 
addsub_fpu fpu(.fpu_in(day_bus_cu), .clk(clk), .rst(reset),
				.AFin(afin_wire), .GFin(gfin_wire), .AddSubF(addsubf_wire), .from_bus(day_bus_cu), 
				.GF_out(GFin_from_adder));
				
assign en1 = ~(address[7] | address[8]);
assign en2ne = wd & en1;
assign en3 = ~(~address[7] | address[8]);
assign en4 = wd & en3;
LEDs led(.clk(clk), .reset(reset),.enable(en4), .D(dout), .Q(leds));
assign en_rom = en2ne;
assign en_led = en4;
assign r7_en_signal = Rinmoi[7];
assign r7_out_signal = Routmoi[7];
assign g_signal = ginwire;
assign a_signal = ainwire;
assign day_afin = afin_wire;
assign day_gfin = gfin_wire;
assign day_gfout = gfout_wire;
assign day_addsubf = addsubf_wire;
assign day_tu_gfin = GFin_from_adder;
endmodule
