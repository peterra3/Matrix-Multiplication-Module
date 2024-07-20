xvlog control.v counter.v pe.v
xvlog -sv dut_tb.sv pipe.sv systolic.sv
xelab -debug typical dut_tb --generic_top "M=$1" -generic_top "N=$2" -s dut_tb
xsim dut_tb -gui -t sim.tcl
