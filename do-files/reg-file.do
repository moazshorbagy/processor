vsim -gui work.regfile
add wave -position insertpoint  \
sim:/regfile/clk \
sim:/regfile/rst \
sim:/regfile/write_addr_1 \
sim:/regfile/write_addr_2 \
sim:/regfile/write_data_1 \
sim:/regfile/write_data_2 \
sim:/regfile/we_1 \
sim:/regfile/we_2 \
sim:/regfile/read_addr_1 \
sim:/regfile/read_addr_2 \
sim:/regfile/read_data_1 \
sim:/regfile/read_data_2 \
sim:/regfile/loop1(2)/rx/d \
sim:/regfile/loop1(2)/rx/q \
sim:/regfile/loop1(2)/rx/rst \
sim:/regfile/loop1(2)/rx/enable
force -freeze sim:/regfile/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/regfile/rst 1 0
force -freeze sim:/regfile/we_1 1 0
force -freeze sim:/regfile/we_2 0 0
force -freeze sim:/regfile/write_addr_1 2 0
force -freeze sim:/regfile/write_addr_2 6 0
force -freeze sim:/regfile/read_addr_1 2 0
force -freeze sim:/regfile/read_addr_2 6 0
force -freeze sim:/regfile/write_data_1 550 0
force -freeze sim:/regfile/write_data_2 8008 0
run 50 ps
force -freeze sim:/regfile/rst 0 0
run
run