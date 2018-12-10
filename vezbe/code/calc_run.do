# Create the library
if [file exists work] {
    vdel -all
}
vlib work

# compile DUT
vlog +incdir+../dut \
    ../dut/calc_top.v

# compile testbench
vlog +acc -sv \
    +incdir+$env(UVM_HOME) \
    ./*calc_verif_pkg.sv \
    ./*calc_verif_top.sv

# run simulation
vsim calc_verif_top +UVM_TESTNAME=test_simple +UVM_VERBOSITY=UVM_HIGH -sv_seed random -do "run -all"