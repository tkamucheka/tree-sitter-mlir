module attributes {llvm.target_triple = "x86_64-unknown-linux-gnu"} {
  llvm.func @malloc(i64) -> !llvm.ptr
  llvm.mlir.global internal constant @__sparll_fmt_6877663594892849040("]\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @__sparll_fmt_13007494805068090019("\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @__sparll_fmt_13760337646998457475(",\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @__sparll_fmt_12851831707923366372("%f]\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @__sparll_fmt_10000560481934975737("%f, \00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @__sparll_fmt_3935923456386810301("  [\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @__sparll_fmt_10004117980908537893("[\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @__sparll_fmt_10178449352943158142("%s\00") {addr_space = 0 : i32}
  llvm.func @printf(!llvm.ptr, ...) -> i32
  llvm.func @spar_ciface_init(i32, i32, i32, i1, i1)
  llvm.mlir.global private constant @__constant_4x4xf32(dense<[[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00], [5.000000e+00, 6.000000e+00, 7.000000e+00, 8.000000e+00], [9.000000e+00, 1.000000e+01, 1.100000e+01, 1.200000e+01], [1.300000e+01, 1.400000e+01, 1.500000e+01, 1.600000e+01]]> : tensor<4x4xf32>) {addr_space = 0 : i32, alignment = 64 : i64} : !llvm.array<4 x array<4 x f32>>
  llvm.func @run_main_graph() -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> attributes {llvm.emit_c_interface} {
    %0 = llvm.mlir.constant(0 : index) : i64
    %1 = llvm.mlir.constant(1 : index) : i64
    %2 = llvm.mlir.constant(4 : index) : i64
    %3 = llvm.mlir.constant(32 : ui32) : i32
    %4 = llvm.mlir.constant(8 : ui32) : i32
    %5 = llvm.mlir.constant(false) : i1
    llvm.call @spar_ciface_init(%3, %4, %4, %5, %5) : (i32, i32, i32, i1, i1) -> ()
    %6 = llvm.mlir.addressof @__constant_4x4xf32 : !llvm.ptr
    %7 = llvm.getelementptr %6[0, 0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x array<4 x f32>>
    %8 = llvm.mlir.addressof @__sparll_fmt_10178449352943158142 : !llvm.ptr
    %9 = llvm.getelementptr %8[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<3 x i8>
    %10 = llvm.mlir.addressof @__sparll_fmt_10004117980908537893 : !llvm.ptr
    %11 = llvm.getelementptr %10[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<3 x i8>
    %12 = llvm.call @printf(%9, %11) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.br ^bb1(%0 : i64)
  ^bb1(%13: i64):  // 2 preds: ^bb0, ^bb13
    %14 = llvm.icmp "slt" %13, %2 : i64
    llvm.cond_br %14, ^bb2, ^bb14
  ^bb2:  // pred: ^bb1
    %15 = llvm.mlir.addressof @__sparll_fmt_3935923456386810301 : !llvm.ptr
    %16 = llvm.getelementptr %15[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i8>
    %17 = llvm.call @printf(%9, %16) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.br ^bb3(%0 : i64)
  ^bb3(%18: i64):  // 2 preds: ^bb2, ^bb8
    %19 = llvm.icmp "slt" %18, %2 : i64
    llvm.cond_br %19, ^bb4, ^bb9
  ^bb4:  // pred: ^bb3
    %20 = llvm.mul %13, %2  : i64
    %21 = llvm.add %20, %18  : i64
    %22 = llvm.getelementptr %7[%21] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %23 = llvm.load %22 : !llvm.ptr -> f32
    %24 = llvm.add %18, %1  : i64
    %25 = llvm.icmp "ult" %24, %2 : i64
    llvm.cond_br %25, ^bb5, ^bb6
  ^bb5:  // pred: ^bb4
    %26 = llvm.fpext %23 : f32 to f64
    %27 = llvm.mlir.addressof @__sparll_fmt_10000560481934975737 : !llvm.ptr
    %28 = llvm.getelementptr %27[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<5 x i8>
    %29 = llvm.call @printf(%28, %26) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb6
  ^bb6:  // 2 preds: ^bb4, ^bb5
    %30 = llvm.icmp "uge" %24, %2 : i64
    llvm.cond_br %30, ^bb7, ^bb8
  ^bb7:  // pred: ^bb6
    %31 = llvm.fpext %23 : f32 to f64
    %32 = llvm.mlir.addressof @__sparll_fmt_12851831707923366372 : !llvm.ptr
    %33 = llvm.getelementptr %32[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i8>
    %34 = llvm.call @printf(%33, %31) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb8
  ^bb8:  // 2 preds: ^bb6, ^bb7
    llvm.br ^bb3(%24 : i64)
  ^bb9:  // pred: ^bb3
    %35 = llvm.add %13, %1  : i64
    %36 = llvm.icmp "ult" %35, %2 : i64
    llvm.cond_br %36, ^bb10, ^bb11
  ^bb10:  // pred: ^bb9
    %37 = llvm.mlir.addressof @__sparll_fmt_13760337646998457475 : !llvm.ptr
    %38 = llvm.getelementptr %37[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<3 x i8>
    %39 = llvm.call @printf(%9, %38) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.br ^bb11
  ^bb11:  // 2 preds: ^bb9, ^bb10
    %40 = llvm.icmp "uge" %35, %2 : i64
    llvm.cond_br %40, ^bb12, ^bb13
  ^bb12:  // pred: ^bb11
    %41 = llvm.mlir.addressof @__sparll_fmt_13007494805068090019 : !llvm.ptr
    %42 = llvm.getelementptr %41[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<2 x i8>
    %43 = llvm.call @printf(%9, %42) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.br ^bb13
  ^bb13:  // 2 preds: ^bb11, ^bb12
    llvm.br ^bb1(%35 : i64)
  ^bb14:  // pred: ^bb1
    %44 = llvm.mlir.addressof @__sparll_fmt_6877663594892849040 : !llvm.ptr
    %45 = llvm.getelementptr %44[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<3 x i8>
    %46 = llvm.call @printf(%9, %45) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    %47 = llvm.mlir.zero : !llvm.ptr
    %48 = llvm.getelementptr %47[16] : (!llvm.ptr) -> !llvm.ptr, f32
    %49 = llvm.ptrtoint %48 : !llvm.ptr to i64
    %50 = llvm.call @malloc(%49) : (i64) -> !llvm.ptr
    %51 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %52 = llvm.insertvalue %50, %51[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %53 = llvm.insertvalue %50, %52[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %54 = llvm.insertvalue %0, %53[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %55 = llvm.insertvalue %2, %54[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %56 = llvm.insertvalue %2, %55[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %57 = llvm.insertvalue %2, %56[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %58 = llvm.insertvalue %1, %57[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %59 = llvm.mul %2, %1  : i64
    %60 = llvm.mul %59, %2  : i64
    %61 = llvm.getelementptr %47[1] : (!llvm.ptr) -> !llvm.ptr, f32
    %62 = llvm.ptrtoint %61 : !llvm.ptr to i64
    %63 = llvm.mul %60, %62  : i64
    "llvm.intr.memcpy"(%50, %7, %63) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return %58 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
  }
  llvm.func @_mlir_ciface_run_main_graph(%arg0: !llvm.ptr) attributes {llvm.emit_c_interface} {
    %0 = llvm.call @run_main_graph() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    llvm.store %0, %arg0 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr
    llvm.return
  }
}
