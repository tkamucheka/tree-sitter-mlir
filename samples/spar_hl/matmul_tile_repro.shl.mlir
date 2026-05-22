module {
  func.func @run_main_graph() -> tensor<4xf32> {
    %cst = arith.constant dense<[[1.000000e+00, -2.000000e+00, 3.000000e+00, 5.000000e-01, -1.000000e+00, 4.000000e+00, 2.000000e+00, -3.000000e+00, 2.500000e-01, -5.000000e-01, 1.500000e+00, 2.000000e+00, -4.000000e+00, 3.000000e+00, 1.000000e+00, -2.000000e+00], [-1.000000e+00, 0.000000e+00, 2.000000e+00, -3.000000e+00, 5.000000e+00, 1.000000e+00, -2.000000e+00, 5.000000e-01, 1.250000e+00, -1.500000e+00, 0.000000e+00, 1.000000e+00, 2.000000e+00, -7.500000e-01, 4.000000e+00, -1.000000e+00], [5.000000e-01, 1.500000e+00, -2.000000e+00, 1.000000e+00, 3.000000e+00, -1.000000e+00, 2.500000e+00, -5.000000e-01, -1.000000e+00, 2.000000e+00, 5.000000e-01, -3.000000e+00, 1.000000e+00, 2.000000e+00, -1.500000e+00, 4.000000e+00], [2.000000e+00, -1.000000e+00, 5.000000e-01, -5.000000e-01, 1.000000e+00, 2.000000e+00, -3.000000e+00, 4.000000e+00, 7.500000e-01, -2.500000e+00, 1.000000e+00, 0.000000e+00, -1.000000e+00, 3.000000e+00, 2.000000e+00, -4.000000e+00]]> : tensor<4x16xf32>
    %cst_0 = arith.constant dense<[[1.000000e+00, -2.000000e+00, 5.000000e-01, 3.000000e+00, -1.000000e+00, 2.000000e+00, 2.500000e-01, -7.500000e-01, 1.500000e+00, -5.000000e-01, 2.000000e+00, -1.000000e+00, 5.000000e-01, 1.000000e+00, -2.000000e+00, 4.000000e+00]]> : tensor<1x16xf32>
    %cst_1 = arith.constant dense<0.000000e+00> : tensor<4xf32>
    %extracted_slice = tensor.extract_slice %cst_0[0, 0] [1, 8] [1, 1] : tensor<1x16xf32> to tensor<1x8xf32>
    %0 = spar_hl.reshape(%extracted_slice) [[0, 1]] : tensor<1x8xf32> to tensor<8xf32>
    %1 = spar_hl.loadrowv(%0) : tensor<8xf32> -> tensor<8xf32>
    %extracted_slice_2 = tensor.extract_slice %cst[0, 0] [4, 8] [1, 1] : tensor<4x16xf32> to tensor<4x8xf32>
    %2 = spar_hl.loadm(%extracted_slice_2) : tensor<4x8xf32> -> tensor<4x8xf32>
    %3 = tensor.empty() : tensor<4x8xf32>
    %4 = spar_hl.mul(%1, %2) outs(%3) {spar.load_lhs_kind = 3 : i32, spar.load_rhs_kind = 1 : i32} : (tensor<8xf32>, tensor<4x8xf32>, tensor<4x8xf32>) -> tensor<4x8xf32>
    %5 = spar_hl.reduce(%4) outs(%cst_1) : (tensor<4x8xf32>, tensor<4xf32>) -> tensor<4xf32>
    %6 = spar_hl.loadcolv(%cst_1) : tensor<4xf32> -> tensor<4xf32>
    %7 = tensor.empty() : tensor<4xf32>
    %8 = spar_hl.add(%5, %6) outs(%7) {spar.load_rhs_kind = 4 : i32} : (tensor<4xf32>, tensor<4xf32>, tensor<4xf32>) -> tensor<4xf32>
    %9 = spar_hl.storecolv(%8) : tensor<4xf32> -> tensor<4xf32>
    %extracted_slice_3 = tensor.extract_slice %cst_0[0, 8] [1, 8] [1, 1] : tensor<1x16xf32> to tensor<1x8xf32>
    %10 = spar_hl.reshape(%extracted_slice_3) [[0, 1]] : tensor<1x8xf32> to tensor<8xf32>
    %11 = spar_hl.loadrowv(%10) : tensor<8xf32> -> tensor<8xf32>
    %extracted_slice_4 = tensor.extract_slice %cst[0, 8] [4, 8] [1, 1] : tensor<4x16xf32> to tensor<4x8xf32>
    %12 = spar_hl.loadm(%extracted_slice_4) : tensor<4x8xf32> -> tensor<4x8xf32>
    %13 = spar_hl.mul(%11, %12) outs(%3) {spar.load_lhs_kind = 3 : i32, spar.load_rhs_kind = 1 : i32} : (tensor<8xf32>, tensor<4x8xf32>, tensor<4x8xf32>) -> tensor<4x8xf32>
    %14 = spar_hl.reduce(%13) outs(%cst_1) : (tensor<4x8xf32>, tensor<4xf32>) -> tensor<4xf32>
    %15 = spar_hl.loadcolv(%9) : tensor<4xf32> -> tensor<4xf32>
    %16 = spar_hl.add(%14, %15) outs(%7) {spar.load_rhs_kind = 4 : i32} : (tensor<4xf32>, tensor<4xf32>, tensor<4xf32>) -> tensor<4xf32>
    %17 = spar_hl.storecolv(%16) : tensor<4xf32> -> tensor<4xf32>
    return %17 : tensor<4xf32>
  }
}
