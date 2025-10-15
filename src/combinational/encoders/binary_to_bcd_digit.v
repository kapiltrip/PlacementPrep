// 4-bit binary to BCD digit converter with invalid flag for 10-15
module binary_to_bcd_digit (
    input  wire [3:0] binary_in,
    output reg  [3:0] bcd_out,
    output reg        d4,
    output wire       invalid
);
    always @* begin
        case (binary_in)
            4'd0:  begin bcd_out = 4'd0; d4 = 1'b0; end
            4'd1:  begin bcd_out = 4'd1; d4 = 1'b0; end
            4'd2:  begin bcd_out = 4'd2; d4 = 1'b0; end
            4'd3:  begin bcd_out = 4'd3; d4 = 1'b0; end
            4'd4:  begin bcd_out = 4'd4; d4 = 1'b0; end
            4'd5:  begin bcd_out = 4'd5; d4 = 1'b0; end
            4'd6:  begin bcd_out = 4'd6; d4 = 1'b0; end
            4'd7:  begin bcd_out = 4'd7; d4 = 1'b0; end
            4'd8:  begin bcd_out = 4'd8; d4 = 1'b0; end
            4'd9:  begin bcd_out = 4'd9; d4 = 1'b0; end
            default: begin bcd_out = binary_in; d4 = 1'b1; end
        endcase
    end

    assign invalid = d4;
endmodule
