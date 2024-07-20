`timescale 1 ps / 1 ps

module control
  #(
    parameter   N   = 3,
    parameter   M   = 6
  )
  (
    input   wire                                        clk,
    input   wire                                        rst,
    input   wire                                        enable_row_count,
    output  wire    [$clog2(M)-1:0]                     pixel_cntr_A,
    output  wire    [($clog2(M/N)?$clog2(M/N):1)-1:0]   slice_cntr_A,
    output  wire    [($clog2(M/N)?$clog2(M/N):1)-1:0]   pixel_cntr_B,
    output  wire    [$clog2(M)-1:0]                     slice_cntr_B,
    output  wire    [$clog2((M*M)/N)-1:0]               rd_addr_A,
    output  wire    [$clog2((M*M)/N)-1:0]               rd_addr_B
  );

// enter your RTL here
assign rd_addr_A = slice_cntr_A*M+pixel_cntr_A;
assign rd_addr_B = pixel_cntr_B*M+slice_cntr_B;

counter#
(
  .WIDTH  (M),
  .HEIGHT (M/N)
)
counter_B
(

  .clk                  (clk),
  .rst                  (rst),
  .enable_row_count     (1'b1),
  .pixel_cntr           (slice_cntr_B),
  .slice_cntr           (pixel_cntr_B)
);


counter#
(
  .WIDTH  (M),
  .HEIGHT (M/N)
)
counter_A
(

  .clk                  (clk),
  .rst                  (rst),
  .enable_row_count     (enable_row_count),
  .pixel_cntr           (pixel_cntr_A),
  .slice_cntr           (slice_cntr_A)
);

endmodule
