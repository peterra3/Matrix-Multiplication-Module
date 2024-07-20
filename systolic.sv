`timescale 1 ps / 1 ps

module systolic
#
(
    parameter   D_W  = 8, //operand data width
    parameter   D_W_ACC = 16, //accumulator data width
    parameter   N   = 3,
    parameter   M   = 6
)
(
    input   wire                                        clk,
    input   wire                                        rst,
    input   wire                                        enable_row_count_A,
    output  wire    [$clog2(M)-1:0]                     pixel_cntr_A,
    output  wire    [($clog2(M/N)?$clog2(M/N):1)-1:0]   slice_cntr_A,
    output  wire    [($clog2(M/N)?$clog2(M/N):1)-1:0]   pixel_cntr_B,
    output  wire    [$clog2(M)-1:0]                     slice_cntr_B,
    output  wire    [$clog2((M*M)/N)-1:0]               rd_addr_A,
    output  wire    [$clog2((M*M)/N)-1:0]               rd_addr_B,
    input   wire    [D_W-1:0]                           A [N-1:0], //m0
    input   wire    [D_W-1:0]                           B [N-1:0], //m1
    output  wire    [D_W_ACC-1:0]                       D [N-1:0][N-1:0], //m2
    output  wire    [N-1:0]                             valid_D [N-1:0]
);


wire    [D_W-1:0]    out_a   [N-1:0][N-1:0];
wire    [D_W-1:0]    out_b   [N-1:0][N-1:0];
wire    [D_W-1:0]    in_a   [N-1:0][N-1:0];
wire    [D_W-1:0]    in_b   [N-1:0][N-1:0];

reg    [N-1:0] init_pe  [N-1:0];

integer p;
integer q;

control #
(
    .N        (N),
    .M        (M)
  )
  control_inst
  (

    .clk                  (clk),
    .rst                  (rst),
    .enable_row_count     (enable_row_count_A),

    .pixel_cntr_B         (pixel_cntr_B),
    .slice_cntr_B         (slice_cntr_B),

    .pixel_cntr_A         (pixel_cntr_A),
    .slice_cntr_A         (slice_cntr_A),

    .rd_addr_A            (rd_addr_A),
    .rd_addr_B            (rd_addr_B)
  );

// enter your RTL here




genvar i;
genvar j;
genvar k;

generate
  for(k = 0; k < N; k =k+1)
  begin 
    assign in_a[k][0] = A[k];
    assign in_b[0][k] = B[k];
  end

  for(i = 0; i < N; i = i + 1)
  begin
    for(j = 0; j < N; j = j + 1)
    begin
    pe#
    (
      .D_W_ACC   (D_W_ACC),
      .D_W (D_W)
    )
    pe_v
    (

      .clk                  (clk),
      .rst                  (rst),
      .init     (init_pe[i][j]),
      .in_a           (in_a[i][j]),
      .in_b           (in_b[i][j]),
      .out_sum           (D[i][j]),
      .out_a           (out_a[i][j]),
      .out_b           (out_b[i][j]),
      .valid_D           (valid_D[i][j])
    );

    if (j+1 <N)
    begin
      assign in_a[i][j+1] = out_a[i][j];
    end
    if (i+1 <N)
    begin
      assign in_b[i+1][j] = out_b[i][j];
    end
    end
  end
endgenerate

reg [$clog2(M)-1:0] tempA;
reg [$clog2(M)-1:0] tempB;

always @(posedge clk)
begin  
  if(pixel_cntr_A == 0 && slice_cntr_B == 0 && tempA == M-1 && tempB == M-1)
  begin
    init_pe[0][0] <= 1;
  end
  else 
  init_pe[0][0] <= 0;
  

  
  for(p = 0; p < N; p = p + 1)
  begin
    for(q = 0; q < N; q = q + 1)
    begin
      begin
        if (q+1 < N)
        init_pe[p][q+1] <= init_pe[p][q];
        if (p+1 < N)
        init_pe[p+1][q] <= init_pe[p][q];

      end
    end
  end
  tempA <= pixel_cntr_A;
  tempB <= slice_cntr_B;
end



endmodule


// do controls later
