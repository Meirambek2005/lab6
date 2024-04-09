# Модуль умножения матриц

Этот проект включает в себя файлы на языке SystemVerilog, реализующие модуль умножения матриц, а также тестовое окружение для верификации.

## Включенные файлы:

1. **my_package.sv**: Определяет пакет SystemVerilog `my_package`, содержащий определения параметров и типов данных для операций с матрицами.

2. **task.sv**: Определяет модуль SystemVerilog `_task` для умножения матриц. Он использует пакет, определенный в `my_package.sv`, для использования параметров и типов данных.

3. **tb_task.sv**: Тестовый модуль для проверки функциональности модуля `_task`. Он инициализирует входные матрицы A и B, создает экземпляр модуля `_task` и сохраняет выходную матрицу C для проверки.


### 1. `my_package.sv`:

Этот файл содержит определение пакета `my_package`, который используется для управления параметрами и типами данных, необходимыми для операций с матрицами.

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

- `parameter N = 3;`: Задает размер квадратной матрицы по умолчанию.
- `typedef byte unsigned data_t;`: Определяет новый тип данных `data_t` как беззнаковый байт.
- `typedef data_t matrix_t[N][N];`: Определяет новый тип данных `matrix_t` как массив размером `N x N`, состоящий из элементов типа `data_t`.

### 2. `task.sv`:

Этот файл содержит модуль `_task`, который выполняет операцию умножения матриц.

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

- `always @(A, B) begin ... end`: Запускает операцию умножения каждый раз, когда изменяются входные матрицы A и B.
- `function void matrix_multiply(...)`: Определяет функцию `matrix_multiply`, которая выполняет фактическое умножение матриц.

### 3. `tb_task.sv`:

Этот файл содержит тестовый модуль для верификации модуля `_task`.

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

- `initial begin ... end`: Инициализирует входные матрицы A и B.
- `_task dut (...)`: Создает экземпляр модуля `_task` для выполнения умножения матриц.

## Результат выполнения симуляции

![Результат](https://i.imgur.com/2AH4JHm.png)
