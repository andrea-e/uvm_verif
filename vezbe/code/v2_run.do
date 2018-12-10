# create library
if [file exists work] {
    vdel -all
}
vlib work

# compile everything
vlog +acc -sv v2_top.sv 

# run simulation
vsim top