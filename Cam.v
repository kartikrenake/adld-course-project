module Cam(
clk         , 
cam_enable  , 
cam_data_in , 
cam_hit_out , 
cam_addr_out ,
wr,data_in,
data_out
    );

parameter ADDR_WIDTH  = 4;
 parameter DEPTH       = 1 << ADDR_WIDTH;
 input                    clk;      
 input                    cam_enable; 
 input [DEPTH-1:0] data_in;
 input wr; 
 input  [DEPTH-1:0]       cam_data_in;  
 output                   cam_hit_out;  
 output [ADDR_WIDTH-1:0]  cam_addr_out; 
 output reg [DEPTH-1:0] data_out; 
 reg [ADDR_WIDTH-1:0]  cam_addr_out;
 reg                   cam_hit_out;
 reg [ADDR_WIDTH-1:0]  cam_addr_combo;
 reg                   cam_hit_combo;
 reg                   found_match;
 integer               i;
 
 reg [DEPTH-1:0]mem[0:15];
 
 always @(cam_data_in) 
 begin
    cam_addr_combo   = {ADDR_WIDTH{1'b0}};
    found_match      = 1'b0;
    cam_hit_combo    = 1'b0;
    for (i=0; i<DEPTH; i=i+1) 
	 begin
      if (cam_data_in[i] &&  ! found_match) 
		begin
        found_match     = 1'b1;
        cam_hit_combo   = 1'b1;
        cam_addr_combo  = i;
      end 
		else 
		begin
        found_match     = found_match;
        cam_hit_combo   = cam_hit_combo;
        cam_addr_combo  = cam_addr_combo;
      end
   end
  end
  
  always @(posedge clk) begin
    if (cam_enable) begin
      cam_hit_out  <=  cam_hit_combo;
      cam_addr_out <=  cam_addr_combo;
    end else begin
      cam_hit_out  <=  1'b0;
      cam_addr_out <=  {ADDR_WIDTH{1'b0}};
    end
  end
 
 always @(*)
 begin
 if(wr)
 mem[cam_addr_out] <= data_in;
 else
 data_out <= mem[cam_addr_out];
 end
 
endmodule
