vlib work
vlog -sv control_tb.sv
vlog control.v counter.v
vsim -novopt control_tb
log -r /*
add wave sim:/control_tb/control_inst/*
config wave -signalnamewidth 1
run 1000 ns
