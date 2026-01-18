module Mouse (
    input clk,
    input enable,
    input [7:0] address,
    input [7:0] data_in,
    output reg [7:0] data_out,
    input write, read
);
    reg [7:0] mouse_data;
    always @(posedge clk) begin
        if (enable) begin
            if (write)
                mouse_data <= data_in;
            if (read)
                data_out <= mouse_data;
        end
    end

    initial data_out = 8'b0; // Initialize to avoid unknowns
endmodule