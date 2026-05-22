module attributes {llvm.target_triple = "x86_64-unknown-linux-gnu"} {
  llvm.func @malloc(i64) -> !llvm.ptr
  llvm.mlir.global internal constant @__sparll_fmt_1734185305656997107("%f]\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @__sparll_fmt_10000560481934975737("%f, \00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @__sparll_fmt_12346954863685052989("[\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @__sparll_fmt_10178449352943158142("%s\00") {addr_space = 0 : i32}
  llvm.func @printf(!llvm.ptr, ...) -> i32
  llvm.func @spar_ciface_init(i32, i32, i32, i1, i1)
  llvm.mlir.global private constant @__constant_4xf32(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : tensor<4xf32>) {addr_space = 0 : i32, alignment = 64 : i64} : !llvm.array<4 x f32>
  llvm.func @run_main_graph() -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> attributes {llvm.emit_c_interface} {
    %0 = llvm.mlir.constant(0 : index) : i64
    %1 = llvm.mlir.constant(1 : index) : i64
    %2 = llvm.mlir.constant(4 : index) : i64
    %3 = llvm.mlir.constant(32 : ui32) : i32
    %4 = llvm.mlir.constant(8 : ui32) : i32
    %5 = llvm.mlir.constant(false) : i1
    llvm.call @spar_ciface_init(%3, %4, %4, %5, %5) : (i32, i32, i32, i1, i1) -> ()
    %6 = llvm.mlir.addressof @__constant_4xf32 : !llvm.ptr
    %7 = llvm.getelementptr %6[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x f32>
    %8 = llvm.mlir.addressof @__sparll_fmt_10178449352943158142 : !llvm.ptr
    %9 = llvm.getelementptr %8[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<3 x i8>
    %10 = llvm.mlir.addressof @__sparll_fmt_12346954863685052989 : !llvm.ptr
    %11 = llvm.getelementptr %10[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<2 x i8>
    %12 = llvm.call @printf(%9, %11) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.br ^bb1(%0 : i64)
  ^bb1(%13: i64):  // 2 preds: ^bb0, ^bb6
    %14 = llvm.icmp "slt" %13, %2 : i64
    llvm.cond_br %14, ^bb2, ^bb7
  ^bb2:  // pred: ^bb1
    %15 = llvm.getelementptr %7[%13] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %16 = llvm.load %15 : !llvm.ptr -> f32
    %17 = llvm.add %13, %1  : i64
    %18 = llvm.icmp "ult" %17, %2 : i64
    llvm.cond_br %18, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    %19 = llvm.fpext %16 : f32 to f64
    %20 = llvm.mlir.addressof @__sparll_fmt_10000560481934975737 : !llvm.ptr
    %21 = llvm.getelementptr %20[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<5 x i8>
    %22 = llvm.call @printf(%21, %19) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb4
  ^bb4:  // 2 preds: ^bb2, ^bb3
    %23 = llvm.icmp "uge" %17, %2 : i64
    llvm.cond_br %23, ^bb5, ^bb6
  ^bb5:  // pred: ^bb4
    %24 = llvm.fpext %16 : f32 to f64
    %25 = llvm.mlir.addressof @__sparll_fmt_1734185305656997107 : !llvm.ptr
    %26 = llvm.getelementptr %25[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<5 x i8>
    %27 = llvm.call @printf(%26, %24) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb6
  ^bb6:  // 2 preds: ^bb4, ^bb5
    llvm.br ^bb1(%17 : i64)
  ^bb7:  // pred: ^bb1
    %28 = llvm.mlir.zero : !llvm.ptr
    %29 = llvm.getelementptr %28[4] : (!llvm.ptr) -> !llvm.ptr, f32
    %30 = llvm.ptrtoint %29 : !llvm.ptr to i64
    %31 = llvm.call @malloc(%30) : (i64) -> !llvm.ptr
    %32 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %33 = llvm.insertvalue %31, %32[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %34 = llvm.insertvalue %31, %33[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %35 = llvm.insertvalue %0, %34[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %36 = llvm.insertvalue %2, %35[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %37 = llvm.insertvalue %1, %36[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %38 = llvm.mul %2, %1  : i64
    %39 = llvm.getelementptr %28[1] : (!llvm.ptr) -> !llvm.ptr, f32
    %40 = llvm.ptrtoint %39 : !llvm.ptr to i64
    %41 = llvm.mul %38, %40  : i64
    "llvm.intr.memcpy"(%31, %7, %41) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return %37 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  }
  llvm.func @_mlir_ciface_run_main_graph(%arg0: !llvm.ptr) attributes {llvm.emit_c_interface} {
    %0 = llvm.call @run_main_graph() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    llvm.store %0, %arg0 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr
    llvm.return
  }
}
