# ������ ��������� ������

���� ������ �������� � ���� ����� �� ����� SystemVerilog, ����������� ������ ��������� ������, � ����� �������� ��������� ��� �����������.

## ���������� �����:

1. **my_package.sv**: ���������� ����� SystemVerilog `my_package`, ���������� ����������� ���������� � ����� ������ ��� �������� � ���������.

2. **task.sv**: ���������� ������ SystemVerilog `_task` ��� ��������� ������. �� ���������� �����, ������������ � `my_package.sv`, ��� ������������� ���������� � ����� ������.

3. **tb_task.sv**: �������� ������ ��� �������� ���������������� ������ `_task`. �� �������������� ������� ������� A � B, ������� ��������� ������ `_task` � ��������� �������� ������� C ��� ��������.


### 1. `my_package.sv`:

���� ���� �������� ����������� ������ `my_package`, ������� ������������ ��� ���������� ����������� � ������ ������, ������������ ��� �������� � ���������.

```systemverilog
`timescale 1ns / 1ps

`ifndef MY_PAKAGE
`define MY_PAKAGE

package my_pakage;
    parameter N = 3;
    typedef byte unsigned data_t;
    typedef data_t matrix_t[N][N];
endpackage

import my_pakage.*;

`endif
```

- `parameter N = 3;`: ������ ������ ���������� ������� �� ���������.
- `typedef byte unsigned data_t;`: ���������� ����� ��� ������ `data_t` ��� ����������� ����.
- `typedef data_t matrix_t[N][N];`: ���������� ����� ��� ������ `matrix_t` ��� ������ �������� `N x N`, ��������� �� ��������� ���� `data_t`.

### 2. `task.sv`:

���� ���� �������� ������ `_task`, ������� ��������� �������� ��������� ������.

```systemverilog
`include "my_package.sv"

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
```

- `always @(A, B) begin ... end`: ��������� �������� ��������� ������ ���, ����� ���������� ������� ������� A � B.
- `function void matrix_multiply(...)`: ���������� ������� `matrix_multiply`, ������� ��������� ����������� ��������� ������.

### 3. `tb_task.sv`:

���� ���� �������� �������� ������ ��� ����������� ������ `_task`.

```systemverilog
`timescale 1ns / 1ps

`include "my_package.sv"

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
```

- `initial begin ... end`: �������������� ������� ������� A � B.
- `_task dut (...)`: ������� ��������� ������ `_task` ��� ���������� ��������� ������.

## ��������� ���������� ���������

![���������](https://i.imgur.com/2AH4JHm.png)
