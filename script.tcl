open_project resonator-dds
set_top fine_channelizer
add_files src/fine_channelizer.cpp
add_files src/fine_channelizer.hpp
add_files src/dds.cpp
add_files src/dds.h
add_files -tb src/tb.cpp -cflags "-Wno-unknown-pragmas" -csimflags "-Wno-unknown-pragmas"
open_solution "solution1"
set_part {xczu28dr-ffvg1517-2-e}
create_clock -period 550MHz -name default
config_export -description {Centers and biases raw resonator IQs} -display_name "Resonator DDS" -format ip_catalog -library mkidgen3 -rtl verilog -vendor MazinLab -version 0.5
csim_design
csynth_design
cosim_design -tool xsim
export_design -flow impl -rtl verilog -format ip_catalog -description "Centers and biases raw resonator IQs" -vendor "MazinLab" -library "mkidgen3" -version "0.5" -display_name "Resonator DDS"
