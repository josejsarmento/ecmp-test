`timescale 1ns / 1ps
`include "iob_lib.vh"

module circuit
  #(
    parameter W=32
    )
  (
   `INPUT(rst,1),
   `INPUT(clk,1),
   `INPUT(en,1),
   `INPUT(x,W),
   `OUTPUT(y,W)
   );

   `SIGNAL(cnt, 7) //7-bit counter as iterator
   
   `SIGNAL(y_int, W) //internal y
   `SIGNAL(x_int, W) //internal x
   `SIGNAL(maximum, W)
   
   `SIGNAL2OUT(y, y_int) //connect maximum to output

   //y shift register 
   `REG_ARE(clk, rst, 1'b0, cnt!=99, x_int, y_int)
   `REG_ARE(clk, rst, 1'b0, cnt!=99, maximum, x)
   
   //iteration counter
   `COUNTER_ARE(clk, rst, cnt!=99, cnt)
   
  

   `COMB if(x_int > maximum) y_int = x_int; else y_int = maximum;

   
   
endmodule
