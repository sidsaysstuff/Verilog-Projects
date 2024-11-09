module rtc_top(
    input wire clk,
    input wire reset,
    input wire start_stopwatch,
    input wire stop_stopwatch,
    input wire [3:0] switch,
    output wire [6:0] seg,
    output wire [3:0] an
);

    wire sec_clk, min_clk, hour_clk;
    wire [5:0] sec, min;
    wire [4:0] hour;
    wire [6:0] stopwatch_sec, stopwatch_min;

    // Clock Divider
    clock_divider clk_div(
        .clk(clk),
        .reset(reset),
        .sec_clk(sec_clk),
        .min_clk(min_clk),
        .hour_clk(hour_clk)
    );

    // Real Time Clock
    rtc rtc_inst(
        .clk(clk),
        .reset(reset),
        .sec_clk(sec_clk),
        .min_clk(min_clk),
        .hour_clk(hour_clk),
        .sec(sec),
        .min(min),
        .hour(hour)
    );

    // Stopwatch
    stopwatch stopwatch_inst(
        .clk(clk),
        .reset(reset),
        .start(start_stopwatch),
        .stop(stop_stopwatch),
        .sec(stopwatch_sec),
        .min(stopwatch_min)
    );

    // 7-Segment Display
    display_7seg display_inst(
        .clk(clk),
        .reset(reset),
        .sec(sec),
        .min(min),
        .hour(hour),
        .switch(switch),
        .stopwatch_sec(stopwatch_sec),
        .stopwatch_min(stopwatch_min),
        .seg(seg),
        .an(an)
    );

endmodule
