module elevator (
    input  clk,
    input  reset,
    input  [3:0] floor_req,
    input  emergency_stop,
    output reg move_up,
    output reg move_down,
    output reg motor_stop,
    output reg [1:0] current_floor
);

  parameter IDLE      = 2'b00;
  parameter UP        = 2'b01;
  parameter DOWN      = 2'b10;
  parameter EMERGENCY = 2'b11;

  reg [1:0] current_state, next_state;
  reg [1:0] target_floor;

  always @(*) begin
    target_floor = current_floor;
    if      (floor_req[0]) target_floor = 2'd0;
    else if (floor_req[1]) target_floor = 2'd1;
    else if (floor_req[2]) target_floor = 2'd2;
    else if (floor_req[3]) target_floor = 2'd3;
  end

  always @(posedge clk or posedge reset) begin
    if (reset)
      current_state <= IDLE;
    else
      current_state <= next_state;
  end

  always @(posedge clk or posedge reset) begin
    if (reset)
      current_floor <= 2'd0;
    else if (current_state == EMERGENCY)
      current_floor <= current_floor;
    else begin
      case (current_state)
        UP: begin
          if (current_floor < target_floor && current_floor < 2'd3)
            current_floor <= current_floor + 1'b1;
        end

        DOWN: begin
          if (current_floor > target_floor && current_floor > 2'd0)
            current_floor <= current_floor - 1'b1;
        end

        default: current_floor <= current_floor;
      endcase
    end
  end

  always @(*) begin
    next_state = current_state;

    if (emergency_stop)
      next_state = EMERGENCY;
    else begin
      case (current_state)

        IDLE: begin
          if (target_floor > current_floor)
            next_state = UP;
          else if (target_floor < current_floor)
            next_state = DOWN;
        end

        UP: begin
          if (current_floor == target_floor)
            next_state = IDLE;
        end

        DOWN: begin
          if (current_floor == target_floor)
            next_state = IDLE;
        end

        EMERGENCY: begin
          if (!emergency_stop)
            next_state = IDLE;
        end

        default: next_state = IDLE;
      endcase
    end
  end

  always @(*) begin
    move_up    = 1'b0;
    move_down  = 1'b0;
    motor_stop = 1'b0;

    case (current_state)
      UP:        move_up    = 1'b1;
      DOWN:      move_down  = 1'b1;
      IDLE,
      EMERGENCY: motor_stop = 1'b1;
    endcase
  end

endmodule
