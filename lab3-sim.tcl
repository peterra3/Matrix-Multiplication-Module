source grade.tcl
if {$GRADE == 1 } {
  onerror { quit -f }
}
source size.tcl
vlib work
vlog -sv dut_tb.sv pipe.sv systolic.sv 
vlog counter.v pe.v control.v
vsim -novopt -GM=$M -GN=$N dut_tb
log -r /*
add wave sim:/dut_tb/*
run 10250 ns
if {$GRADE == 1 } {
  exit
}
