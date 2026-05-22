module {
  func.func @main_graph(%arg0: tensor<1x1xi32> {onnx.name = "input"}, %arg1: tensor<1x1024xf32> {onnx.name = "h_previous"}, %arg2: tensor<1x1024xf32> {onnx.name = "c_previous"}) -> (tensor<1x1x65xf32> {onnx.name = "output"}, tensor<1x1024xf32> {onnx.name = "h_current"}, tensor<1x1024xf32> {onnx.name = "c_current"}) {
    %0 = "onnx.NoValue"() {onnx_node_name = "onnx.NoValue_0", value} : () -> none
    %1 = onnx.Constant dense_resource<__elided__> : tensor<4096xf32>
    %2 = onnx.Constant dense_resource<__elided__> : tensor<1024x4096xf32>
    %3 = onnx.Constant dense_resource<__elided__> : tensor<256x4096xf32>
    %4 = onnx.Constant dense<65> : tensor<i32>
    %5 = onnx.Constant dense_resource<__elided__> : tensor<65x256xf32>
    %6 = onnx.Constant dense_resource<__elided__> : tensor<1024x65xf32>
    %7 = onnx.Constant dense_resource<__elided__> : tensor<65xf32>
    %8 = onnx.Constant dense<0> : tensor<1xi64>
    %9 = onnx.Constant dense<0.000000e+00> : tensor<f32>
    %10 = onnx.Constant dense<1> : tensor<1xi64>
    %11 = "onnx.Add"(%arg0, %4) {onnx_node_name = "shakespeare_1_1/embedding_1_1/add"} : (tensor<1x1xi32>, tensor<i32>) -> tensor<1x1xi32>
    %12 = "onnx.Cast"(%arg0) {onnx_node_name = "shakespeare_1_1/embedding_1_1/Less__11", saturate = 1 : si64, to = f32} : (tensor<1x1xi32>) -> tensor<1x1xf32>
    %13 = "onnx.Gemm"(%arg1, %2, %1) {alpha = 1.000000e+00 : f32, beta = 1.000000e+00 : f32, onnx_node_name = "shakespeare_1_1/rnn_1_1/lstm_cell_1_1/MatMul_1_Gemm__10", transA = 0 : si64, transB = 0 : si64} : (tensor<1x1024xf32>, tensor<1024x4096xf32>, tensor<4096xf32>) -> tensor<1x4096xf32>
    %14 = "onnx.Less"(%12, %9) {onnx_node_name = "shakespeare_1_1/embedding_1_1/Less"} : (tensor<1x1xf32>, tensor<f32>) -> tensor<1x1xi1>
    %15 = "onnx.Not"(%14) {onnx_node_name = "shakespeare_1_1/embedding_1_1/SelectV2__14"} : (tensor<1x1xi1>) -> tensor<1x1xi1>
    %16 = "onnx.Cast"(%15) {onnx_node_name = "shakespeare_1_1/embedding_1_1/SelectV2__15", saturate = 1 : si64, to = i32} : (tensor<1x1xi1>) -> tensor<1x1xi32>
    %17 = "onnx.Mul"(%arg0, %16) {onnx_node_name = "shakespeare_1_1/embedding_1_1/SelectV2__17"} : (tensor<1x1xi32>, tensor<1x1xi32>) -> tensor<1x1xi32>
    %18 = "onnx.Cast"(%14) {onnx_node_name = "shakespeare_1_1/embedding_1_1/SelectV2__13", saturate = 1 : si64, to = i32} : (tensor<1x1xi1>) -> tensor<1x1xi32>
    %19 = "onnx.Mul"(%18, %11) {onnx_node_name = "shakespeare_1_1/embedding_1_1/SelectV2__16"} : (tensor<1x1xi32>, tensor<1x1xi32>) -> tensor<1x1xi32>
    %20 = "onnx.Add"(%19, %17) {onnx_node_name = "shakespeare_1_1/embedding_1_1/SelectV2"} : (tensor<1x1xi32>, tensor<1x1xi32>) -> tensor<1x1xi32>
    %21 = "onnx.Gather"(%5, %20) {axis = 0 : si64, onnx_node_name = "shakespeare_1_1/embedding_1_1/GatherV2"} : (tensor<65x256xf32>, tensor<1x1xi32>) -> tensor<1x1x256xf32>
    %22 = "onnx.Split"(%21, %0) {axis = 1 : si64, onnx_node_name = "shakespeare_1_1/embedding_1_1/GatherV2_onnx.Split_1"} : (tensor<1x1x256xf32>, none) -> tensor<1x1x256xf32>
    %23 = "onnx.Squeeze"(%22, %10) {onnx_node_name = "shakespeare_1_1/rnn_1_1/unstack__18"} : (tensor<1x1x256xf32>, tensor<1xi64>) -> tensor<1x256xf32>
    %24 = "onnx.Gemm"(%23, %3, %13) {alpha = 1.000000e+00 : f32, beta = 1.000000e+00 : f32, onnx_node_name = "shakespeare_1_1/rnn_1_1/unstack__18_onnx.Gemm_2", transA = 0 : si64, transB = 0 : si64} : (tensor<1x256xf32>, tensor<256x4096xf32>, tensor<1x4096xf32>) -> tensor<1x4096xf32>
    %25:4 = "onnx.Split"(%24, %0) {axis = 1 : si64, onnx_node_name = "onnx.Split_3"} : (tensor<1x4096xf32>, none) -> (tensor<1x1024xf32>, tensor<1x1024xf32>, tensor<1x1024xf32>, tensor<1x1024xf32>)
    %26 = "onnx.Tanh"(%25#2) {onnx_node_name = "shakespeare_1_1/rnn_1_1/lstm_cell_1_1/Tanh"} : (tensor<1x1024xf32>) -> tensor<1x1024xf32>
    %27 = "onnx.Sigmoid"(%25#3) {onnx_node_name = "shakespeare_1_1/rnn_1_1/lstm_cell_1_1/Sigmoid_2"} : (tensor<1x1024xf32>) -> tensor<1x1024xf32>
    %28 = "onnx.Sigmoid"(%25#1) {onnx_node_name = "shakespeare_1_1/rnn_1_1/lstm_cell_1_1/Sigmoid_1"} : (tensor<1x1024xf32>) -> tensor<1x1024xf32>
    %29 = "onnx.Sigmoid"(%25#0) {onnx_node_name = "shakespeare_1_1/rnn_1_1/lstm_cell_1_1/Sigmoid"} : (tensor<1x1024xf32>) -> tensor<1x1024xf32>
    %30 = "onnx.Mul"(%29, %26) {onnx_node_name = "shakespeare_1_1/rnn_1_1/lstm_cell_1_1/mul_1"} : (tensor<1x1024xf32>, tensor<1x1024xf32>) -> tensor<1x1024xf32>
    %31 = "onnx.Mul"(%28, %arg2) {onnx_node_name = "shakespeare_1_1/rnn_1_1/lstm_cell_1_1/mul"} : (tensor<1x1024xf32>, tensor<1x1024xf32>) -> tensor<1x1024xf32>
    %32 = "onnx.Add"(%31, %30) {onnx_node_name = "shakespeare_1_1/rnn_1_1/lstm_cell_1_1/add_2"} : (tensor<1x1024xf32>, tensor<1x1024xf32>) -> tensor<1x1024xf32>
    %33 = "onnx.Tanh"(%32) {onnx_node_name = "shakespeare_1_1/rnn_1_1/lstm_cell_1_1/Tanh_1"} : (tensor<1x1024xf32>) -> tensor<1x1024xf32>
    %34 = "onnx.Mul"(%27, %33) {onnx_node_name = "shakespeare_1_1/rnn_1_1/lstm_cell_1_1/mul_2"} : (tensor<1x1024xf32>, tensor<1x1024xf32>) -> tensor<1x1024xf32>
    %35 = "onnx.Unsqueeze"(%34, %8) {onnx_node_name = "shakespeare_1_1/rnn_1_1/stack"} : (tensor<1x1024xf32>, tensor<1xi64>) -> tensor<1x1x1024xf32>
    %36 = "onnx.MatMul"(%35, %6) {onnx_node_name = "shakespeare_1_1/dense_1_1/MatMul"} : (tensor<1x1x1024xf32>, tensor<1024x65xf32>) -> tensor<1x1x65xf32>
    %37 = "onnx.Add"(%36, %7) {onnx_node_name = "shakespeare_1_1/dense_1_1/Add"} : (tensor<1x1x65xf32>, tensor<65xf32>) -> tensor<1x1x65xf32>
    return %37, %34, %32 : tensor<1x1x65xf32>, tensor<1x1024xf32>, tensor<1x1024xf32>
  }
  "onnx.EntryPoint"() {func = @main_graph} : () -> ()
}

