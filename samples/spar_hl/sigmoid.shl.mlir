module {
  func.func @run_main_graph() -> tensor<4xf32> {
    %cst = arith.constant dense<[-2.000000e+00, -1.000000e+00, 0.000000e+00, 2.000000e+00]> : tensor<4xf32>
    %0 = spar_hl.loadcolv(%cst) : tensor<4xf32> -> tensor<4xf32>
    %1 = tensor.empty() : tensor<4xf32>
    %2 = spar_hl.sigmoid(%0) outs(%1) : (tensor<4xf32>, tensor<4xf32>) -> tensor<4xf32>
    %3 = spar_hl.storecolv(%2) : tensor<4xf32> -> tensor<4xf32>
    spar_hl.print(%3) : tensor<4xf32>
    return %3 : tensor<4xf32>
  }
}
