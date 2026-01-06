`timescale 1ns/1ps

module tb_elevator;

  reg clk;
  reg reset;
  reg [3:0] floor_req;
  reg emergency_stop;

  wire move_up;
  wire move_down;
  wire motor_stop;
  wire [1:0] current_floor;

  elevator dut (
    .clk(clk),
    .reset(reset),
    .floor_req(floor_req),
    .emergency_stop(emergency_stop),
    .move_up(move_up),
    .move_down(move_down),
    .motor_stop(motor_stop),
    .current_floor(current_floor)
  );

  always #5 clk = ~clk;

  initial begin
    clk = 0;
    reset = 1;
    floor_req = 4'b0000;
    emergency_stop = 0;

    #12 reset = 0;

    #10 floor_req = 4'b1000;
    #50 floor_req = 4'b0000;

    #20 floor_req = 4'b0010;
    #40 floor_req = 4'b0000;

    #20 floor_req = 4'b0100;
    #15 emergency_stop = 1;
    #20 emergency_stop = 0;
    #30 floor_req = 4'b0000;

    #50 $finish;
  end

  initial begin
    $monitor(
      "T=%0t | Floor=%0d | UP=%b | DOWN=%b | STOP=%b | EMG=%b",
      $time, current_floor, move_up, move_down, motor_stop, emergency_stop
    );
  end

endmodule
