set_param board.repoPaths "./board_files/"
create_project -force lab3 ./lab3_vivado -part xc7z020clg400-1
set_property board_part www.digilentinc.com:pynq-z1:part0:1.0 [current_project]
add_files systolic.sv pe.v counter.v pipe.sv control.v

update_compile_order -fileset sources_1
set_property top systolic [current_fileset]

set_property -name {STEPS.SYNTH_DESIGN.ARGS.MORE OPTIONS} -value {-mode out_of_context} -objects [get_runs synth_1]
set_property generic {N=4 M=8} [current_fileset]

launch_runs synth_1 -jobs 4
wait_on_run synth_1

open_run synth_1 -name synth_1
report_utilization -file utilization.txt
source grade.tcl
if { $GRADE == 1 } {
  exit
}
