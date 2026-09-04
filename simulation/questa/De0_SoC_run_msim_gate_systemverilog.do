transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -sv -work work +incdir+. {De0_SoC.svo}

vlog -sv -work work +incdir+C:/Users/danie/Downloads/ARM\ CPU {C:/Users/danie/Downloads/ARM CPU/CPU_parameters.sv}
vlog -sv -work work +incdir+C:/Users/danie/Downloads/ARM\ CPU {C:/Users/danie/Downloads/ARM CPU/De0_SoC.sv}
vlog -sv -work work +incdir+C:/Users/danie/Downloads/ARM\ CPU {C:/Users/danie/Downloads/ARM CPU/alu.sv}
vlog -sv -work work +incdir+C:/Users/danie/Downloads/ARM\ CPU {C:/Users/danie/Downloads/ARM CPU/register_file.sv}
vlog -sv -work work +incdir+C:/Users/danie/Downloads/ARM\ CPU {C:/Users/danie/Downloads/ARM CPU/add32.sv}
vlog -sv -work work +incdir+C:/Users/danie/Downloads/ARM\ CPU {C:/Users/danie/Downloads/ARM CPU/add1.sv}
vlog -sv -work work +incdir+C:/Users/danie/Downloads/ARM\ CPU {C:/Users/danie/Downloads/ARM CPU/program_counter.sv}
vlog -sv -work work +incdir+C:/Users/danie/Downloads/ARM\ CPU {C:/Users/danie/Downloads/ARM CPU/instruction_memory.sv}
vlog -sv -work work +incdir+C:/Users/danie/Downloads/ARM\ CPU {C:/Users/danie/Downloads/ARM CPU/decoder.sv}
vlog -sv -work work +incdir+C:/Users/danie/Downloads/ARM\ CPU {C:/Users/danie/Downloads/ARM CPU/register_rotator.sv}
vlog -sv -work work +incdir+C:/Users/danie/Downloads/ARM\ CPU {C:/Users/danie/Downloads/ARM CPU/mux_2_to_1.sv}
vlog -sv -work work +incdir+C:/Users/danie/Downloads/ARM\ CPU {C:/Users/danie/Downloads/ARM CPU/persistent_flags.sv}

vsim -t 1ps -L altera_ver -L altera_lnsim_ver -L cyclonev_ver -L lpm_ver -L sgate_ver -L cyclonev_hssi_ver -L altera_mf_ver -L cyclonev_pcie_hip_ver -L gate_work -L work -voptargs="+acc"  cpu testbench

add wave *
view structure
view signals
run -all
