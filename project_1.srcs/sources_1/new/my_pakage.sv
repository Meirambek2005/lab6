`timescale 1ns / 1ps

`ifndef MY_PAKAGE
`define MY_PAKAGE

package my_pakage;
    parameter N = 3;
    typedef byte unsigned data_t;
    typedef data_t matrix_t[N][N];
    
endpackage
    import my_pakage::*;
    
`endif