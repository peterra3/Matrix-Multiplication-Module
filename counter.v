`timescale 1 ps / 1 ps

module counter
#(
  parameter   WIDTH   = 32,
  parameter   HEIGHT  = 32

)
(
  input   wire clk,
  input   wire rst,
  input   wire enable_row_count,
  output  reg  [($clog2(WIDTH)?$clog2(WIDTH):1)-1:0]     pixel_cntr,
  output  reg  [($clog2(HEIGHT)?$clog2(HEIGHT):1)-1:0]    slice_cntr

);

// enter your RTL here
always@(posedge clk)
begin
  if (rst)
  begin
    pixel_cntr <= 0;
    slice_cntr <= 0;
    //initialize <= 0;
  end

  else if(enable_row_count)
  begin
    if((pixel_cntr + 1) % WIDTH == 0)
    begin
      slice_cntr <= (slice_cntr + 1) % HEIGHT;
      pixel_cntr <= (pixel_cntr + 1) % WIDTH;
      //initialize <= 1;
    end
    else
    pixel_cntr <= (pixel_cntr + 1) % WIDTH;
  end
  else
  pixel_cntr <= (pixel_cntr + 1) % WIDTH;
  //else
  //initialize <= initialize << 1; 
end

endmodule


// pixel counter always count 
