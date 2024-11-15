/// Full Adder
/// Con concatenación

module fa(output wire c_out, sum, input wire a, b, c_in);
  
  // Declaramos las conexiones internas
  assign {c_out, sum} = a + b + c_in;

endmodule