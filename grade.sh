#!/bin/zsh

make clean
lint1=`verilator -GM=6 -GN=3 -Wall -Wno-DECLFILENAME -Wno-width --lint-only systolic.sv 2>&1 | grep Error | wc -l`
lint2=`verilator -Wall -Wno-DECLFILENAME -Wno-width --lint-only pe.v 2>&1 | grep Error | wc -l`
lint3=`verilator -Wall -Wno-DECLFILENAME -Wno-width --lint-only counter.v 2>&1 | grep Error | wc -l`
lint4=`verilator -Wall -Wno-DECLFILENAME -Wno-width --lint-only control.v 2>&1 | grep Error | wc -l`

make test M=4 N=4
sim1=`cat result.4.4.txt | grep "Thank Mr. Goose" | wc -l`
make clean
make test M=8 N=4
sim2=`cat result.8.4.txt | grep "Thank Mr. Goose" | wc -l`
make clean
make test M=16 N=4
sim3=`cat result.16.4.txt | grep "Thank Mr. Goose" | wc -l`
make clean
make test M=8 N=8
sim4=`cat result.8.8.txt | grep "Thank Mr. Goose" | wc -l`

vivado -mode tcl -source lab3-syn.tcl
gold_lut=`cat golden.utilization.txt | grep "Slice LUTs" | cut -d"|" -f 3 | sed s/\ //g`
gold_ff=`cat golden.utilization.txt | grep "Slice Registers" | cut -d"|" -f 3 | sed s/\ //g`
synth_lut=`cat utilization.txt | grep "Slice LUTs" | cut -d"|" -f 3 | sed s/\ //g`
synth_ff=`cat utilization.txt | grep "Slice Registers" | cut -d"|" -f 3 | sed s/\ //g`
diff_lut=`expr $synth_lut - $gold_lut`
diff_ff=`expr $synth_ff - $gold_ff`


if [[ $sim1 -gt 0 ]]; then sim1=20; else sim1=0; fi
if [[ $sim2 -gt 0 ]]; then sim2=20; else sim2=0; fi
if [[ $sim3 -gt 0 ]]; then sim3=20; else sim3=0; fi
if [[ $sim4 -gt 0 ]]; then sim4=20; else sim4=0; fi
if [[ $lint1 -gt 0 ]]; then lint1=0; else lint1=2; fi
if [[ $lint2 -gt 0 ]]; then lint2=0; else lint2=2; fi
if [[ $lint3 -gt 0 ]]; then lint3=0; else lint3=3; fi
if [[ $lint4 -gt 0 ]]; then lint4=0; else lint4=3; fi
if [[ $diff_lut -gt 351 && $diff_ff -gt 181 ]]; then synth=0; else synth=5; fi

sim=`expr $sim1 + $sim2 + $sim3 + $sim4`
lint=`expr $lint1 + $lint2 + $lint3 + $lint4`
echo "$sim,$lint,$synth" > grade.csv

