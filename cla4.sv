module cla4 (
    input  logic [3:0] a,
    input  logic [3:0] b,
    input  logic       cin,
    output logic [3:0] sum,
    output logic       cout,
    output logic       P,   // group propagate
    output logic       G    // group generate
);
    logic [3:0] p, g;
    logic c1, c2, c3, c4;

    assign p = a ^ b;   // propagate
    assign g = a & b;   // generate

    // Lookahead carries
    assign c1 = g[0] | (p[0] & cin);
    assign c2 = g[1] | (p[1] & g[0]) | (p[1] & p[0] & cin);
    assign c3 = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & cin);
    assign c4 = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1])
                      | (p[3] & p[2] & p[1] & g[0])
                      | (p[3] & p[2] & p[1] & p[0] & cin);

    // Sum bits
    assign sum[0] = p[0] ^ cin;
    assign sum[1] = p[1] ^ c1;
    assign sum[2] = p[2] ^ c2;
    assign sum[3] = p[3] ^ c3;

    assign cout = c4;

    // Group P/G for this 4-bit block
    assign P = &p;  // p3&p2&p1&p0
    assign G = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]);
endmodule
