# Traffic Light Controller (Verilog)

A finite-state-machine traffic light controller for a two-road junction.
The controller cycles through NS green, NS yellow, EW green, EW yellow.
A parameter controls the duration of each state.

## Run
```bash
iverilog -g2012 -o sim.out rtl/traffic_light_controller.v tb/tb_traffic_light_controller.v
vvp sim.out
```
Optional waveform:
```bash
iverilog -g2012 -o sim.out -D DUMP_VCD rtl/traffic_light_controller.v tb/tb_traffic_light_controller.v
vvp sim.out
gtkwave traffic_light.vcd
```
