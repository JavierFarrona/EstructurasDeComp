`timescale 1ns/1ps

module microc_tb;

    // Declaración de señales
    reg clk, reset;
    reg s_inc, s_inm, we3, wez;
    reg [2:0] Op;
    wire [5:0] Opcode;
    wire z;

    // Instancia del módulo microc
    microc uut (
        .Opcode(Opcode),
        .z(z),
        .clk(clk),
        .reset(reset),
        .s_inc(s_inc),
        .s_inm(s_inm),
        .we3(we3),
        .wez(wez),
        .Op(Op)
    );

    // Generación de reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Periodo de 10 ns
    end

    // Inicialización de señales y casos de prueba
    initial begin
        // Fase inicial: reset del sistema
        reset = 1;
        s_inc = 0; s_inm = 0; we3 = 0; wez = 0; Op = 3'b000;
        #10 reset = 0; // Liberar reset después de 10 ns

        // Caso 1: Salto incondicional
        s_inc = 0; s_inm = 0; we3 = 0; wez = 0;
        #10;

        // Caso 2: Carga inmediata
        s_inm = 1; we3 = 1;
        #10;

        // Caso 3: Operación aritmética (add)
        s_inm = 0; Op = 3'b010; we3 = 1;
        #10;

        // Caso 4: Salto condicional (jnz)
        s_inc = 0; wez = 1;
        #10;

        // Finalizar la simulación
        #100 $finish;
    end

endmodule
