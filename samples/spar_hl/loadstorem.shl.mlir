module {
  func.func @run_main_graph() -> tensor<4x4xf32> {
    %cst = arith.constant dense<[[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00], [5.000000e+00, 6.000000e+00, 7.000000e+00, 8.000000e+00], [9.000000e+00, 1.000000e+01, 1.100000e+01, 1.200000e+01], [1.300000e+01, 1.400000e+01, 1.500000e+01, 1.600000e+01]]> : tensor<4x4xf32>
    %0 = spar_hl.loadm(%cst) : tensor<4x4xf32> -> tensor<4x4xf32>
    %1 = spar_hl.storem(%0) : tensor<4x4xf32> -> tensor<4x4xf32>
    spar_hl.print(%1) : tensor<4x4xf32>
    return %1 : tensor<4x4xf32>
  }
}
