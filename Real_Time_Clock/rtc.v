module rtc(
    input wire clk,
    input wire reset,
    input wire sec_clk,
    input wire min_clk,
    input wire hour_clk,
    output reg [5:0] sec,
    output reg [5:0] min,
    output reg [4:0] hour
);

    always @(posedge sec_clk or posedge reset) begin
        if (reset)
            sec <= 0;
        else if (sec == 59)
            sec <= 0;
        else
            sec <= sec + 1;
    end

    always @(posedge min_clk or posedge reset) begin
        if (reset)
            min <= 0;
        else if (min == 59)
            min <= 0;
        else
            min <= min + 1;
    end

    always @(posedge hour_clk or posedge reset) begin
        if (reset)
            hour <= 0;
        else if (hour == 23)
            hour <= 0;
        else
            hour <= hour + 1;
    end

endmodule
