module traffic_light_controller #(
    parameter integer GREEN_TICKS = 5,
    parameter integer YELLOW_TICKS = 2
)(
    input  wire clk,
    input  wire rst,
    output reg  ns_red, ns_yellow, ns_green,
    output reg  ew_red, ew_yellow, ew_green
);
    localparam [1:0] NS_GREEN=2'd0, NS_YELLOW=2'd1,
                     EW_GREEN=2'd2, EW_YELLOW=2'd3;
    reg [1:0] state;
    integer count;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= NS_GREEN;
            count <= 0;
        end else begin
            case (state)
                NS_GREEN:  if (count == GREEN_TICKS-1) begin state <= NS_YELLOW; count <= 0; end else count <= count+1;
                NS_YELLOW: if (count == YELLOW_TICKS-1) begin state <= EW_GREEN; count <= 0; end else count <= count+1;
                EW_GREEN:  if (count == GREEN_TICKS-1) begin state <= EW_YELLOW; count <= 0; end else count <= count+1;
                EW_YELLOW: if (count == YELLOW_TICKS-1) begin state <= NS_GREEN; count <= 0; end else count <= count+1;
                default: begin state <= NS_GREEN; count <= 0; end
            endcase
        end
    end

    always @* begin
        ns_red=1; ns_yellow=0; ns_green=0;
        ew_red=1; ew_yellow=0; ew_green=0;
        case (state)
            NS_GREEN:  begin ns_red=0; ns_green=1; end
            NS_YELLOW: begin ns_red=0; ns_yellow=1; end
            EW_GREEN:  begin ew_red=0; ew_green=1; end
            EW_YELLOW: begin ew_red=0; ew_yellow=1; end
            default: ;
        endcase
    end
endmodule
