// Modulo que realiza la operacion de complemento a 1

module compl1(output wire [3:0] Out, input wire [3:0] Inp, input wire cpl);

  assign Out = cpl ? ~Inp : Inp;

  // Con un Mux 2 a 4 bits
  // wire [3:0] InpComp;
  // mux2_4 mux1(InpComp, Inp, ~Inp, cpl);

endmodule