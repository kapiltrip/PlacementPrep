// Full adder with propagate and generate outputs for reuse
module full_adder (
    input  wire a,
    input  wire b,
    input  wire cin,
    output wire sum,
    output wire cout,
    output wire propagate,
    output wire generate
);
    assign propagate = a ^ b;
    assign generate  = a & b;
    assign sum  = propagate ^ cin;
    assign cout = generate | (propagate & cin);
endmodule
