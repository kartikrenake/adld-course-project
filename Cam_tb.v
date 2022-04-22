module TB;

	// Inputs
	reg clk;
	reg cam_enable,wr;
	reg [15:0]data_in;
	reg [15:0] cam_data_in;

	// Outputs
	wire cam_hit_out;
	wire [3:0] cam_addr_out;
	wire [15:0]data_out;

	// Instantiate the Unit Under Test (UUT)
	Cam uut (
		.clk(clk), 
		.cam_enable(cam_enable), 
		.cam_data_in(cam_data_in), 
		.cam_hit_out(cam_hit_out), 
		.cam_addr_out(cam_addr_out),
		.wr(wr),
		.data_in(data_in),
		.data_out(data_out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		#100;
        
		// Add stimulus here

	end
	
	always begin #5 clk = ~clk; end
	
	initial begin
	cam_enable = 0;
	#100
	cam_enable = 1;
	wr = 1;
	data_in = 16'haf;
	cam_data_in = 16'h0251;
	#100
	wr = 0;
	#100
	wr = 1;
	data_in = 16'hf;
	cam_data_in = 16'h0252;
	#100
	wr = 0;
	#100
	wr = 1;
	data_in = 16'h12;
	cam_data_in = 16'h0069;
	#100
	wr = 0;
	end
      
endmodule
