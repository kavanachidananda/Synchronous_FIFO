VLOG =  /tools/mentor/questasim/questasim/bin/vlog

VSIM = /tools/mentor/questasim/questasim/bin/vsim

all: comp_rtl comp run

comp_rtl:
	$(VLOG) +cover=bcstfex /hwetools/work_area/frontend/kavanachidananda/Synchronou_FIFO/fifo_dut.sv

comp: 
	$(VLOG) +incdir+/hwetools/work_area/frontend/kavanachidananda/uvm-1.1d/src \
/hwetools/work_area/frontend/kavanachidananda/uvm-1.1d/src/uvm_pkg.sv \ 
+define+UVM_NO_DPI /hwetools/work_area/frontend/kavanachidananda/Synchronous_FIFO/fifo_interface.sv \ 
/hwetools/work_area/frontend/kavanachidananda/Synchronous_FIFO/fifo_top.sv
  

run: 
	$(VSIM)   -coverage  -novopt top +fifo_top=fifo_test-l vsim.log -c
       ##add wave -r 
