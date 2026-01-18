module AddressDecoder (
    input [7:0] address,
    input read, write,
    output reg mem_en, io_en, periph_en
);
    always @(*) begin
        mem_en = 0;
        io_en = 0;
        periph_en = 0;
        if (read || write) begin
            case (address[7:4])
                4'h0: mem_en = 1;       // Memory
                4'h1: io_en = 1;        // I/O Device
                4'h2: periph_en = 1;    // Peripheral (e.g., Keyboard)
                4'h3: periph_en = 1;    // Peripheral (e.g., Mouse)
                default: ;              // No module selected
            endcase
        end
    end
endmodule