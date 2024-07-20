`timescale 1 ps / 1 ps

module pe_tb
#(parameter FIRST = 0)
();

localparam D_W     = 8;
localparam D_W_ACC = 16;

localparam MEM_SZ = 2;

reg                     clk=1'b0;
reg     [1:0]           rst;
reg                     init;
reg     [D_W-1:0]       tb_in_a;
reg     [D_W-1:0]       tb_in_b;
wire    [D_W-1:0]       tb_out_b;
wire    [D_W-1:0]       tb_out_a;

wire    [(D_W_ACC)-1:0] D;
wire                    valid_D;

reg     [D_W_ACC-1:0]   mem [MEM_SZ-1:0];

integer now  = 0;
integer addr = 0;
reg r_init = 1'b0;

final
begin
  $writememh("pe_out.mem", mem);
end

always @(posedge clk)
begin
  now <= now + 1;

  // For this testbench to check the result,
  // valid_D must rise one cycle after init
  r_init <= init;
  if ((r_init == 1'b1) && (valid_D == 1'b1))
  begin
    mem[addr] <= D;
    addr <= (addr + 1) % MEM_SZ;
  end

  case (now)

    0:
    begin
      init     <= 1'b0;
      tb_in_a     <= 8'd00;
      tb_in_b     <= 8'd00;
    end
    
    1:
    begin
      init     <= 1'b0;
      tb_in_a     <= 8'd01;
      tb_in_b     <= 8'd02;
    end
    
    2:
    begin
      init     <= 1'b0;
      tb_in_a     <= 8'd03;
      tb_in_b     <= 8'd04;
    end
    
    3:
    begin
      init     <= 1'b0;
      tb_in_a     <= 8'd05;
      tb_in_b     <= 8'd06;
    end
    
    4:
    begin
      init     <= 1'b0;
      tb_in_a     <= 8'd07;
      tb_in_b     <= 8'd08;
    end
    
    5:
    begin
      init     <= 1'b0;
      tb_in_a     <= 8'd09;
      tb_in_b     <= 8'd10;
    end
    
    6:
    begin
      init     <= 1'b0;
      tb_in_a     <= 8'd11;
      tb_in_b     <= 8'd12;
    end
    
    7:
    begin
      init     <= 1'b0;
      tb_in_a     <= 8'd13;
      tb_in_b     <= 8'd14;
    end
    
    8:
    begin
      init     <= 1'b0;
      tb_in_a     <= 8'd15;
      tb_in_b     <= 8'd16;
    end
    
    9:
    begin
      init     <= 1'b1;
      tb_in_a     <= 8'd17;
      tb_in_b     <= 8'd18;
    end

    10:
    begin
      init     <= 1'b0;
      tb_in_a     <= 8'd19;
      tb_in_b     <= 8'd20;
    end
    
    11:
    begin
      init     <= 1'b0;
      tb_in_a     <= 8'd21;
      tb_in_b     <= 8'd22;
    end
    
    12:
    begin
      init     <= 1'b0;
      tb_in_a     <= 8'd23;
      tb_in_b     <= 8'd24;
    end
    
    13:
    begin
      init     <= 1'b0;
      tb_in_a     <= 8'd25;
      tb_in_b     <= 8'd26;
    end
    
    14:
    begin
      init     <= 1'b0;
      tb_in_a     <= 8'd27;
      tb_in_b     <= 8'd28;
    end
    
    15:
    begin
      init     <= 1'b0;
      tb_in_a     <= 8'd29;
      tb_in_b     <= 8'd30;
    end
    
    16:
    begin
      init     <= 1'b0;
      tb_in_a     <= 8'd31;
      tb_in_b     <= 8'd32;
    end
    
    17:
    begin
      init     <= 1'b1;
      tb_in_b     <= 8'd32;
      tb_in_a     <= 8'd31;
    end
    
    18:
    begin
      init     <= 1'b0;
      tb_in_a     <= 8'd31;
      tb_in_b     <= 8'd32;
    end
    
    19:
    begin
      init     <= 1'b0;
      tb_in_a     <= 8'd31;
      tb_in_b     <= 8'd32;
    end
    
    20:
    begin
      init     <= 1'b0;
      tb_in_a     <= 8'd31;
      tb_in_b     <= 8'd32;
    end

    30:
    begin
      $finish;
    end

    default:
    begin
      ;
    end
    endcase
end

pe 
#
(
  .D_W (D_W),
  .D_W_ACC (D_W_ACC)
)
pe_inst
(
  .clk    (clk),
  .rst    (rst[0]),
  .init   (init),
  .in_a   (tb_in_a),
  .in_b   (tb_in_b),
  .out_a  (tb_out_a),
  .out_b  (tb_out_b),
  .out_sum(D),
  .valid_D(valid_D)
);

always #1 clk = ~clk;

initial
begin
  $timeformat(-9, 2, " ns", 20);
  rst = 2'b11;
end

always @(posedge clk) begin
  rst <= rst>>1;
end

endmodule
