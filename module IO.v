module IO (
    input clk,
    input enable,
    input [7:0] address,
    input [7:0] data_in,
    output reg [7:0] data_out,
    input write, read
);
    reg [7:0] io_reg [0:255];
    always @(posedge clk) begin
        if (enable) begin
            if (write)
                io_reg[address] <= data_in;
            if (read)
                data_out <= io_reg[address];
        end
    end

    initial data_out = 8'b0; // Initialize to avoid unknowns
endmodule