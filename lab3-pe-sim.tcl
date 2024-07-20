vlib work
vlog -sv pe_tb.sv
vlog pe.v
vsim -novopt pe_tb
log -r /*
add wave sim:/pe_tb/pe_inst/*
config wave -signalnamewidth 1
run 10250 ns
