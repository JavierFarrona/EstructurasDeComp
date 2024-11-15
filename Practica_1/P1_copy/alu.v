module alu(output wire [3:0] R, output wire zero, carry, sign, input wire [3:0] A, B, input wire c_in, input wire [2:0] Op);

    // Señales intermedias
    wire [3:0] AMod, BMod, logic_out, sum_out;
    wire c_out;

    // Preprocesamiento de A y B
    preprocess PREP(AMod, BMod, A, B, Op);

    // Suma de AMod y BMod
    sum4 SUM(sum_out, carry, AMod, BMod, c_in);

    // Operaciones lógicas
    ul4 UL(logic_out, AMod, BMod, Op[1:0]); // Operaciones lógicas seleccionadas por Op[1:0]

    // Selección del resultado final
    mux2_4 MUX(R, sum_out, logic_out, Op[2]);

    // Flags de la ALU
    assign zero  = R ? 0 : 1;                   // Zero flag se activa si el resultado es 0000
    assign sign  = R[3];                        // Sign flag toma el bit más significativo del resultado

endmodule
