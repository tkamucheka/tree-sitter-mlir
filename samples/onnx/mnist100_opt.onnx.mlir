module {
  func.func @main_graph(%arg0: tensor<?xf32> {onnx.dim_params = "0:batch_size", onnx.name = "modelInput"}) -> (tensor<10xf32> {onnx.dim_params = "0:batch_size", onnx.name = "modelOutput"}) {
    %0 = onnx.Constant dense_resource<__elided__> : tensor<100x10xf32>
    %1 = onnx.Constant dense_resource<__elided__> : tensor<100x100xf32>
    %2 = onnx.Constant dense_resource<__elided__> : tensor<100xf32>
    %3 = onnx.Constant dense_resource<__elided__> : tensor<100xf32>
    %4 = onnx.Constant dense<[-0.39195168, -0.413253367, 0.286134094, -0.316729903, 0.0121104773, 0.144445464, -0.309227973, -0.383980721, 0.746963739, 0.230416492]> : tensor<10xf32>
    %5 = onnx.Constant dense_resource<__elided__> : tensor<784x100xf32>
    %6 = "onnx.MatMul"(%arg0, %5) {onnx_node_name = "/fc1/MatMul"} : (tensor<?xf32>, tensor<784x100xf32>) -> tensor<100xf32>
    %7 = "onnx.Add"(%6, %2) {onnx_node_name = "/fc1/MatMul_onnx.Add_0"} : (tensor<100xf32>, tensor<100xf32>) -> tensor<100xf32>
    %8 = "onnx.Relu"(%7) {onnx_node_name = "/Relu"} : (tensor<100xf32>) -> tensor<100xf32>
    %9 = "onnx.MatMul"(%8, %1) {onnx_node_name = "/fc2/MatMul"} : (tensor<100xf32>, tensor<100x100xf32>) -> tensor<100xf32>
    %10 = "onnx.Add"(%9, %3) {onnx_node_name = "/fc2/MatMul_onnx.Add_1"} : (tensor<100xf32>, tensor<100xf32>) -> tensor<100xf32>
    %11 = "onnx.Relu"(%10) {onnx_node_name = "/Relu_1"} : (tensor<100xf32>) -> tensor<100xf32>
    %12 = "onnx.MatMul"(%11, %0) {onnx_node_name = "/fc3/MatMul"} : (tensor<100xf32>, tensor<100x10xf32>) -> tensor<10xf32>
    %13 = "onnx.Add"(%12, %4) {onnx_node_name = "/fc3/MatMul_onnx.Add_2"} : (tensor<10xf32>, tensor<10xf32>) -> tensor<10xf32>
    return %13 : tensor<10xf32>
  }
  "onnx.EntryPoint"() {func = @main_graph} : () -> ()
}

