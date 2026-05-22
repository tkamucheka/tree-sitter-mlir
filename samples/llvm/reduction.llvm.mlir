module attributes {llvm.target_triple = "x86_64-unknown-linux-gnu"} {
  llvm.func @malloc(i64) -> !llvm.ptr
  llvm.mlir.global internal constant @__sparll_fmt_1734185305656997107("%f]\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @__sparll_fmt_10000560481934975737("%f, \00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @__sparll_fmt_12346954863685052989("[\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @__sparll_fmt_10178449352943158142("%s\00") {addr_space = 0 : i32}
  llvm.func @printf(!llvm.ptr, ...) -> i32
  llvm.func @spar_ciface_storecolv(i32, !llvm.ptr)
  llvm.func @spar_ciface_add(i32, i32, i32)
  llvm.func @spar_ciface_loadv_ex(i32, !llvm.ptr, !llvm.ptr)
  llvm.func @spar_ciface_reduce(i32, i32)
  llvm.func @spar_ciface_loadm(i32, !llvm.ptr)
  llvm.func @spar_ciface_allocate_reg() -> i32
  llvm.func @spar_ciface_init(i32, i32, i32, i1, i1)
  llvm.mlir.global private constant @__constant_4x4xf32(dense<1.000000e+00> : tensor<4x4xf32>) {addr_space = 0 : i32, alignment = 64 : i64} : !llvm.array<4 x array<4 x f32>>
  llvm.mlir.global private constant @__constant_4xf32(dense<0.000000e+00> : tensor<4xf32>) {addr_space = 0 : i32, alignment = 64 : i64} : !llvm.array<4 x f32>
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
    %13 = llvm.mlir.addressof @__constant_4x4xf32 : !llvm.ptr
    %14 = llvm.getelementptr %13[0, 0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x array<4 x f32>>
    %15 = llvm.inttoptr %1 : i64 to !llvm.ptr
    %16 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %17 = llvm.insertvalue %15, %16[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %18 = llvm.insertvalue %14, %17[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %19 = llvm.insertvalue %4, %18[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %20 = llvm.insertvalue %6, %19[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %21 = llvm.insertvalue %6, %20[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %22 = llvm.insertvalue %6, %21[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %23 = llvm.insertvalue %5, %22[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %24 = llvm.mlir.zero : !llvm.ptr
    %25 = llvm.getelementptr %24[4] : (!llvm.ptr) -> !llvm.ptr, f32
    %26 = llvm.ptrtoint %25 : !llvm.ptr to i64
    %27 = llvm.add %26, %0  : i64
    %28 = llvm.call @malloc(%27) : (i64) -> !llvm.ptr
    %29 = llvm.ptrtoint %28 : !llvm.ptr to i64
    %30 = llvm.sub %0, %5  : i64
    %31 = llvm.add %29, %30  : i64
    %32 = llvm.urem %31, %0  : i64
    %33 = llvm.sub %31, %32  : i64
    %34 = llvm.inttoptr %33 : i64 to !llvm.ptr
    %35 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %36 = llvm.insertvalue %28, %35[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %37 = llvm.insertvalue %34, %36[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %38 = llvm.insertvalue %4, %37[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %39 = llvm.insertvalue %6, %38[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %40 = llvm.insertvalue %5, %39[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.br ^bb1(%4 : i64)
  ^bb1(%41: i64):  // 2 preds: ^bb0, ^bb2
    %42 = llvm.icmp "slt" %41, %6 : i64
    llvm.cond_br %42, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %43 = llvm.getelementptr %34[%41] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %7, %43 : f32, !llvm.ptr
    %44 = llvm.add %41, %5  : i64
    llvm.br ^bb1(%44 : i64)
  ^bb3:  // pred: ^bb1
    %45 = llvm.mul %6, %5  : i64
    %46 = llvm.getelementptr %24[1] : (!llvm.ptr) -> !llvm.ptr, f32
    %47 = llvm.ptrtoint %46 : !llvm.ptr to i64
    %48 = llvm.mul %45, %47  : i64
    "llvm.intr.memcpy"(%34, %12, %48) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %49 = llvm.call @spar_ciface_allocate_reg() : () -> i32
    %50 = llvm.call @spar_ciface_allocate_reg() : () -> i32
    %51 = llvm.alloca %3 x !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store %23, %51 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr
    llvm.call @spar_ciface_loadm(%49, %51) : (i32, !llvm.ptr) -> ()
    llvm.call @spar_ciface_reduce(%50, %49) : (i32, i32) -> ()
    %52 = llvm.call @spar_ciface_allocate_reg() : () -> i32
    %53 = llvm.call @spar_ciface_allocate_reg() : () -> i32
    %54 = llvm.alloca %3 x !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store %40, %54 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr
    %55 = llvm.alloca %3 x !llvm.array<4 x i32> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    %56 = llvm.getelementptr %55[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %2, %56 : i32, !llvm.ptr
    %57 = llvm.getelementptr %55[0, 1] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %3, %57 : i32, !llvm.ptr
    %58 = llvm.getelementptr %55[0, 2] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %2, %58 : i32, !llvm.ptr
    %59 = llvm.getelementptr %55[0, 3] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %2, %59 : i32, !llvm.ptr
    llvm.call @spar_ciface_loadv_ex(%52, %54, %55) : (i32, !llvm.ptr, !llvm.ptr) -> ()
    llvm.call @spar_ciface_add(%53, %50, %52) : (i32, i32, i32) -> ()
    %60 = llvm.alloca %3 x !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store %40, %60 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr
    llvm.call @spar_ciface_storecolv(%53, %60) : (i32, !llvm.ptr) -> ()
    %61 = llvm.mlir.addressof @__sparll_fmt_10178449352943158142 : !llvm.ptr
    %62 = llvm.getelementptr %61[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<3 x i8>
    %63 = llvm.mlir.addressof @__sparll_fmt_12346954863685052989 : !llvm.ptr
    %64 = llvm.getelementptr %63[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<2 x i8>
    %65 = llvm.call @printf(%62, %64) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.br ^bb4(%4 : i64)
  ^bb4(%66: i64):  // 2 preds: ^bb3, ^bb9
    %67 = llvm.icmp "slt" %66, %6 : i64
    llvm.cond_br %67, ^bb5, ^bb10
  ^bb5:  // pred: ^bb4
    %68 = llvm.getelementptr %34[%66] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %69 = llvm.load %68 : !llvm.ptr -> f32
    %70 = llvm.add %66, %5  : i64
    %71 = llvm.icmp "ult" %70, %6 : i64
    llvm.cond_br %71, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    %72 = llvm.fpext %69 : f32 to f64
    %73 = llvm.mlir.addressof @__sparll_fmt_10000560481934975737 : !llvm.ptr
    %74 = llvm.getelementptr %73[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<5 x i8>
    %75 = llvm.call @printf(%74, %72) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb7
  ^bb7:  // 2 preds: ^bb5, ^bb6
    %76 = llvm.icmp "uge" %70, %6 : i64
    llvm.cond_br %76, ^bb8, ^bb9
  ^bb8:  // pred: ^bb7
    %77 = llvm.fpext %69 : f32 to f64
    %78 = llvm.mlir.addressof @__sparll_fmt_1734185305656997107 : !llvm.ptr
    %79 = llvm.getelementptr %78[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<5 x i8>
    %80 = llvm.call @printf(%79, %77) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb9
  ^bb9:  // 2 preds: ^bb7, ^bb8
    llvm.br ^bb4(%70 : i64)
  ^bb10:  // pred: ^bb4
    llvm.return %40 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  }
  llvm.func @_mlir_ciface_run_main_graph(%arg0: !llvm.ptr) attributes {llvm.emit_c_interface} {
    %0 = llvm.call @run_main_graph() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    llvm.store %0, %arg0 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr
    llvm.return
  }
}
