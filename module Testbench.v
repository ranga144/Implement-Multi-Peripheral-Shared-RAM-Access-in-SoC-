module Testbench;
    reg clk;
    reg [7:0] address;
    reg [7:0] data_in;
    wire [7:0] data_out;
    reg read, write;

    TopModule uut (
        .clk(clk),
        .address(address),
        .data_in(data_in),
        .data_out(data_out),
        .read(read),
        .write(write)
    );

    always #5 clk = ~clk;  // Clock generation

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1, Testbench); // Only this level, not full hierarchy
        clk = 0;
        read = 0;
        write = 0;

        // Test Sequence
        address = 8'h00; data_in = 8'hAA; write = 1; #10; write = 0; read = 1; #10; read = 0;
        address = 8'h10; data_in = 8'hBB; write = 1; #10; write = 0; read = 1; #10; read = 0;
        address = 8'h20; data_in = 8'hCC; write = 1; #10; write = 0; read = 1; #10; read = 0;
        address = 8'h30; data_in = 8'hDD; write = 1; #10; write = 0; read = 1; #10; read = 0;

        $finish;
    end
endmodule