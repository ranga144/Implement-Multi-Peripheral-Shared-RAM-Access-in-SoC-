
module TopModule (
    input clk,
    input [7:0] address,
    input [7:0] data_in,
    output [7:0] data_out,
    input read, write
);
    wire mem_en, io_en, periph_en;
    wire [7:0] mem_data_out, io_data_out, keyboard_data_out, mouse_data_out;
    
    AddressDecoder addr_decoder (
        .address(address),
        .read(read),
        .write(write),
        .mem_en(mem_en),
        .io_en(io_en),
        .periph_en(periph_en)
    );

    Memory mem (
        .clk(clk),
        .enable(mem_en),
        .address(address),
        .data_in(data_in),
        .data_out(mem_data_out),
        .write(write),
        .read(read)
    );

    IO io (
        .clk(clk),
        .enable(io_en),
        .address(address),
        .data_in(data_in),
        .data_out(io_data_out),
        .write(write),
        .read(read)
    );

    Keyboard keyboard (
        .clk(clk),
        .enable(periph_en && (address[7:4] == 4'h2)),
        .address(address),
        .data_in(data_in),
        .data_out(keyboard_data_out),
        .write(write),
        .read(read)
    );

    Mouse mouse (
        .clk(clk),
        .enable(periph_en && (address[7:4] == 4'h3)),
        .address(address),
        .data_in(data_in),
        .data_out(mouse_data_out),
        .write(write),
        .read(read)
    );

    assign data_out = (mem_en) ? mem_data_out :
                      (io_en)  ? io_data_out  :
                      (address[7:4] == 4'h2) ? keyboard_data_out :
                      (address[7:4] == 4'h3) ? mouse_data_out :
                      8'b0; // Default to 0 to avoid undefined
endmodule