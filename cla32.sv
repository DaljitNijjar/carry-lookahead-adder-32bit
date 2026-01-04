module cla32 (
    input  logic [31:0] a,
    input  logic [31:0] b,
    input  logic        cin,
    output logic [31:0] sum,
    output logic        cout
);
    logic [7:0] P, G;     // block propagate/generate for each 4-bit chunk
    logic [8:0] C;        // carries at block boundaries: C[0]=cin, C[8]=cout

    assign C[0] = cin;

    // Block-level carry lookahead:
    // C[i+1] = G[i] | (P[i] & C[i])
    
    genvar i;           // variable in the loops of generate for 
    generate
        for (i = 0; i < 8; i++) begin : gen_block_carry 
            assign C[i+1] = G[i] | (P[i] & C[i]);
        end
    endgenerate

    // 8 x 4-bit CLA blocks
    generate
        for (i = 0; i < 8; i++) begin : gen_cla4
            cla4 u_cla4 (
                .a   (a[i*4 +: 4]),
                .b   (b[i*4 +: 4]),
                .cin (C[i]),
                .sum (sum[i*4 +: 4]),
                .cout(),          // not needed; we use lookahead C[i+1]
                .P   (P[i]),
                .G   (G[i])
            );
        end
    endgenerate

    assign cout = C[8];
endmodule
