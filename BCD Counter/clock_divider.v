module clock_divider(
    input wire clk_in,   // 100 MHz clock input
    input wire reset,    // Reset input
    output reg clk_out   // 1 Hz clock output
);

    reg [26:0] counter;  // 27-bit counter to count up to 100,000,000

    always @(posedge clk_in or posedge reset) begin
        if (reset) begin
            counter <= 27'b0;   // Reset the counter
            clk_out <= 1'b0;    // Reset the output clock
        end else begin
            if (counter == 27'd99999999) begin
                counter <= 27'b0;   // Reset counter
                clk_out <= ~clk_out; // Toggle output clock
            end else begin
                counter <= counter + 1; // Increment counter
            end
        end
    end

endmodule
