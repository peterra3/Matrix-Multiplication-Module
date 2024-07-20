lab3a: lab3.pdf lab3.png

lab3.pdf: lab3.dot
	dot -Tpdf $< > $@

lab3.png: lab3.json
	wavedrom-cli -i $< -p $@

modelsim:
	echo "set GRADE 0" > grade.tcl
	python make_mem.py $M $N
	echo "set M $M" > size.tcl
	echo "set N $N" >> size.tcl
	vsim -do lab3-sim.tcl

modelsim-txt:
	echo "set GRADE 0" > grade.tcl
	python make_mem.py $M $N
	echo "set M $M" > size.tcl
	echo "set N $N" >> size.tcl
	vsim -c -do lab3-sim.tcl

xsim: 
	python make_mem.py $M $N
	./lab3-xsim.sh $M $N


vivado:	
	rm -rf vivado*
	rm -rf lab3_vivado
	echo "set GRADE 0" > grade.tcl
	vivado -source lab3-syn.tcl

test:
	echo "set GRADE 1" > grade.tcl
	python make_mem.py $M $N
	echo "set M $M" > size.tcl
	echo "set N $N" >> size.tcl
	vsim -c -do lab3-sim.tcl
	python test.py $N > result.$M.$N.txt
	cat result.$M.$N.txt
	
test-pe:
	make clean
	vsim -c -do lab3-pe-sim.tcl
	python test_pe.py

test-pe-xsim:
	make clean
	zsh lab3-pe-sim.sh 0
	python test_pe.py

sim-pe-modelsim:
	make clean
	vsim -do lab3-pe-sim.tcl

sim-pe-xsim:
	make clean
	zsh lab3-pe-sim.sh 1

test-control:
	make clean
	vsim -c -do lab3-control-sim.tcl
	python test_control.py

test-control-xsim:
	make clean
	zsh lab3-control-sim.sh 0
	python test_control.py

sim-control-modelsim:
	make clean
	vsim -do lab3-control-sim.tcl

sim-control-xsim:
	make clean
	zsh lab3-control-sim.sh 1

grade:
	echo "set GRADE 1" > grade.tcl
	./grade.sh

clean:
	rm -Rf *.log *.jou size.tcl vivado.* work transcript lab3.vcd vsim.wlf lab3_vivado A.mem B.mem D.mem pe_out.mem control_out.mem result.*.txt

