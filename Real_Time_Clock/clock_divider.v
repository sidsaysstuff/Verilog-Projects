module clock_divider(
    input wire clk,
    input wire reset,
    output reg sec_clk,
    output reg min_clk,
    output reg hour_clk
);

    reg [26:0] sec_counter = 0;
    reg [31:0] min_counter = 0;
    reg [35:0] hour_counter = 0;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            sec_counter <= 0;
            min_counter <= 0;
            hour_counter <= 0;
            sec_clk <= 0;
            min_clk <= 0;
            hour_clk <= 0;
        end else begin
            if (sec_counter == 100_000_000 - 1) begin // For 1 second
                sec_counter <= 0;
                sec_clk <= ~sec_clk;
            end else begin
                sec_counter <= sec_counter + 1;
            end

            if (sec_clk) begin
                if (min_counter == 60 - 1) begin
                    min_counter <= 0;
                    min_clk <= ~min_clk;
                end else begin
                    min_counter <= min_counter + 1;
                end
            end

            if (min_clk) begin
                if (hour_counter == 24 - 1) begin
                    hour_counter <= 0;
                    hour_clk <= ~hour_clk;
                end else begin
                    hour_counter <= hour_counter + 1;
                end
            end
        end
    end

endmodule
