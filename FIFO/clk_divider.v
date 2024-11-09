module clock_divider #(
    parameter DIV_FACTOR = 500000000  // Divide by 500,000,000 for 5 seconds interval \
)(
    input wire clk_in,
    input wire reset,
    output reg clk_out
);

    reg [31:0] counter = 0;

    always @(posedge clk_in or posedge reset) begin
        if (reset) begin
            counter <= 0;
            clk_out <= 0;
        end else begin
            if (counter == DIV_FACTOR-1) begin
                counter <= 0;
                clk_out <= ~clk_out;
            end else begin
                counter <= counter + 1;
            end
        end
    end

endmodule
