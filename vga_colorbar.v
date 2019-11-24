module vga_colorbar(
    input           sys_clk,        //系统时钟
    input           sys_rst_n,      //复位信号
    input 	[2:0]  	switch,
    //VGA接口                          
    output          vga_hs,         //行同步信号
    output          vga_vs,         //场同步信号
    output  [23:0]  vga_rgb,         //红绿蓝三原色输出 
    output 			vga_clk_w
    ); 

//wire define
wire         vga_clk_w;             //PLL分频得到25Mhz时钟
wire         locked_w;              //PLL输出稳定信号
wire         rst_n_w;               //内部复位信号
wire [23:0]  pixel_data_w;          //像素点数据
wire [11:0]  pixel_xpos_w;          //像素点横坐标
wire [11:0]  pixel_ypos_w;          //像素点纵坐标    
   
//*****************************************************
//**                    main code
//***************************************************** 
//待PLL输出稳定之后，停止复位
//assign rst_n_w = sys_rst_n && locked_w;
vga_pll u_vga_pll(
	.refclk			(sys_clk),
	.reset			(~sys_rst_n),
	
	.extlock		(locked_w),
	.clk0_out		(vga_clk_w)
	);

vga_driver u_vga_driver(
    .vga_clk        (vga_clk_w),    
    .sys_rst_n      (sys_rst_n),    

    .vga_hs         (vga_hs),       
    .vga_vs         (vga_vs),       
    .vga_rgb        (vga_rgb),      
    
    .pixel_data     (pixel_data_w), 
    .pixel_xpos     (pixel_xpos_w), 
    .pixel_ypos     (pixel_ypos_w)
    ); 
    
vga_display u_vga_display(
    .vga_clk        (vga_clk_w),
    .sys_rst_n      (sys_rst_n),
    .switch			(switch),
    .pixel_xpos     (pixel_xpos_w),
    .pixel_ypos     (pixel_ypos_w),
    .pixel_data     (pixel_data_w)
    );   
    
endmodule 