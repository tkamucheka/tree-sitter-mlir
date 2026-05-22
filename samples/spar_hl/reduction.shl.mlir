module {
  func.func @run_main_graph() -> tensor<4xf32> {
    %cst = arith.constant dense<0.000000e+00> : tensor<4xf32>
    %cst_0 = arith.constant dense<1.000000e+00> : tensor<4x4xf32>
    %0 = spar_hl.loadm(%cst_0) : tensor<4x4xf32> -> tensor<4x4xf32>
    %1 = spar_hl.reduce(%0) outs(%cst) : (tensor<4x4xf32>, tensor<4xf32>) -> tensor<4xf32>
    %2 = spar_hl.storev(%1) : tensor<4xf32> -> tensor<4xf32>
    spar_hl.print(%2) : tensor<4xf32>
    return %2 : tensor<4xf32>
  }
}
