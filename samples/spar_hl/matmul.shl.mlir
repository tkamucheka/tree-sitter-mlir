module {
  func.func @run_main_graph() -> tensor<4xf32> {
    %cst = arith.constant dense<0.000000e+00> : tensor<4xf32>
    %cst_0 = arith.constant dense<1.000000e+00> : tensor<4x4xf32>
    %cst_1 = arith.constant dense<1.000000e+00> : tensor<4xf32>
    %0 = spar_hl.loadm(%cst_0) : tensor<4x4xf32> -> tensor<4x4xf32>
    %1 = spar_hl.loadv(%cst_1) : tensor<4xf32> -> tensor<4xf32>
    %2 = tensor.empty() : tensor<4x4xf32>
    %3 = spar_hl.mul(%1, %0) outs(%2) {spar.load_lhs_kind = 2 : i32, spar.load_rhs_kind = 1 : i32} : (tensor<4xf32>, tensor<4x4xf32>, tensor<4x4xf32>) -> tensor<4x4xf32>
    %4 = spar_hl.storem(%3) : tensor<4x4xf32> -> tensor<4x4xf32>
    spar_hl.print(%4) : tensor<4x4xf32>
    %5 = spar_hl.reduce(%3) outs(%cst) : (tensor<4x4xf32>, tensor<4xf32>) -> tensor<4xf32>
    %6 = spar_hl.storev(%5) : tensor<4xf32> -> tensor<4xf32>
    spar_hl.print(%6) : tensor<4xf32>
    return %6 : tensor<4xf32>
  }
}
