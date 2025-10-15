// BCD (0-9) to Excess-3 code converter
module bcd_to_excess3 (
    input  wire [3:0] bcd,
    output reg  [3:0] excess3
);
    always @* begin
        case (bcd)
            4'd0: excess3 = 4'd3;
            4'd1: excess3 = 4'd4;
            4'd2: excess3 = 4'd5;
            4'd3: excess3 = 4'd6;
            4'd4: excess3 = 4'd7;
            4'd5: excess3 = 4'd8;
            4'd6: excess3 = 4'd9;
            4'd7: excess3 = 4'd10;
            4'd8: excess3 = 4'd11;
            4'd9: excess3 = 4'd12;
            default: excess3 = 4'd0;
        endcase
    end
endmodule
