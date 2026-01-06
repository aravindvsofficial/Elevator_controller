# Elevator_controller (RTL Design + Testbench)

A finite state machine–based elevator controller designed in Verilog with a clear and robust testbench. The design demonstrates floor request handling, directional movement, emergency stop behavior, and safe state transitions, along with simulation waveform results for clear understanding of FSM-driven control logic.

📁 Files Included
| File                 | Description                                        |
| -------------------- | -------------------------------------------------- |
| `elevator.v`         | RTL design of the elevator controller (FSM-based)  |
| `tb_elevator.v`      | Verilog testbench for functional verification      |
| `power1.png`          | Power analysis overview of the elevator controller |
| `schematic1.png`      | Netlist / schematic representation of the FSM      |
| `implementation1.png` | Block-level implementation view                    |
| `waveform1.png`       | Simulation waveform output                         |

# RTL Design

A clean, synthesizable Verilog RTL design built using a Moore-style finite state machine. The controller safely manages elevator motion between floors, prevents overflow and underflow conditions, and correctly handles emergency stop scenarios. The design emphasizes deterministic behavior, clean state transitions, and hardware-accurate timing suitable for FPGA or ASIC flows.

View the full file: `elevator.v`

# Testbench

A focused and lightweight Verilog testbench that applies realistic elevator scenarios including upward and downward travel, idle states, and emergency interruption. The testbench monitors outputs through simulation waveforms to validate correct FSM behavior and floor tracking without unnecessary complexity.

View the full file: `tb_elevator.v`

# Conclusion

This project demonstrates a reliable and synthesizable elevator controller implemented using structured FSM-based RTL design principles. Through comprehensive simulation and waveform analysis, the design proves correct handling of movement control, safety conditions, and state transitions. The combination of RTL clarity, clean verification, and implementation artifacts makes this project suitable for academic use, RTL portfolios, and real-world digital control system integration.
