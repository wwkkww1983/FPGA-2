module dds(
		input clk ,
		input rst_n ,
		
		input s1,
		input s2,
		
		input key1,
		input key2,
		
		output   LED1,		
		output [7:0] num_juchi, 
		output [7:0] num_sanjiao,
		output [7:0] num_sin,
		output [7:0] num_fangbo
);

parameter pword = 9'd256 ;
parameter fword = 31'd300;
wire [7:0] addrc ;
wire [7:0]num_data_juchi;
wire [7:0]num_data_sanjiao;
wire [7:0]num_data_sin;
wire [7:0]num_data_fangbo;
assign num_juchi = num_data_juchi;
assign num_sanjiao = num_data_sanjiao;
assign num_sin = num_data_sin;
assign num_fangbo = num_data_fangbo;
control #(.pword (pword),
	      .fword(fword))
u_control (
	.clk(clk) ,
	.rst_n (rst_n ) ,
	.addr (addrc),
	.s1(s1),
	.s2(s2),
	.LED1(LED1),
	.key_plus(key1),
	.key_down(key2)
	);
	
dds_rom u_dds_rom (
		.addra (addrc) ,
		.clka (clk)  ,
		.doa(num_data_juchi),
		.rsta(~rst_n)
		
);
dds_rom1 u_dds_rom1(
 	.doa(num_data_sanjiao),
 	.addra(addrc), 
 	.clka(clk),
 	.rsta(~rst_n));
dds_rom2 u_dds_rom2( 
	.doa(num_data_sin), 
	.addra(addrc), 
	.clka(clk), 
	.rsta(~rst_n) );
dds_rom3 u_dds_rom3( 
	.doa(num_data_fangbo), 
	.addra(addrc), 
	.clka(clk), 
	.rsta(~rst_n)
	 );

endmodule 