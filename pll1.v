module pll1(
	input clk,
	input rst_n,
	output clk0
	);
	wire lock;
pll u_pll(
		.refclk(clk),
		.reset(!rst_n),
		.extlock(lock),
		.clk0_out(clk0)
	);		
endmodule