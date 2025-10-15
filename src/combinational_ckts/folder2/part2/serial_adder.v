// Serial adder using shift registers and a carry flip-flop
module serial_adder #(
    parameter WIDTH = 4
) (
    input  wire             clk,
    input  wire             rst_n,
    input  wire             load,
    input  wire             enable,
    input  wire [WIDTH-1:0] a_in,
    input  wire [WIDTH-1:0] b_in,
    output reg  [WIDTH-1:0] sum_out,
    output reg              carry_out,
    output reg              done
);
    reg [WIDTH-1:0] a_shift;
    reg [WIDTH-1:0] b_shift;
    reg [WIDTH-1:0] sum_shift;
    reg             carry_ff;
    integer         count;
    reg             sum_bit;
    reg             next_carry;
    reg [WIDTH-1:0] sum_next;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            a_shift   <= {WIDTH{1'b0}};
            b_shift   <= {WIDTH{1'b0}};
            sum_shift <= {WIDTH{1'b0}};
            sum_out   <= {WIDTH{1'b0}};
            carry_ff  <= 1'b0;
            carry_out <= 1'b0;
            count     <= 0;
            done      <= 1'b0;
        end else if (load) begin
            a_shift   <= a_in;
            b_shift   <= b_in;
            sum_shift <= {WIDTH{1'b0}};
            sum_out   <= {WIDTH{1'b0}};
            carry_ff  <= 1'b0;
            carry_out <= 1'b0;
            count     <= 0;
            done      <= 1'b0;
        end else if (enable && !done) begin
            sum_bit    = a_shift[0] ^ b_shift[0] ^ carry_ff;
            next_carry = (a_shift[0] & b_shift[0]) | ((a_shift[0] ^ b_shift[0]) & carry_ff);

            sum_next         = sum_shift;
            sum_next[count]  = sum_bit;
            sum_shift        <= sum_next;
            a_shift          <= {1'b0, a_shift[WIDTH-1:1]};
            b_shift          <= {1'b0, b_shift[WIDTH-1:1]};
            carry_ff         <= next_carry;
            count            <= count + 1;

            if (count == WIDTH-1) begin
                sum_out   <= sum_next;
                carry_out <= next_carry;
                done      <= 1'b1;
            end
        end
    end
endmodule
