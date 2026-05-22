module attributes {llvm.target_triple = "x86_64-unknown-linux-gnu"} {
  llvm.func @free(!llvm.ptr)
  llvm.func @malloc(i64) -> !llvm.ptr
  llvm.mlir.global internal constant @__sparll_fmt_1734185305656997107("%f]\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @__sparll_fmt_12346954863685052989("[\00") {addr_space = 0 : i32}
  llvm.func @spar_ciface_storecolv(i32, !llvm.ptr)
  llvm.func @spar_ciface_add(i32, i32, i32)
  llvm.func @spar_ciface_reduce(i32, i32)
  llvm.mlir.global internal constant @__sparll_fmt_6877663594892849040("]\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @__sparll_fmt_13007494805068090019("\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @__sparll_fmt_13760337646998457475(",\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @__sparll_fmt_12851831707923366372("%f]\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @__sparll_fmt_10000560481934975737("%f, \00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @__sparll_fmt_3935923456386810301("  [\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @__sparll_fmt_10004117980908537893("[\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @__sparll_fmt_10178449352943158142("%s\00") {addr_space = 0 : i32}
  llvm.func @printf(!llvm.ptr, ...) -> i32
  llvm.func @spar_ciface_storem(i32, !llvm.ptr)
  llvm.func @spar_ciface_mul(i32, i32, i32)
  llvm.func @spar_ciface_loadm(i32, !llvm.ptr)
  llvm.func @spar_ciface_loadv_ex(i32, !llvm.ptr, !llvm.ptr)
  llvm.func @spar_ciface_allocate_reg() -> i32
  llvm.func @spar_ciface_init(i32, i32, i32, i1, i1)
  llvm.mlir.global private constant @__constant_4xf32_0(dense<1.000000e+00> : tensor<4xf32>) {addr_space = 0 : i32, alignment = 64 : i64} : !llvm.array<4 x f32>
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
    %24 = llvm.mlir.addressof @__constant_4xf32_0 : !llvm.ptr
    %25 = llvm.getelementptr %24[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x f32>
    %26 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %27 = llvm.insertvalue %15, %26[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %28 = llvm.insertvalue %25, %27[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %29 = llvm.insertvalue %4, %28[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %30 = llvm.insertvalue %6, %29[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %31 = llvm.insertvalue %5, %30[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %32 = llvm.mlir.zero : !llvm.ptr
    %33 = llvm.getelementptr %32[16] : (!llvm.ptr) -> !llvm.ptr, f32
    %34 = llvm.ptrtoint %33 : !llvm.ptr to i64
    %35 = llvm.add %34, %0  : i64
    %36 = llvm.call @malloc(%35) : (i64) -> !llvm.ptr
    %37 = llvm.ptrtoint %36 : !llvm.ptr to i64
    %38 = llvm.sub %0, %5  : i64
    %39 = llvm.add %37, %38  : i64
    %40 = llvm.urem %39, %0  : i64
    %41 = llvm.sub %39, %40  : i64
    %42 = llvm.inttoptr %41 : i64 to !llvm.ptr
    %43 = llvm.insertvalue %36, %16[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %44 = llvm.insertvalue %42, %43[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %45 = llvm.insertvalue %4, %44[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %46 = llvm.insertvalue %6, %45[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %47 = llvm.insertvalue %6, %46[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %48 = llvm.insertvalue %6, %47[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %49 = llvm.insertvalue %5, %48[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.br ^bb1(%4 : i64)
  ^bb1(%50: i64):  // 2 preds: ^bb0, ^bb5
    %51 = llvm.icmp "slt" %50, %6 : i64
    llvm.cond_br %51, ^bb2, ^bb6
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3(%4 : i64)
  ^bb3(%52: i64):  // 2 preds: ^bb2, ^bb4
    %53 = llvm.icmp "slt" %52, %6 : i64
    llvm.cond_br %53, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %54 = llvm.mul %50, %6  : i64
    %55 = llvm.add %54, %52  : i64
    %56 = llvm.getelementptr %42[%55] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %7, %56 : f32, !llvm.ptr
    %57 = llvm.add %52, %5  : i64
    llvm.br ^bb3(%57 : i64)
  ^bb5:  // pred: ^bb3
    %58 = llvm.add %50, %5  : i64
    llvm.br ^bb1(%58 : i64)
  ^bb6:  // pred: ^bb1
    %59 = llvm.call @spar_ciface_allocate_reg() : () -> i32
    %60 = llvm.call @spar_ciface_allocate_reg() : () -> i32
    %61 = llvm.call @spar_ciface_allocate_reg() : () -> i32
    %62 = llvm.alloca %3 x !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store %31, %62 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr
    %63 = llvm.alloca %3 x !llvm.array<4 x i32> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    %64 = llvm.getelementptr %63[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %2, %64 : i32, !llvm.ptr
    %65 = llvm.getelementptr %63[0, 1] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %2, %65 : i32, !llvm.ptr
    %66 = llvm.getelementptr %63[0, 2] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %2, %66 : i32, !llvm.ptr
    %67 = llvm.getelementptr %63[0, 3] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %2, %67 : i32, !llvm.ptr
    llvm.call @spar_ciface_loadv_ex(%59, %62, %63) : (i32, !llvm.ptr, !llvm.ptr) -> ()
    %68 = llvm.alloca %3 x !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store %23, %68 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr
    llvm.call @spar_ciface_loadm(%60, %68) : (i32, !llvm.ptr) -> ()
    llvm.call @spar_ciface_mul(%61, %59, %60) : (i32, i32, i32) -> ()
    %69 = llvm.alloca %3 x !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store %49, %69 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr
    llvm.call @spar_ciface_storem(%61, %69) : (i32, !llvm.ptr) -> ()
    %70 = llvm.mlir.addressof @__sparll_fmt_10178449352943158142 : !llvm.ptr
    %71 = llvm.getelementptr %70[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<3 x i8>
    %72 = llvm.mlir.addressof @__sparll_fmt_10004117980908537893 : !llvm.ptr
    %73 = llvm.getelementptr %72[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<3 x i8>
    %74 = llvm.call @printf(%71, %73) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.br ^bb7(%4 : i64)
  ^bb7(%75: i64):  // 2 preds: ^bb6, ^bb19
    %76 = llvm.icmp "slt" %75, %6 : i64
    llvm.cond_br %76, ^bb8, ^bb20
  ^bb8:  // pred: ^bb7
    %77 = llvm.mlir.addressof @__sparll_fmt_3935923456386810301 : !llvm.ptr
    %78 = llvm.getelementptr %77[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i8>
    %79 = llvm.call @printf(%71, %78) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.br ^bb9(%4 : i64)
  ^bb9(%80: i64):  // 2 preds: ^bb8, ^bb14
    %81 = llvm.icmp "slt" %80, %6 : i64
    llvm.cond_br %81, ^bb10, ^bb15
  ^bb10:  // pred: ^bb9
    %82 = llvm.mul %75, %6  : i64
    %83 = llvm.add %82, %80  : i64
    %84 = llvm.getelementptr %42[%83] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %85 = llvm.load %84 : !llvm.ptr -> f32
    %86 = llvm.add %80, %5  : i64
    %87 = llvm.icmp "ult" %86, %6 : i64
    llvm.cond_br %87, ^bb11, ^bb12
  ^bb11:  // pred: ^bb10
    %88 = llvm.fpext %85 : f32 to f64
    %89 = llvm.mlir.addressof @__sparll_fmt_10000560481934975737 : !llvm.ptr
    %90 = llvm.getelementptr %89[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<5 x i8>
    %91 = llvm.call @printf(%90, %88) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb12
  ^bb12:  // 2 preds: ^bb10, ^bb11
    %92 = llvm.icmp "uge" %86, %6 : i64
    llvm.cond_br %92, ^bb13, ^bb14
  ^bb13:  // pred: ^bb12
    %93 = llvm.fpext %85 : f32 to f64
    %94 = llvm.mlir.addressof @__sparll_fmt_12851831707923366372 : !llvm.ptr
    %95 = llvm.getelementptr %94[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i8>
    %96 = llvm.call @printf(%95, %93) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb14
  ^bb14:  // 2 preds: ^bb12, ^bb13
    llvm.br ^bb9(%86 : i64)
  ^bb15:  // pred: ^bb9
    %97 = llvm.add %75, %5  : i64
    %98 = llvm.icmp "ult" %97, %6 : i64
    llvm.cond_br %98, ^bb16, ^bb17
  ^bb16:  // pred: ^bb15
    %99 = llvm.mlir.addressof @__sparll_fmt_13760337646998457475 : !llvm.ptr
    %100 = llvm.getelementptr %99[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<3 x i8>
    %101 = llvm.call @printf(%71, %100) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.br ^bb17
  ^bb17:  // 2 preds: ^bb15, ^bb16
    %102 = llvm.icmp "uge" %97, %6 : i64
    llvm.cond_br %102, ^bb18, ^bb19
  ^bb18:  // pred: ^bb17
    %103 = llvm.mlir.addressof @__sparll_fmt_13007494805068090019 : !llvm.ptr
    %104 = llvm.getelementptr %103[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<2 x i8>
    %105 = llvm.call @printf(%71, %104) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.br ^bb19
  ^bb19:  // 2 preds: ^bb17, ^bb18
    llvm.br ^bb7(%97 : i64)
  ^bb20:  // pred: ^bb7
    %106 = llvm.mlir.addressof @__sparll_fmt_6877663594892849040 : !llvm.ptr
    %107 = llvm.getelementptr %106[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<3 x i8>
    %108 = llvm.call @printf(%71, %107) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    %109 = llvm.getelementptr %32[4] : (!llvm.ptr) -> !llvm.ptr, f32
    %110 = llvm.ptrtoint %109 : !llvm.ptr to i64
    %111 = llvm.add %110, %0  : i64
    %112 = llvm.call @malloc(%111) : (i64) -> !llvm.ptr
    %113 = llvm.ptrtoint %112 : !llvm.ptr to i64
    %114 = llvm.add %113, %38  : i64
    %115 = llvm.urem %114, %0  : i64
    %116 = llvm.sub %114, %115  : i64
    %117 = llvm.inttoptr %116 : i64 to !llvm.ptr
    %118 = llvm.insertvalue %112, %26[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %119 = llvm.insertvalue %117, %118[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %120 = llvm.insertvalue %4, %119[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %121 = llvm.insertvalue %6, %120[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %122 = llvm.insertvalue %5, %121[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.br ^bb21(%4 : i64)
  ^bb21(%123: i64):  // 2 preds: ^bb20, ^bb22
    %124 = llvm.icmp "slt" %123, %6 : i64
    llvm.cond_br %124, ^bb22, ^bb23
  ^bb22:  // pred: ^bb21
    %125 = llvm.getelementptr %117[%123] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %7, %125 : f32, !llvm.ptr
    %126 = llvm.add %123, %5  : i64
    llvm.br ^bb21(%126 : i64)
  ^bb23:  // pred: ^bb21
    %127 = llvm.mul %6, %5  : i64
    %128 = llvm.getelementptr %32[1] : (!llvm.ptr) -> !llvm.ptr, f32
    %129 = llvm.ptrtoint %128 : !llvm.ptr to i64
    %130 = llvm.mul %127, %129  : i64
    "llvm.intr.memcpy"(%117, %12, %130) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %131 = llvm.call @spar_ciface_allocate_reg() : () -> i32
    %132 = llvm.call @spar_ciface_allocate_reg() : () -> i32
    %133 = llvm.alloca %3 x !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store %49, %133 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr
    llvm.call @spar_ciface_loadm(%131, %133) : (i32, !llvm.ptr) -> ()
    llvm.call @spar_ciface_reduce(%132, %131) : (i32, i32) -> ()
    %134 = llvm.call @spar_ciface_allocate_reg() : () -> i32
    %135 = llvm.call @spar_ciface_allocate_reg() : () -> i32
    %136 = llvm.alloca %3 x !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store %122, %136 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr
    %137 = llvm.alloca %3 x !llvm.array<4 x i32> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    %138 = llvm.getelementptr %137[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %2, %138 : i32, !llvm.ptr
    %139 = llvm.getelementptr %137[0, 1] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %3, %139 : i32, !llvm.ptr
    %140 = llvm.getelementptr %137[0, 2] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %2, %140 : i32, !llvm.ptr
    %141 = llvm.getelementptr %137[0, 3] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %2, %141 : i32, !llvm.ptr
    llvm.call @spar_ciface_loadv_ex(%134, %136, %137) : (i32, !llvm.ptr, !llvm.ptr) -> ()
    llvm.call @spar_ciface_add(%135, %132, %134) : (i32, i32, i32) -> ()
    %142 = llvm.alloca %3 x !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store %122, %142 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr
    llvm.call @spar_ciface_storecolv(%135, %142) : (i32, !llvm.ptr) -> ()
    %143 = llvm.mlir.addressof @__sparll_fmt_12346954863685052989 : !llvm.ptr
    %144 = llvm.getelementptr %143[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<2 x i8>
    %145 = llvm.call @printf(%71, %144) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.br ^bb24(%4 : i64)
  ^bb24(%146: i64):  // 2 preds: ^bb23, ^bb29
    %147 = llvm.icmp "slt" %146, %6 : i64
    llvm.cond_br %147, ^bb25, ^bb30
  ^bb25:  // pred: ^bb24
    %148 = llvm.getelementptr %117[%146] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %149 = llvm.load %148 : !llvm.ptr -> f32
    %150 = llvm.add %146, %5  : i64
    %151 = llvm.icmp "ult" %150, %6 : i64
    llvm.cond_br %151, ^bb26, ^bb27
  ^bb26:  // pred: ^bb25
    %152 = llvm.fpext %149 : f32 to f64
    %153 = llvm.mlir.addressof @__sparll_fmt_10000560481934975737 : !llvm.ptr
    %154 = llvm.getelementptr %153[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<5 x i8>
    %155 = llvm.call @printf(%154, %152) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb27
  ^bb27:  // 2 preds: ^bb25, ^bb26
    %156 = llvm.icmp "uge" %150, %6 : i64
    llvm.cond_br %156, ^bb28, ^bb29
  ^bb28:  // pred: ^bb27
    %157 = llvm.fpext %149 : f32 to f64
    %158 = llvm.mlir.addressof @__sparll_fmt_1734185305656997107 : !llvm.ptr
    %159 = llvm.getelementptr %158[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<5 x i8>
    %160 = llvm.call @printf(%159, %157) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb29
  ^bb29:  // 2 preds: ^bb27, ^bb28
    llvm.br ^bb24(%150 : i64)
  ^bb30:  // pred: ^bb24
    llvm.call @free(%36) : (!llvm.ptr) -> ()
    llvm.return %122 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  }
  llvm.func @_mlir_ciface_run_main_graph(%arg0: !llvm.ptr) attributes {llvm.emit_c_interface} {
    %0 = llvm.call @run_main_graph() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    llvm.store %0, %arg0 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr
    llvm.return
  }
}
