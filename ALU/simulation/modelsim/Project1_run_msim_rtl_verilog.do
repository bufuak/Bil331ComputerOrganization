transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/Verilogworkspace/Project1 {E:/Verilogworkspace/Project1/half_adder.v}
vlog -vlog01compat -work work +incdir+E:/Verilogworkspace/Project1 {E:/Verilogworkspace/Project1/full_adder.v}
vlog -vlog01compat -work work +incdir+E:/Verilogworkspace/Project1 {E:/Verilogworkspace/Project1/_4inputmux.v}
vlog -vlog01compat -work work +incdir+E:/Verilogworkspace/Project1 {E:/Verilogworkspace/Project1/_5bitand.v}
vlog -vlog01compat -work work +incdir+E:/Verilogworkspace/Project1 {E:/Verilogworkspace/Project1/_5bitadder.v}
vlog -vlog01compat -work work +incdir+E:/Verilogworkspace/Project1 {E:/Verilogworkspace/Project1/_5bitor.v}
vlog -vlog01compat -work work +incdir+E:/Verilogworkspace/Project1 {E:/Verilogworkspace/Project1/_5bitxor.v}
vlog -vlog01compat -work work +incdir+E:/Verilogworkspace/Project1 {E:/Verilogworkspace/Project1/likeALU_demo.v}
vlog -vlog01compat -work work +incdir+E:/Verilogworkspace/Project1 {E:/Verilogworkspace/Project1/likealu.v}

