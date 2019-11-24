module control (
		input clk ,
		input rst_n ,
		
		input s1,
		input s2,
		
		input key_plus,
		input key_down,
		
		output [7:0] addr,
		output  LED1
);
parameter pword = 9'd256 ;
parameter fword = 32'd300 ;
reg [31:0] addr_num ;
reg [31:0] fword_data = 32'd3000;
reg LED;
wire key_value_plus;
wire key_value_down;
wire key_flag_plus;
wire key_flag_down;
assign LED1 = LED;
assign addr = addr_num[31:24] ;

/*always@(*)
begin 
	if(s1 == 1'b0 && s2 == 1'b0)
		fword_data = 31'd6_000;
	else if(s1 == 1'b0 && s2 == 1'b1)
		fword_data = 31'd10_000;
	else if(s1 == 1'b1 && s2 == 1'b1)
		fword_data = 31'd20_000;
	else if(s1 == 1'b1 && s2 == 1'b0)
		fword_data = 31'd30_000;

end*/

always @(posedge clk or negedge rst_n )
begin 
	if(rst_n == 1'b0)
	begin 
		addr_num[31:24] <= pword ;
		addr_num [23:0] <= 24'b0 ;		
	end
	else 
		addr_num <= addr_num + fword_data ;
		
end 

always@(posedge clk or negedge rst_n)
begin
	if(rst_n == 1'b0)
	begin
		fword_data <= 32'd3000;
	end
	else if(key_flag_plus && (~key_value_plus) && s1 == 1'b0)
		fword_data <= fword_data + 32'd100;
	else if(key_flag_down && (~key_value_down) && s1 == 1'b0)
		fword_data <= fword_data - 32'd100;
	else if(s1 == 1'b1)
		begin
			LED <= 1'b0;
			fword_data <= fword_data + 32'd100;
		if(fword_data == 32'd8_000_100)
			fword_data <= 32'd3000;
		else 
			fword_data <= fword_data + 32'd100;
		end 

end

/*always@(posedge clk or negedge rst_n)
begin 
	if(rst_n == 1'b0)
		fword_data <= 32'd3000;
	else if(s1 == 1'b1)
	begin
		fword_data <= fword_data + 32'd100;
		//LED <= 1'b0;
	end 
	else if(fword_data == 32'd8_000_000)
		fword_data <= 32'd3000;
	else 
		fword_data <= fword_data + 1'b0;
		
end */		
		
key_debounce u_key_debounce(
     .sys_clk(clk),          //外部24M时钟
     .sys_rst_n(rst_n),        //外部复位信号，低有效
    
     .key(key_plus),              //外部按键输入
     .key_flag(key_flag_plus),         //按键数据有效信号
	 .key_value(key_value_plus)         //按键消抖后的数据  
    );
  
key_debounce1 u_key_debounce1(
     .sys_clk(clk),          //外部24M时钟
     .sys_rst_n(rst_n),        //外部复位信号，低有效
    
     .key(key_down),              //外部按键输入
     .key_flag(key_flag_down),         //按键数据有效信号
	 .key_value(key_value_down)         //按键消抖后的数据  
    );
    
    
endmodule 