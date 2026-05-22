module attributes {llvm.target_triple = "x86_64-unknown-linux-gnu"} {
  llvm.func @malloc(i64) -> !llvm.ptr
  llvm.mlir.global internal constant @__sparll_fmt_1734185305656997107("%f]\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @__sparll_fmt_10000560481934975737("%f, \00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @__sparll_fmt_12346954863685052989("[\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @__sparll_fmt_10178449352943158142("%s\00") {addr_space = 0 : i32}
  llvm.func @printf(!llvm.ptr, ...) -> i32
  llvm.func @spar_ciface_storerowv(i32, !llvm.ptr)
  llvm.func @spar_ciface_relu(i32, i32)
  llvm.func @spar_ciface_loadv_ex(i32, !llvm.ptr, !llvm.ptr)
  llvm.func @spar_ciface_allocate_reg() -> i32
  llvm.func @spar_ciface_init(i32, i32, i32, i1, i1)
  llvm.mlir.global private constant @__constant_4xf32(dense<[-2.000000e+00, -1.000000e+00, 0.000000e+00, 2.000000e+00]> : tensor<4xf32>) {addr_space = 0 : i32, alignment = 64 : i64} : !llvm.array<4 x f32>
  llvm.func @run_main_graph() -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> attributes {llvm.emit_c_interface} {
    %0 = llvm.mlir.constant(64 : index) : i64
    %1 = llvm.mlir.constant(3735928559 : index) : i64
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(0 : index) : i64
    %5 = llvm.mlir.constant(1 : index) : i64
    %6 = llvm.mlir.constant(4 : index) : i64
    %7 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %8 = llvm.mlir.constant(32 : ui32) : i32
    %9 = llvm.mlir.constant(8 : ui32) : i32
    %10 = llvm.mlir.constant(false) : i1
    llvm.call @spar_ciface_init(%8, %9, %9, %10, %10) : (i32, i32, i32, i1, i1) -> ()
    %11 = llvm.mlir.addressof @__constant_4xf32 : !llvm.ptr
    %12 = llvm.getelementptr %11[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x f32>
    %13 = llvm.inttoptr %1 : i64 to !llvm.ptr
    %14 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %15 = llvm.insertvalue %13, %14[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %16 = llvm.insertvalue %12, %15[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %17 = llvm.insertvalue %4, %16[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %18 = llvm.insertvalue %6, %17[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %19 = llvm.insertvalue %5, %18[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %20 = llvm.mlir.zero : !llvm.ptr
    %21 = llvm.getelementptr %20[4] : (!llvm.ptr) -> !llvm.ptr, f32
    %22 = llvm.ptrtoint %21 : !llvm.ptr to i64
    %23 = llvm.add %22, %0  : i64
    %24 = llvm.call @malloc(%23) : (i64) -> !llvm.ptr
    %25 = llvm.ptrtoint %24 : !llvm.ptr to i64
    %26 = llvm.sub %0, %5  : i64
    %27 = llvm.add %25, %26  : i64
    %28 = llvm.urem %27, %0  : i64
    %29 = llvm.sub %27, %28  : i64
    %30 = llvm.inttoptr %29 : i64 to !llvm.ptr
    %31 = llvm.insertvalue %24, %14[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %32 = llvm.insertvalue %30, %31[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %33 = llvm.insertvalue %4, %32[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %34 = llvm.insertvalue %6, %33[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %35 = llvm.insertvalue %5, %34[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.br ^bb1(%4 : i64)
  ^bb1(%36: i64):  // 2 preds: ^bb0, ^bb2
    %37 = llvm.icmp "slt" %36, %6 : i64
    llvm.cond_br %37, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %38 = llvm.getelementptr %30[%36] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %7, %38 : f32, !llvm.ptr
    %39 = llvm.add %36, %5  : i64
    llvm.br ^bb1(%39 : i64)
  ^bb3:  // pred: ^bb1
    %40 = llvm.call @spar_ciface_allocate_reg() : () -> i32
    %41 = llvm.call @spar_ciface_allocate_reg() : () -> i32
    %42 = llvm.alloca %3 x !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store %19, %42 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr
    %43 = llvm.alloca %3 x !llvm.array<4 x i32> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    %44 = llvm.getelementptr %43[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %2, %44 : i32, !llvm.ptr
    %45 = llvm.getelementptr %43[0, 1] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %3, %45 : i32, !llvm.ptr
    %46 = llvm.getelementptr %43[0, 2] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %2, %46 : i32, !llvm.ptr
    %47 = llvm.getelementptr %43[0, 3] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %2, %47 : i32, !llvm.ptr
    llvm.call @spar_ciface_loadv_ex(%40, %42, %43) : (i32, !llvm.ptr, !llvm.ptr) -> ()
    llvm.call @spar_ciface_relu(%41, %40) : (i32, i32) -> ()
    %48 = llvm.alloca %3 x !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store %35, %48 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr
    llvm.call @spar_ciface_storerowv(%41, %48) : (i32, !llvm.ptr) -> ()
    %49 = llvm.mlir.addressof @__sparll_fmt_10178449352943158142 : !llvm.ptr
    %50 = llvm.getelementptr %49[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<3 x i8>
    %51 = llvm.mlir.addressof @__sparll_fmt_12346954863685052989 : !llvm.ptr
    %52 = llvm.getelementptr %51[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<2 x i8>
    %53 = llvm.call @printf(%50, %52) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.br ^bb4(%4 : i64)
  ^bb4(%54: i64):  // 2 preds: ^bb3, ^bb9
    %55 = llvm.icmp "slt" %54, %6 : i64
    llvm.cond_br %55, ^bb5, ^bb10
  ^bb5:  // pred: ^bb4
    %56 = llvm.getelementptr %30[%54] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %57 = llvm.load %56 : !llvm.ptr -> f32
    %58 = llvm.add %54, %5  : i64
    %59 = llvm.icmp "ult" %58, %6 : i64
    llvm.cond_br %59, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    %60 = llvm.fpext %57 : f32 to f64
    %61 = llvm.mlir.addressof @__sparll_fmt_10000560481934975737 : !llvm.ptr
    %62 = llvm.getelementptr %61[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<5 x i8>
    %63 = llvm.call @printf(%62, %60) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb7
  ^bb7:  // 2 preds: ^bb5, ^bb6
    %64 = llvm.icmp "uge" %58, %6 : i64
    llvm.cond_br %64, ^bb8, ^bb9
  ^bb8:  // pred: ^bb7
    %65 = llvm.fpext %57 : f32 to f64
    %66 = llvm.mlir.addressof @__sparll_fmt_1734185305656997107 : !llvm.ptr
    %67 = llvm.getelementptr %66[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<5 x i8>
    %68 = llvm.call @printf(%67, %65) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb9
  ^bb9:  // 2 preds: ^bb7, ^bb8
    llvm.br ^bb4(%58 : i64)
  ^bb10:  // pred: ^bb4
    llvm.return %35 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  }
  llvm.func @_mlir_ciface_run_main_graph(%arg0: !llvm.ptr) attributes {llvm.emit_c_interface} {
    %0 = llvm.call @run_main_graph() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    llvm.store %0, %arg0 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr
    llvm.return
  }
}
