`timescale 1ns/1ps
module tb_traffic_light_controller;
    reg clk=0, rst=1;
    wire nr,ny,ng,er,ey,eg;
    always #5 clk=~clk;
    traffic_light_controller #(.GREEN_TICKS(3),.YELLOW_TICKS(2)) dut
      (.clk(clk),.rst(rst),.ns_red(nr),.ns_yellow(ny),.ns_green(ng),
       .ew_red(er),.ew_yellow(ey),.ew_green(eg));
`ifdef DUMP_VCD
    initial begin $dumpfile("traffic_light.vcd"); $dumpvars(0,tb_traffic_light_controller); end
`endif
    initial begin
        $display("time NS(RYG) EW(RYG)");
        #12 rst=0;
        repeat(20) begin
            @(negedge clk);
            $display("%0t NS=%b%b%b EW=%b%b%b",$time,nr,ny,ng,er,ey,eg);
            if ((ng && !er) || (eg && !nr)) $fatal(1,"Conflicting green lights!");
        end
        $display("PASS: traffic-light sequence completed");
        $finish;
    end
endmodule
