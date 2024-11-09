module display_7seg(
    input wire clk,
    input wire reset,
    input wire [5:0] sec,
    input wire [5:0] min,
    input wire [4:0] hour,
    input wire [3:0] switch,
    input wire [6:0] stopwatch_sec,
    input wire [6:0] stopwatch_min,
    output reg [6:0] seg,
    output reg [3:0] an
);

    reg [3:0] digit;
    reg [1:0] sel;
    reg [3:0] data;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            sel <= 0;
            an <= 4'b1110;
        end else begin
            sel <= sel + 1;
            case (sel)
                2'b00: an <= 4'b1110;
                2'b01: an <= 4'b1101;
                2'b10: an <= 4'b1011;
                2'b11: an <= 4'b0111;
                default: an <= 4'b1110;
            endcase
        end
    end

    always @(*) begin
        case (sel)
            2'b00: data = switch[0] ? stopwatch_sec[3:0] : sec[3:0];
            2'b01: data = switch[0] ? stopwatch_sec[6:4] : sec[5:4];
            2'b10: data = switch[1] ? stopwatch_min[3:0] : min[3:0];
            2'b11: data = switch[1] ? stopwatch_min[6:4] : min[5:4];
            default: data = 4'b0000;
        endcase

        case (data)
            4'b0000: seg = 7'b1000000;
            4'b0001: seg = 7'b1111001;
            4'b0010: seg = 7'b0100100;
            4'b0011: seg = 7'b0110000;
            4'b0100: seg = 7'b0011001;
            4'b0101: seg = 7'b0010010;
            4'b0110: seg = 7'b0000010;
            4'b0111: seg = 7'b1111000;
            4'b1000: seg = 7'b0000000;
            4'b1001: seg = 7'b0010000;
            default: seg = 7'b1111111;
        endcase
    end

endmodule
