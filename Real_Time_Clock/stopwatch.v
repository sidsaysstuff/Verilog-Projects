module stopwatch(
    input wire clk,
    input wire reset,
    input wire start,
    input wire stop,
    output reg [6:0] sec,
    output reg [6:0] min
);

    reg running = 0;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            sec <= 0;
            min <= 0;
            running <= 0;
        end else if (start) begin
            running <= 1;
        end else if (stop) begin
            running <= 0;
        end

        if (running) begin
            if (sec == 99) begin
                sec <= 0;
                if (min == 99)
                    min <= 0;
                else
                    min <= min + 1;
            end else begin
                sec <= sec + 1;
            end
        end
    end

endmodule
