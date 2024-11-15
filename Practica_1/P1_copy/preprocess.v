module preprocess(output wire [3:0] AMod, BMod, input wire [3:0] A, B, input wire [2:0] Op);

    wire add1, op1_A, op2_B, cpl; // Señales auxiliares
    wire [3:0] AComp, BComp; // Complementos de A y B

    assign add1 = 1; // Selecciona la operación de suma
    assign op1_A = Op[2] | (Op[1] & ~Op[0]); // Selecciona A o A complementado
    assign op2_B = Op[2] | (Op[1] & ~Op[0]) | (~Op[1] & Op[0]); // Selecciona B o B complementado
    assign cpl = ~Op[2] & ~Op[1] & ~Op[0]; // Selecciona el complemento a 1

    mux2_4 mux1(AComp, 4'b0000, 4'b0001, add1); // Complemento a 1 de A
    mux2_4 mux2(AMod, AComp, A, op1_A); // Selecciona A o A complementado
    mux2_4 mux3(BComp, A, B, op2_B); // Selecciona B o B complementado
    compl1 comp(BMod, BComp, cpl); // Complemento a 1 de B

endmodule
