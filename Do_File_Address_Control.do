add wave -position insertpoint sim:/address_module/*
force -freeze sim:/address_module/stall_fetch 0 0
force -freeze sim:/address_module/FAT 0 0
force -freeze sim:/address_module/rst 0 0
force -freeze sim:/address_module/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/address_module/rst 1 0
run
# ** Error: (vsim-86) Argument value -2147483648 is not in bounds of subtype NATURAL.
#    Time: 0 ps  Iteration: 0  Instance: /address_module
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /address_module
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /address_module
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 1  Instance: /address_module
run
run
force -freeze sim:/address_module/rst 0 0
run
run
run
run
run
run
run
run
force -freeze sim:/address_module/stall_fetch 1 0
run
run
run
run
force -freeze sim:/address_module/FAT 1 0
run
run
run
force -freeze sim:/address_module/stall_fetch 0 0
run
run
run
run
force -freeze sim:/address_module/rst 1 0
run
force -freeze sim:/address_module/rst 0 0
run
run
run
run
force -freeze sim:/address_module/stall_fetch 1 0
run
run
run
force -freeze sim:/address_module/FAT 0 0
run
run
force -freeze sim:/address_module/stall_fetch 0 0
run
run
run