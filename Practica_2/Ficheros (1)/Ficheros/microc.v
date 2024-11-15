module microc(output wire [5:0] Opcode, output wire z, input wire clk, reset, s_inc, s_inm, we3, wez, input wire [2:0] Op);
//Microcontrolador sin memoria de datos de un solo ciclo
  
    // Señales internas
    wire [9:0] PC_out, PC_next;    // Salida del registro PC y próximo valor
    wire [15:0] instruction;       // Instrucción actual
    wire [7:0] reg1, reg2, alu_out, write_data; // Registros y salida de ALU
    wire z_flag;                   // Bandera de cero

    // Instancia del registro del PC
    registro #(10) PC (
        .clk(clk),
        .reset(reset),
        .enable(1'b1),          // Siempre habilitado
        .d(PC_next),
        .q(PC_out)
    );

    // Instancia de la memoria de programa
    memprog MEM (
        .address(PC_out),
        .data_out(instruction)
    );

    // Decodificación de la instrucción
    assign Opcode = instruction[15:10];
    wire [3:0] reg_dest = instruction[3:0];   // Registro destino (WA3)
    wire [3:0] reg1_addr = instruction[11:8]; // Primer operando (RA1)
    wire [3:0] reg2_addr = instruction[7:4];  // Segundo operando (RA2)
    wire [7:0] immediate = instruction[11:4]; // Valor inmediato

    // Selección del próximo valor del PC
    mux2 #(10) mux_pc (
        .a(PC_out + 1),         // Incremento del PC
        .b(instruction[9:0]),   // Salto (dirección absoluta)
        .sel(s_inc),
        .y(PC_next)
    );

    // Banco de registros
    regfile REG (
        .clk(clk),
        .we(we3),
        .ra1(reg1_addr),
        .ra2(reg2_addr),
        .wa(reg_dest),
        .wd(write_data),
        .rd1(reg1),
        .rd2(reg2)
    );

    // ALU
    alu ALU (
        .op(Op),
        .a(reg1),
        .b(reg2),
        .z(z_flag),
        .result(alu_out)
    );

    // Salida de datos para el banco de registros
    mux2 #(8) mux_reg_data (
        .a(alu_out),
        .b(immediate),
        .sel(s_inm),
        .y(write_data)
    );

    // Registro de la bandera z
    ffd #(1) flag_z (
        .clk(clk),
        .reset(reset),
        .enable(wez),
        .d(z_flag),
        .q(z)
    );




endmodule


