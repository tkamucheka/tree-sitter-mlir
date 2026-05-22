#map = affine_map<(d0) -> (-d0 + 10, 8)>
module {
  func.func @run_main_graph() -> tensor<10xf32> {
    %c8 = arith.constant 8 : index
    %c10 = arith.constant 10 : index
    %c0 = arith.constant 0 : index
    %cst = arith.constant dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00, 5.000000e+00, 6.000000e+00, 7.000000e+00, 8.000000e+00, 9.000000e+00, 1.000000e+01]> : tensor<10xf32>
    %cst_0 = arith.constant dense<[1.000000e+01, 9.000000e+00, 8.000000e+00, 7.000000e+00, 6.000000e+00, 5.000000e+00, 4.000000e+00, 3.000000e+00, 2.000000e+00, 1.000000e+00]> : tensor<10xf32>
    %0 = spar_hl.loadv(%cst) : tensor<10xf32> -> tensor<10xf32>
    %1 = spar_hl.loadv(%cst_0) : tensor<10xf32> -> tensor<10xf32>
    %2 = tensor.empty() : tensor<10xf32>
    %3 = scf.for %arg0 = %c0 to %c10 step %c8 iter_args(%arg1 = %2) -> (tensor<10xf32>) {
      %5 = affine.min #map(%arg0)
      %extracted_slice = tensor.extract_slice %0[%arg0] [%5] [1] : tensor<10xf32> to tensor<?xf32>
      %extracted_slice_1 = tensor.extract_slice %1[%arg0] [%5] [1] : tensor<10xf32> to tensor<?xf32>
      %6 = tensor.empty(%5) : tensor<?xf32>
      %7 = spar_hl.add(%extracted_slice, %extracted_slice_1) outs(%6) : (tensor<?xf32>, tensor<?xf32>, tensor<?xf32>) -> tensor<?xf32>
      %inserted_slice = tensor.insert_slice %7 into %arg1[%arg0] [%5] [1] : tensor<?xf32> into tensor<10xf32>
      scf.yield %inserted_slice : tensor<10xf32>
    }
    %4 = spar_hl.storev(%3) : tensor<10xf32> -> tensor<10xf32>
    spar_hl.print(%4) : tensor<10xf32>
    return %4 : tensor<10xf32>
  }
}
