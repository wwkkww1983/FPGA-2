
module top(
	input           sys_clk,        //系统时钟
    input           sys_rst_n,      //复位信号
//	output	clk0,			//pll 24MHz clock none
	output  [7:0] num ,		//mif data 8 bit
	input   switch1,		//control 4种波形
	input 	switch2,
	input 	switch3,		//扫频
	input 	switch4,
	input 	key_plus,		// 频率步进
	input   key_down,
	
	output  [1:0] LED,		//低电平有效+波形
	output    LED1,
	output  DA_CLK,

//    input 	[1:0]  	switch,
    //VGA接口                          
    output          vga_hs,         //行同步信号
    output          vga_vs,         //场同步信号
    output  [23:0]  vga_rgb,         //红绿蓝三原色输出 
    output       	vga_clk_w 
);
assign DA_CLK = sys_clk;
vga_colorbar u_vga_colorbar(
    .sys_clk            (sys_clk),        //系统时钟
    .sys_rst_n          (sys_rst_n),      //复位信号
    .switch             ({switch1,switch2,switch3}),                   
    .vga_hs             (vga_hs),         //行同步信号
    .vga_vs             (vga_vs),         //场同步信号
    .vga_rgb            (vga_rgb),      //红绿蓝三原色输出 
    .vga_clk_w          (vga_clk_w)
    ); 

 dds2 u_dds2(

	.clk                (sys_clk),				//24MHz clock
	.rst_n              (sys_rst_n),			//key reset
//	output	clk0,			//pll 24MHz clock none
	
	.num                (num),		//mif data 8 bit		
	.switch1            (switch1),		//control 4种波形
    .switch2            (switch2),
    .switch3            (switch3),		//扫频
    .switch4            (switch4),
    .key_plus           (key_plus),		// 频率步进
	.key_down           (key_down),
	
	.LED                (LED),		//低电平有效+波形
	.LED1               (LED1)
	);
endmodule