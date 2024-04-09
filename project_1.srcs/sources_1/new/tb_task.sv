`timescale 1ns / 1ps

`include "my_pakage.sv"

module tb_task;
    matrix_t A, B, C;
    initial begin
        A = '{'{1, 2, 3},
              '{4, 5, 6},
              '{7, 8, 9}};
        B = '{'{9, 8, 7},
              '{6, 5, 4},
              '{3, 2, 1}};
    end
    
    _task dut (
        .A(A),
        .B(B),
        .C(C)
    );

endmodule
