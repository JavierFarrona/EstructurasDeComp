/*
module ul4(output wire[3:0] S, input wire[3:0] A, input wire[3:0] B, input wire [1:0] s);

    //Instanciamos cuatro celdas lógicas para cada bit
    cl cl0 (S[0], A[0], B[0], s); // cl_out[0] es la salida de la celda lógica 0
    cl cl1 (S[1], A[1], B[1], s);
    cl cl2 (S[2], A[2], B[2], s);
    cl cl3 (S[3], A[3], B[3], s);
  
endmodule
*/

module ul4(output reg [3:0] Out, input wire [3:0] A, input wire [3:0] B, input wire [1:0] S);

    always @* begin
        case(S)
            2'b00: Out = A & B;     
            2'b01: Out = A | B;     
            2'b10: Out = A ^ B;     
            2'b11: Out = ~A;        
            default: Out = 4'b0000; 
        endcase
    end

endmodule


