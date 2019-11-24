                               
//----------------------------------------------------------------------------------------
// File name:           key_debounce
// Last modified Date:  2018/4/24 9:56:36
// Last Version:        V1.1
// Descriptions:        ��������
//----------------------------------------------------------------------------------------
// Created by:          ����ԭ��
// Created date:        2018/3/29 10:55:56
// Version:             V1.0
// Descriptions:        The original version
//
//----------------------------------------------------------------------------------------
// Modified by:		    ����ԭ��
// Modified date:	    2018/4/24 9:56:36
// Version:			    V1.1
// Descriptions:	    ͨ������������е��������
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module key_debounce1(
    input            sys_clk,          //�ⲿ50Mʱ��
    input            sys_rst_n,        //�ⲿ��λ�źţ�����Ч
    
    input            key,              //�ⲿ��������
    output reg       key_flag,         //����������Ч�ź�
	output reg       key_value         //���������������  
    );

//reg define    
reg [31:0] delay_cnt;
reg        key_reg;

//*****************************************************
//**                    main code
//*****************************************************
always @(posedge sys_clk or negedge sys_rst_n) begin 
    if (!sys_rst_n) begin 
        key_reg   <= 1'b1;
        delay_cnt <= 32'd0;
    end
    else begin
        key_reg <= key;
        if(key_reg != key)             //һ����⵽����״̬�����仯(�а��������»��ͷ�)
            delay_cnt <= 32'd1000000;  //����ʱ����������װ�س�ʼֵ������ʱ��Ϊ20ms��
        else if(key_reg == key) begin  //�ڰ���״̬�ȶ�ʱ���������ݼ�����ʼ20ms����ʱ
                 if(delay_cnt > 32'd0)
                     delay_cnt <= delay_cnt - 1'b1;
                 else
                     delay_cnt <= delay_cnt;
             end           
    end   
end

always @(posedge sys_clk or negedge sys_rst_n) begin 
    if (!sys_rst_n) begin 
        key_flag  <= 1'b0;
        key_value <= 1'b1;          
    end
    else begin
        if(delay_cnt == 32'd1) begin   //���������ݼ���1ʱ��˵�������ȶ�״̬ά����20ms
            key_flag  <= 1'b1;         //��ʱ�������̽���������һ��ʱ�����ڵı�־�ź�
            key_value <= key;          //���Ĵ��ʱ������ֵ
        end
        else begin
            key_flag  <= 1'b0;
            key_value <= key_value; 
        end  
    end   
end
    
endmodule 