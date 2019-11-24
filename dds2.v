module dds2(

	input 	clk ,				//24MHz clock
	input 	rst_n ,			//key reset
//	output	clk0,			//pll 24MHz clock none
	
	output  [7:0] num ,		//mif data 8 bit
		
	input   switch1,		//control 4种波形
	input 	switch2,
	input 	switch3,		//扫频
	input 	switch4,
	input 	key_plus,		// 频率步进
	input   key_down,
	
	output  reg [1:0] LED,		//低电平有效+波形
	output    LED1
);
//wire [1:0] switch;
parameter fword = 31'd300 ;
parameter pword = 9'd256 ;
wire [7:0] num_juchi;
wire [7:0] num_sanjiao;
wire [7:0] num_sin;
wire [7:0] num_fangbo;
wire LED_flag;
reg [31:0] fword_data;

//assign num = num_fangbo;
reg [7:0] flag;
assign num[7:0] = flag[7:0];
assign LED1 = LED_flag;
//assign fword = fword_data[31:0];
//assign switch={switch1,switch2};


always@(*)
begin
	if(switch1 == 1'b0 && switch2 == 1'b0)
	begin
		LED = 2'b11;
	 	flag = num_sin;
	end
	else if(switch1 == 1'b0 && switch2 == 1'b1)
	begin 
		flag = num_sanjiao;
		LED = 2'b10;
	end
	else if(switch1 == 1'b1 && switch2 == 1'b1)
	begin 
		flag = num_juchi;
		LED = 2'b00;
	end 
	else if(switch1 == 1'b1 && switch2 == 1'b0)
	begin
		flag = num_fangbo;
		LED = 2'b01;
	end
end



dds #(.pword (pword) ,
		.fword (fword)
		)
u_dds(
	.clk (clk) ,
	.rst_n  (rst_n) ,
	.num_juchi (num_juchi),
	.num_sanjiao(num_sanjiao),
	.num_sin(num_sin),
	.num_fangbo(num_fangbo),
	.s1(switch3),
	.s2(switch4),
	.key1(key_plus),
	.key2(key_down),
	.LED1(LED_flag)
	);

/*pll1 u_pll1(
	
	 .clk(clk),
	 .rst_n(rst_n),
	 .clk0(clk0)
	 );
*/
endmodule
