`include "my_pakage.sv"

module _task (
    input matrix_t A,
    input matrix_t B,
    output matrix_t C
);

    always @(A, B) begin
        matrix_multiply(A, B, C);
    end
    
    function void matrix_multiply(input matrix_t A, input matrix_t B, output matrix_t C);
        integer i, j, k;
        data_t sum;
        for (i = 0; i < N; i++) begin
            for (j = 0; j < N; j++) begin
                sum = 0;
                for (k = 0; k < N; k++) begin
                    sum += A[i][k] * B[k][j];
                end
                C[i][j] = sum;
            end
        end
    endfunction
endmodule