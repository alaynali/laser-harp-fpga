create_clock -period 10.000 -name clk_100 -waveform {0.000 5.000} [get_ports Clk]

set_property PACKAGE_PIN B13 [get_ports {left_jack}]
set_property PACKAGE_PIN B14 [get_ports {right_jack}]