module {
  func.func @run_main_graph() -> tensor<4xf32> {
    %cst = arith.constant dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : tensor<4xf32>
    %0 = spar_hl.loadrowv(%cst) : tensor<4xf32> -> tensor<4xf32>
    %1 = spar_hl.storerowv(%0) : tensor<4xf32> -> tensor<4xf32>
    spar_hl.print(%1) : tensor<4xf32>
    return %1 : tensor<4xf32>
  }
}
