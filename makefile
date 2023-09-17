compile: vlib work; vlog -sv \ +acc \ +cover \ +fcover \ fifo_dut.v \ fifo_top.sv
 simulate: vsim -vopt work.testbench \ -voptargs=+acc=npr \ -assertdebug \ -l design.log \ -sva \ -coverage \ -c -do "log -r /*; add wave -r /*;
  coverage save -onexit -assert -directive -cvg -codeAll testbench_coverage.ucdb; run -all; exit" \ -wlf testbench.wlf all: make compile make simulate "makefile" 22L, 394C
