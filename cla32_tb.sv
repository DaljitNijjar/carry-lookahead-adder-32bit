`timescale 1ns/1ps

module cla32_tb;
    logic [31:0] a, b;
    logic        cin;
    logic [31:0] sum;
    logic        cout;

    cla32 dut (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

    int errors;

    task automatic check_once(input logic [31:0] aa, input logic [31:0] bb, input logic cc);
        logic [32:0] exp;
        begin
            a = aa; b = bb; cin = cc;
            #1;
            exp = {1'b0, aa} + {1'b0, bb} + cc;

            if ({cout, sum} !== exp) begin
                $display("FAIL a=%h b=%h cin=%0d -> got=%h exp=%h",
                         aa, bb, cc, {cout,sum}, exp);
                errors++;
            end
        end
    endtask

    initial begin
        errors = 0;

        // Edge cases
        check_once(32'h00000000, 32'h00000000, 0);
        check_once(32'h00000000, 32'h00000000, 1);
        check_once(32'hFFFFFFFF, 32'h00000001, 0);
        check_once(32'hFFFFFFFF, 32'hFFFFFFFF, 0);
        check_once(32'h80000000, 32'h80000000, 0);
        check_once(32'h12345678, 32'h9ABCDEF0, 0);
        check_once(32'h12345678, 32'h9ABCDEF0, 1);

        // Random tests
        repeat (5000) begin
            check_once($urandom(), $urandom(), $urandom_range(0,1));
        end

        if (errors == 0) $display("ALL CLA32 TESTS PASSED ✅");
        else             $display("CLA32 TESTS FAILED: %0d errors ❌", errors);

        $finish;
    end
endmodule
