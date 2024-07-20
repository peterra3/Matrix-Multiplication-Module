xvlog control.v
xvlog counter.v
xvlog -sv control_tb.sv
xelab -debug typical control_tb -s control_tb

if (( $1 > 0 )) then
    xsim control_tb -gui -t xsim-gui.tcl
else
    xsim control_tb -t xsim.tcl
fi
