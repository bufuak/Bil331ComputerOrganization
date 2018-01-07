transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+K:/Verilogworkspace/Project3 {K:/Verilogworkspace/Project3/mips_core.v}
vlog -vlog01compat -work work +incdir+K:/Verilogworkspace/Project3 {K:/Verilogworkspace/Project3/ALU.v}
vlog -vlog01compat -work work +incdir+K:/Verilogworkspace/Project3 {K:/Verilogworkspace/Project3/mips_instr_mem.v}
vlog -vlog01compat -work work +incdir+K:/Verilogworkspace/Project3 {K:/Verilogworkspace/Project3/mips_data_mem.v}
vlog -vlog01compat -work work +incdir+K:/Verilogworkspace/Project3 {K:/Verilogworkspace/Project3/mips_registers.v}

