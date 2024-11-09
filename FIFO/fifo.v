module fifo #(
    parameter DATA_WIDTH = 4,
    parameter ADDR_WIDTH = 2,
    parameter DIV_FACTOR = 500000000  // Divide by 500,000,000 for 5 seconds interval at 100 MHz base clock
)(
    input wire clk,
    input wire reset,
    input wire wr_en,  // Write enable
    input wire rd_en,  // Read enable
    input wire [DATA_WIDTH-1:0] din,  // Data input
    output reg [DATA_WIDTH-1:0] dout,  // Data output
    output wire full,
    output wire empty,
    output reg wr_led,  // LED for write operation
    output reg rd_led   // LED for read operation
);

    // Number of FIFO locations
    localparam DEPTH = (1 << ADDR_WIDTH);

    // Memory array
    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    // Read and write pointers
    reg [ADDR_WIDTH-1:0] wr_ptr = 0;
    reg [ADDR_WIDTH-1:0] rd_ptr = 0;

    // FIFO full and empty flags
    reg full_flag = 0;
    reg empty_flag = 1;

    // Clock divider output
    wire slow_clk;

    // Output assignment for full and empty flags
    assign full = full_flag;
    assign empty = empty_flag;

    // Instantiate clock divider
    clock_divider #(
        .DIV_FACTOR(DIV_FACTOR)
    ) clk_div (
        .clk_in(clk),
        .reset(reset),
        .clk_out(slow_clk)
    );

    // Write operation
    always @(posedge slow_clk or posedge reset) begin
        if (reset) begin
            wr_ptr <= 0;
            full_flag <= 0;
            wr_led <= 0;  // Turn off LED
        end else if (wr_en && !full_flag) begin
            mem[wr_ptr] <= din;
            wr_ptr <= wr_ptr + 1;
            if (wr_ptr + 1 == rd_ptr) begin
                full_flag <= 1;
            end
            empty_flag <= 0;
            wr_led <= 1;  // Blink LED
        end else begin
            wr_led <= 0;  // Turn off LED
        end
    end

    // Read operation
    always @(posedge slow_clk or posedge reset) begin
        if (reset) begin
            rd_ptr <= 0;
            empty_flag <= 1;
            rd_led <= 0;  // Turn off LED
        end else if (rd_en && !empty_flag) begin
            dout <= mem[rd_ptr];
            rd_ptr <= rd_ptr + 1;
            if (rd_ptr + 1 == wr_ptr) begin
                empty_flag <= 1;
            end
            full_flag <= 0;
            rd_led <= 1;  // Blink LED
        end else begin
            rd_led <= 0;  // Turn off LED
        end
    end

endmodule
