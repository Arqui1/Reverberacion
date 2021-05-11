transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/Alu.sv}
vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/andALU.sv}
vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/divALU.sv}
vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/flagZ.sv}
vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/mulALU.sv}
vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/muxALU.sv}
vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/orALU.sv}
vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/RegFile.sv}
vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/resALU.sv}
vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/shiftL.sv}
vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/shiftR.sv}
vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/sumALU.sv}
vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/flagN.sv}
vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/flagO.sv}
vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/PC.sv}
vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/sumador.sv}
vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/muxflag.sv}
vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/mux_.sv}
vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/Procesador.sv}
vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/Fetch.sv}
vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/pipeLine.sv}
vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/Decode.sv}
vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/Extend.sv}
vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/ControlUnit.sv}
vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/pipeDecotoExe.sv}
vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/pipeContUnitDtoE.sv}
vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/Execute.sv}
vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/CondUnit.sv}
vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/flipflop.sv}
vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/CondCheck.sv}
vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/pipeExetoMem.sv}
vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/pipeCondUnitEtoM.sv}
vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/pipeMemtoWBack.sv}
vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/ForwardUnit.sv}
vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/mux3_1.sv}
vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/StallUnit.sv}
vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/DataMemory.sv}
vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/InstrucMemory.sv}

vlog -sv -work work +incdir+C:/QuartusProjects/Proyecto2Arqui1 {C:/QuartusProjects/Proyecto2Arqui1/Procesador_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  Procesador_tb

add wave *
view structure
view signals
run -all
