#!/bin/bash

clean_tmp() {
    rm -r tmp/verif/v*.sv
    rm -r tmp/verif/tests/*.sv
    rm -r tmp/verif/sequences/*.sv
}

zip_tmp() {
    cd tmp
    zip -r ../../to_upload/vezba$1 ./*
    cd ../
}

copy_calc() {
    cp tests/v$1*.sv tmp/verif/tests
    cp sequences/v$1*.sv tmp/verif/sequences
    cp v$1_calc*.sv tmp/verif
}

prepare_v() {
    clean_tmp
    copy_calc $1
    zip_tmp $1
}


# prepare folder
mkdir -p to_upload
rm -r to_upload/*

# copy pdf-s
for i in {1..13}
do
    if [ ! -f vezba$i.pdf ]; then
        echo "Error: vezba$i.pdf not found."
    else
        cp vezba$i.pdf to_upload/
    fi
done

# zip and copy code files
cd code

# vezba 1
zip ../to_upload/vezba1 v1_counter.sv v1_run.do v1_simple_tb.sv

# vezba 2
zip ../to_upload/vezba2 v2_queue_examples.sv v2_driver.sv v2_memory.sv v2_memory_if.sv v2_memory_pkg.sv v2_run.do v2_top.sv v2_tr.sv

# vezba 3
zip ../to_upload/vezba3 v3_fork_examples.sv

# vezba 4
zip ../to_upload/vezba4 v4_sudoku.sv v4_randomize_example.sv v4_pre_post_randomize_example.sv v4_constraint_mode.sv

# for vezba 5 and subsequent specific folder structre must be created
# this is done in tmp folder
mkdir -p tmp
rm -r tmp/*
mkdir -p tmp/dut
mkdir -p tmp/verif
mkdir -p tmp/verif/tests
mkdir -p tmp/verif/sequences

# for all
cp calc_*.v tmp/dut
cp calc_run.do tmp/verif
cp calc_if.sv tmp/verif

# vezba 5
prepare_v 5


# at the end remove tmp
rm -r tmp
