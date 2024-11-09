module bcd_counter_7seg_top (
    input wire clk,       // 100 MHz clock input
    input wire reset,     // Reset input
    output wire [6:0] seg, // 7-segment display output (a-g)
    output wire [3:0] LED_Select
);

    wire clk_1hz;         // 1 Hz clock signal
    wire [3:0] bcd;       // 4-bit BCD output from the counter
    assign LED_Select=4'b1110;

    // Instantiate the clock divider
    clock_divider clk_div (
        .clk_in(clk),
        .reset(reset),
        .clk_out(clk_1hz)
    );

    // Instantiate the BCD counter
    bcd_counter counter (
        .clk(clk_1hz),
        .reset(reset),
        .q(bcd)
    );

    // Instantiate the 7-segment display driver
    bcd_to_7seg display (
        .bcd(bcd),
        .seg(seg)
    );

endmodule
