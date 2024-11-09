module bcd_counter (
    input wire clk,       // Clock input
    input wire reset,     // Asynchronous reset input
    output reg [3:0] q    // 4-bit BCD output
);
     
    
    // BCD counter logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 4'b0000; // Reset the counter to 0
        end else begin
            if (q == 4'b1001) begin
                q <= 4'b0000; // Wrap around to 0 if counter reaches 9
            end else begin
                q <= q + 1; // Increment the counter
            end
        end
    end

endmodule