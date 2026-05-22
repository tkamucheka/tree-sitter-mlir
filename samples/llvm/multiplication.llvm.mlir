module attributes {llvm.target_triple = "x86_64-unknown-linux-gnu"} {
  llvm.func @free(!llvm.ptr)
  llvm.func @memrefCopy(i64, !llvm.ptr, !llvm.ptr)
  llvm.func @malloc(i64) -> !llvm.ptr
  llvm.mlir.global internal constant @__sparll_fmt_1734185305656997107("%f]\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @__sparll_fmt_10000560481934975737("%f, \00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @__sparll_fmt_12346954863685052989("[\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @__sparll_fmt_10178449352943158142("%s\00") {addr_space = 0 : i32}
  llvm.func @printf(!llvm.ptr, ...) -> i32
  llvm.func @spar_ciface_storev(i32, !llvm.ptr)
  llvm.func @spar_ciface_mul(i32, i32, i32)
  llvm.func @spar_ciface_loadv_ex(i32, !llvm.ptr, !llvm.ptr)
  llvm.func @spar_ciface_allocate_reg() -> i32
  llvm.func @spar_ciface_init(i32, i32, i32, i1, i1)
  llvm.mlir.global private constant @__constant_10xf32_0(dense<[1.000000e+01, 9.000000e+00, 8.000000e+00, 7.000000e+00, 6.000000e+00, 5.000000e+00, 4.000000e+00, 3.000000e+00, 2.000000e+00, 1.000000e+00]> : tensor<10xf32>) {addr_space = 0 : i32, alignment = 64 : i64} : !llvm.array<10 x f32>
  llvm.mlir.global private constant @__constant_10xf32(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00, 5.000000e+00, 6.000000e+00, 7.000000e+00, 8.000000e+00, 9.000000e+00, 1.000000e+01]> : tensor<10xf32>) {addr_space = 0 : i32, alignment = 64 : i64} : !llvm.array<10 x f32>
  llvm.func @run_main_graph() -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> attributes {llvm.emit_c_interface} {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(64 : index) : i64
    %2 = llvm.mlir.constant(3735928559 : index) : i64
    %3 = llvm.mlir.constant(8 : index) : i64
    %4 = llvm.mlir.constant(10 : index) : i64
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.mlir.constant(0 : index) : i64
    %8 = llvm.mlir.constant(1 : index) : i64
    %9 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %10 = llvm.mlir.constant(32 : ui32) : i32
    %11 = llvm.mlir.constant(8 : ui32) : i32
    %12 = llvm.mlir.constant(false) : i1
    llvm.call @spar_ciface_init(%10, %11, %11, %12, %12) : (i32, i32, i32, i1, i1) -> ()
    %13 = llvm.mlir.addressof @__constant_10xf32 : !llvm.ptr
    %14 = llvm.getelementptr %13[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<10 x f32>
    %15 = llvm.inttoptr %2 : i64 to !llvm.ptr
    %16 = llvm.mlir.addressof @__constant_10xf32_0 : !llvm.ptr
    %17 = llvm.getelementptr %16[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<10 x f32>
    %18 = llvm.mlir.zero : !llvm.ptr
    %19 = llvm.getelementptr %18[10] : (!llvm.ptr) -> !llvm.ptr, f32
    %20 = llvm.ptrtoint %19 : !llvm.ptr to i64
    %21 = llvm.add %20, %1  : i64
    %22 = llvm.call @malloc(%21) : (i64) -> !llvm.ptr
    %23 = llvm.ptrtoint %22 : !llvm.ptr to i64
    %24 = llvm.sub %1, %8  : i64
    %25 = llvm.add %23, %24  : i64
    %26 = llvm.urem %25, %1  : i64
    %27 = llvm.sub %25, %26  : i64
    %28 = llvm.inttoptr %27 : i64 to !llvm.ptr
    %29 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %30 = llvm.insertvalue %22, %29[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %31 = llvm.insertvalue %28, %30[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %32 = llvm.insertvalue %7, %31[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %33 = llvm.insertvalue %4, %32[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %34 = llvm.insertvalue %8, %33[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.br ^bb1(%7 : i64)
  ^bb1(%35: i64):  // 2 preds: ^bb0, ^bb2
    %36 = llvm.icmp "slt" %35, %4 : i64
    llvm.cond_br %36, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %37 = llvm.getelementptr %28[%35] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %9, %37 : f32, !llvm.ptr
    %38 = llvm.add %35, %8  : i64
    llvm.br ^bb1(%38 : i64)
  ^bb3:  // pred: ^bb1
    llvm.br ^bb4(%7 : i64)
  ^bb4(%39: i64):  // 2 preds: ^bb3, ^bb8
    %40 = llvm.icmp "slt" %39, %4 : i64
    llvm.cond_br %40, ^bb5, ^bb9
  ^bb5:  // pred: ^bb4
    %41 = llvm.sub %4, %39  : i64
    %42 = llvm.intr.smin(%41, %3)  : (i64, i64) -> i64
    %43 = llvm.insertvalue %15, %29[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %44 = llvm.insertvalue %14, %43[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %45 = llvm.insertvalue %39, %44[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %46 = llvm.insertvalue %42, %45[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %47 = llvm.insertvalue %8, %46[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %48 = llvm.insertvalue %17, %43[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %49 = llvm.insertvalue %39, %48[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %50 = llvm.insertvalue %42, %49[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %51 = llvm.insertvalue %8, %50[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %52 = llvm.getelementptr %18[%42] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %53 = llvm.ptrtoint %52 : !llvm.ptr to i64
    %54 = llvm.add %53, %1  : i64
    %55 = llvm.call @malloc(%54) : (i64) -> !llvm.ptr
    %56 = llvm.ptrtoint %55 : !llvm.ptr to i64
    %57 = llvm.add %56, %24  : i64
    %58 = llvm.urem %57, %1  : i64
    %59 = llvm.sub %57, %58  : i64
    %60 = llvm.inttoptr %59 : i64 to !llvm.ptr
    %61 = llvm.insertvalue %55, %29[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %62 = llvm.insertvalue %60, %61[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %63 = llvm.insertvalue %7, %62[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %64 = llvm.insertvalue %42, %63[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %65 = llvm.insertvalue %8, %64[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.br ^bb6(%7 : i64)
  ^bb6(%66: i64):  // 2 preds: ^bb5, ^bb7
    %67 = llvm.icmp "slt" %66, %42 : i64
    llvm.cond_br %67, ^bb7, ^bb8
  ^bb7:  // pred: ^bb6
    %68 = llvm.getelementptr %60[%66] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %9, %68 : f32, !llvm.ptr
    %69 = llvm.add %66, %8  : i64
    llvm.br ^bb6(%69 : i64)
  ^bb8:  // pred: ^bb6
    %70 = llvm.call @spar_ciface_allocate_reg() : () -> i32
    %71 = llvm.call @spar_ciface_allocate_reg() : () -> i32
    %72 = llvm.call @spar_ciface_allocate_reg() : () -> i32
    %73 = llvm.alloca %6 x !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store %47, %73 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr
    %74 = llvm.alloca %6 x !llvm.array<4 x i32> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    %75 = llvm.getelementptr %74[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %5, %75 : i32, !llvm.ptr
    %76 = llvm.getelementptr %74[0, 1] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %5, %76 : i32, !llvm.ptr
    %77 = llvm.getelementptr %74[0, 2] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %5, %77 : i32, !llvm.ptr
    %78 = llvm.getelementptr %74[0, 3] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %5, %78 : i32, !llvm.ptr
    llvm.call @spar_ciface_loadv_ex(%70, %73, %74) : (i32, !llvm.ptr, !llvm.ptr) -> ()
    %79 = llvm.alloca %6 x !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store %51, %79 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr
    %80 = llvm.alloca %6 x !llvm.array<4 x i32> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    %81 = llvm.getelementptr %80[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %5, %81 : i32, !llvm.ptr
    %82 = llvm.getelementptr %80[0, 1] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %5, %82 : i32, !llvm.ptr
    %83 = llvm.getelementptr %80[0, 2] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %5, %83 : i32, !llvm.ptr
    %84 = llvm.getelementptr %80[0, 3] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %5, %84 : i32, !llvm.ptr
    llvm.call @spar_ciface_loadv_ex(%71, %79, %80) : (i32, !llvm.ptr, !llvm.ptr) -> ()
    llvm.call @spar_ciface_mul(%72, %70, %71) : (i32, i32, i32) -> ()
    %85 = llvm.alloca %6 x !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store %65, %85 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr
    llvm.call @spar_ciface_storev(%72, %85) : (i32, !llvm.ptr) -> ()
    %86 = llvm.insertvalue %39, %31[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %87 = llvm.insertvalue %42, %86[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %88 = llvm.insertvalue %8, %87[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %89 = llvm.intr.stacksave : !llvm.ptr
    %90 = llvm.alloca %8 x !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> : (i64) -> !llvm.ptr
    llvm.store %65, %90 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr
    %91 = llvm.mlir.undef : !llvm.struct<(i64, ptr)>
    %92 = llvm.insertvalue %0, %91[0] : !llvm.struct<(i64, ptr)> 
    %93 = llvm.insertvalue %90, %92[1] : !llvm.struct<(i64, ptr)> 
    %94 = llvm.alloca %8 x !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> : (i64) -> !llvm.ptr
    llvm.store %88, %94 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr
    %95 = llvm.insertvalue %94, %92[1] : !llvm.struct<(i64, ptr)> 
    %96 = llvm.alloca %8 x !llvm.struct<(i64, ptr)> : (i64) -> !llvm.ptr
    llvm.store %93, %96 : !llvm.struct<(i64, ptr)>, !llvm.ptr
    %97 = llvm.alloca %8 x !llvm.struct<(i64, ptr)> : (i64) -> !llvm.ptr
    llvm.store %95, %97 : !llvm.struct<(i64, ptr)>, !llvm.ptr
    %98 = llvm.getelementptr %18[1] : (!llvm.ptr) -> !llvm.ptr, f32
    %99 = llvm.ptrtoint %98 : !llvm.ptr to i64
    llvm.call @memrefCopy(%99, %96, %97) : (i64, !llvm.ptr, !llvm.ptr) -> ()
    llvm.intr.stackrestore %89 : !llvm.ptr
    llvm.call @free(%55) : (!llvm.ptr) -> ()
    %100 = llvm.add %39, %3  : i64
    llvm.br ^bb4(%100 : i64)
  ^bb9:  // pred: ^bb4
    %101 = llvm.mlir.addressof @__sparll_fmt_10178449352943158142 : !llvm.ptr
    %102 = llvm.getelementptr %101[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<3 x i8>
    %103 = llvm.mlir.addressof @__sparll_fmt_12346954863685052989 : !llvm.ptr
    %104 = llvm.getelementptr %103[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<2 x i8>
    %105 = llvm.call @printf(%102, %104) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.br ^bb10(%7 : i64)
  ^bb10(%106: i64):  // 2 preds: ^bb9, ^bb15
    %107 = llvm.icmp "slt" %106, %4 : i64
    llvm.cond_br %107, ^bb11, ^bb16
  ^bb11:  // pred: ^bb10
    %108 = llvm.getelementptr %28[%106] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %109 = llvm.load %108 : !llvm.ptr -> f32
    %110 = llvm.add %106, %8  : i64
    %111 = llvm.icmp "ult" %110, %4 : i64
    llvm.cond_br %111, ^bb12, ^bb13
  ^bb12:  // pred: ^bb11
    %112 = llvm.fpext %109 : f32 to f64
    %113 = llvm.mlir.addressof @__sparll_fmt_10000560481934975737 : !llvm.ptr
    %114 = llvm.getelementptr %113[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<5 x i8>
    %115 = llvm.call @printf(%114, %112) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb13
  ^bb13:  // 2 preds: ^bb11, ^bb12
    %116 = llvm.icmp "uge" %110, %4 : i64
    llvm.cond_br %116, ^bb14, ^bb15
  ^bb14:  // pred: ^bb13
    %117 = llvm.fpext %109 : f32 to f64
    %118 = llvm.mlir.addressof @__sparll_fmt_1734185305656997107 : !llvm.ptr
    %119 = llvm.getelementptr %118[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<5 x i8>
    %120 = llvm.call @printf(%119, %117) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb15
  ^bb15:  // 2 preds: ^bb13, ^bb14
    llvm.br ^bb10(%110 : i64)
  ^bb16:  // pred: ^bb10
    llvm.return %34 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  }
  llvm.func @_mlir_ciface_run_main_graph(%arg0: !llvm.ptr) attributes {llvm.emit_c_interface} {
    %0 = llvm.call @run_main_graph() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    llvm.store %0, %arg0 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr
    llvm.return
  }
}
