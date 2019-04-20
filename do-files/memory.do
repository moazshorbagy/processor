vsim -gui work.memory
# vsim -gui work.memory 
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.memory(memory_architecture)
add wave -position insertpoint  \
sim:/memory/clk \
sim:/memory/we \
sim:/memory/w32 \
sim:/memory/address \
sim:/memory/datain \
sim:/memory/dataout \
sim:/memory/data1 \
sim:/memory/data2
# ** Warning: (vsim-WLF-5000) WLF file currently in use: vsim.wlf
# 
#           File in use by: Moaz  Hostname: MOAZ  ProcessID: 9268
# 
#           Attempting to use alternate WLF file "./wlftwhv7b7".
# ** Warning: (vsim-WLF-5001) Could not open WLF file: vsim.wlf
# 
#           Using alternate file: ./wlftwhv7b7
# 
mem load -filltype value -filldata 0 -fillradix decimal /memory/ram(0)
mem load -filltype value -filldata 0 -fillradix decimal /memory/ram(0)
mem load -filltype value -filldata 1 -fillradix decimal /memory/ram(1)
mem load -filltype value -filldata 2 -fillradix decimal /memory/ram(2)
mem load -filltype value -filldata 3 -fillradix decimal /memory/ram(3)
mem load -filltype value -filldata 4 -fillradix decimal /memory/ram(4)
force -freeze sim:/memory/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/memory/we 0 0
force -freeze sim:/memory/w32 0 0
force -freeze sim:/memory/address 0 0
run
run
run
force -freeze sim:/memory/address 1 0
run