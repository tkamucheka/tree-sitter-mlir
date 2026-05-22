module attributes {llvm.target_triple = "x86_64-unknown-linux-gnu"} {
  llvm.func @free(!llvm.ptr)
  llvm.func @malloc(i64) -> !llvm.ptr
  llvm.func @spar_ciface_storev(i32, !llvm.ptr)
  llvm.func @spar_ciface_storecolv(i32, !llvm.ptr)
  llvm.func @spar_ciface_add(i32, i32, i32)
  llvm.func @spar_ciface_reduce(i32, i32)
  llvm.func @spar_ciface_storem(i32, !llvm.ptr)
  llvm.func @spar_ciface_mul(i32, i32, i32)
  llvm.func @spar_ciface_loadm(i32, !llvm.ptr)
  llvm.func @spar_ciface_loadv_ex(i32, !llvm.ptr, !llvm.ptr)
  llvm.func @spar_ciface_allocate_reg() -> i32
  llvm.func @spar_ciface_init(i32, i32, i32, i1, i1)
  llvm.mlir.global private constant @__constant_4xf32(dense<0.000000e+00> : tensor<4xf32>) {addr_space = 0 : i32, alignment = 64 : i64} : !llvm.array<4 x f32>
  llvm.mlir.global private constant @__constant_1x16xf32(dense<[[1.000000e+00, -2.000000e+00, 5.000000e-01, 3.000000e+00, -1.000000e+00, 2.000000e+00, 2.500000e-01, -7.500000e-01, 1.500000e+00, -5.000000e-01, 2.000000e+00, -1.000000e+00, 5.000000e-01, 1.000000e+00, -2.000000e+00, 4.000000e+00]]> : tensor<1x16xf32>) {addr_space = 0 : i32, alignment = 64 : i64} : !llvm.array<1 x array<16 x f32>>
  llvm.mlir.global private constant @__constant_4x16xf32(dense<[[1.000000e+00, -2.000000e+00, 3.000000e+00, 5.000000e-01, -1.000000e+00, 4.000000e+00, 2.000000e+00, -3.000000e+00, 2.500000e-01, -5.000000e-01, 1.500000e+00, 2.000000e+00, -4.000000e+00, 3.000000e+00, 1.000000e+00, -2.000000e+00], [-1.000000e+00, 0.000000e+00, 2.000000e+00, -3.000000e+00, 5.000000e+00, 1.000000e+00, -2.000000e+00, 5.000000e-01, 1.250000e+00, -1.500000e+00, 0.000000e+00, 1.000000e+00, 2.000000e+00, -7.500000e-01, 4.000000e+00, -1.000000e+00], [5.000000e-01, 1.500000e+00, -2.000000e+00, 1.000000e+00, 3.000000e+00, -1.000000e+00, 2.500000e+00, -5.000000e-01, -1.000000e+00, 2.000000e+00, 5.000000e-01, -3.000000e+00, 1.000000e+00, 2.000000e+00, -1.500000e+00, 4.000000e+00], [2.000000e+00, -1.000000e+00, 5.000000e-01, -5.000000e-01, 1.000000e+00, 2.000000e+00, -3.000000e+00, 4.000000e+00, 7.500000e-01, -2.500000e+00, 1.000000e+00, 0.000000e+00, -1.000000e+00, 3.000000e+00, 2.000000e+00, -4.000000e+00]]> : tensor<4x16xf32>) {addr_space = 0 : i32, alignment = 64 : i64} : !llvm.array<4 x array<16 x f32>>
  llvm.func @run_main_graph() -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> attributes {llvm.emit_c_interface} {
    %0 = llvm.mlir.constant(3735928559 : index) : i64
    %1 = llvm.mlir.constant(64 : index) : i64
    %2 = llvm.mlir.constant(16 : index) : i64
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.mlir.constant(0 : index) : i64
    %7 = llvm.mlir.constant(8 : index) : i64
    %8 = llvm.mlir.constant(1 : index) : i64
    %9 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %10 = llvm.mlir.constant(4 : index) : i64
    %11 = llvm.mlir.constant(32 : ui32) : i32
    %12 = llvm.mlir.constant(8 : ui32) : i32
    %13 = llvm.mlir.constant(false) : i1
    llvm.call @spar_ciface_init(%11, %12, %12, %13, %13) : (i32, i32, i32, i1, i1) -> ()
    %14 = llvm.mlir.addressof @__constant_4x16xf32 : !llvm.ptr
    %15 = llvm.getelementptr %14[0, 0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x array<16 x f32>>
    %16 = llvm.inttoptr %0 : i64 to !llvm.ptr
    %17 = llvm.mlir.addressof @__constant_1x16xf32 : !llvm.ptr
    %18 = llvm.getelementptr %17[0, 0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<1 x array<16 x f32>>
    %19 = llvm.mlir.addressof @__constant_4xf32 : !llvm.ptr
    %20 = llvm.getelementptr %19[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x f32>
    %21 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %22 = llvm.insertvalue %16, %21[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %23 = llvm.insertvalue %20, %22[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %24 = llvm.insertvalue %6, %23[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %25 = llvm.insertvalue %10, %24[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %26 = llvm.insertvalue %8, %25[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %27 = llvm.insertvalue %18, %22[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %28 = llvm.insertvalue %6, %27[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %29 = llvm.insertvalue %7, %28[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %30 = llvm.insertvalue %8, %29[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %31 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %32 = llvm.insertvalue %16, %31[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %33 = llvm.insertvalue %15, %32[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %34 = llvm.insertvalue %6, %33[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %35 = llvm.insertvalue %10, %34[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %36 = llvm.insertvalue %2, %35[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %37 = llvm.insertvalue %7, %36[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %38 = llvm.insertvalue %8, %37[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %39 = llvm.mlir.zero : !llvm.ptr
    %40 = llvm.getelementptr %39[32] : (!llvm.ptr) -> !llvm.ptr, f32
    %41 = llvm.ptrtoint %40 : !llvm.ptr to i64
    %42 = llvm.add %41, %1  : i64
    %43 = llvm.call @malloc(%42) : (i64) -> !llvm.ptr
    %44 = llvm.ptrtoint %43 : !llvm.ptr to i64
    %45 = llvm.sub %1, %8  : i64
    %46 = llvm.add %44, %45  : i64
    %47 = llvm.urem %46, %1  : i64
    %48 = llvm.sub %46, %47  : i64
    %49 = llvm.inttoptr %48 : i64 to !llvm.ptr
    %50 = llvm.insertvalue %43, %31[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %51 = llvm.insertvalue %49, %50[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %52 = llvm.insertvalue %6, %51[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %53 = llvm.insertvalue %10, %52[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %54 = llvm.insertvalue %7, %53[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %55 = llvm.insertvalue %7, %54[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %56 = llvm.insertvalue %8, %55[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.br ^bb1(%6 : i64)
  ^bb1(%57: i64):  // 2 preds: ^bb0, ^bb5
    %58 = llvm.icmp "slt" %57, %10 : i64
    llvm.cond_br %58, ^bb2, ^bb6
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3(%6 : i64)
  ^bb3(%59: i64):  // 2 preds: ^bb2, ^bb4
    %60 = llvm.icmp "slt" %59, %7 : i64
    llvm.cond_br %60, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %61 = llvm.mul %57, %7  : i64
    %62 = llvm.add %61, %59  : i64
    %63 = llvm.getelementptr %49[%62] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %9, %63 : f32, !llvm.ptr
    %64 = llvm.add %59, %8  : i64
    llvm.br ^bb3(%64 : i64)
  ^bb5:  // pred: ^bb3
    %65 = llvm.add %57, %8  : i64
    llvm.br ^bb1(%65 : i64)
  ^bb6:  // pred: ^bb1
    %66 = llvm.call @spar_ciface_allocate_reg() : () -> i32
    %67 = llvm.call @spar_ciface_allocate_reg() : () -> i32
    %68 = llvm.call @spar_ciface_allocate_reg() : () -> i32
    %69 = llvm.alloca %5 x !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store %30, %69 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr
    %70 = llvm.alloca %5 x !llvm.array<4 x i32> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    %71 = llvm.getelementptr %70[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %5, %71 : i32, !llvm.ptr
    %72 = llvm.getelementptr %70[0, 1] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %4, %72 : i32, !llvm.ptr
    %73 = llvm.getelementptr %70[0, 2] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %3, %73 : i32, !llvm.ptr
    %74 = llvm.getelementptr %70[0, 3] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %4, %74 : i32, !llvm.ptr
    llvm.call @spar_ciface_loadv_ex(%66, %69, %70) : (i32, !llvm.ptr, !llvm.ptr) -> ()
    %75 = llvm.alloca %5 x !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store %38, %75 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr
    llvm.call @spar_ciface_loadm(%67, %75) : (i32, !llvm.ptr) -> ()
    llvm.call @spar_ciface_mul(%68, %66, %67) : (i32, i32, i32) -> ()
    %76 = llvm.alloca %5 x !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store %56, %76 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr
    llvm.call @spar_ciface_storem(%68, %76) : (i32, !llvm.ptr) -> ()
    %77 = llvm.getelementptr %39[4] : (!llvm.ptr) -> !llvm.ptr, f32
    %78 = llvm.ptrtoint %77 : !llvm.ptr to i64
    %79 = llvm.add %78, %1  : i64
    %80 = llvm.call @malloc(%79) : (i64) -> !llvm.ptr
    %81 = llvm.ptrtoint %80 : !llvm.ptr to i64
    %82 = llvm.add %81, %45  : i64
    %83 = llvm.urem %82, %1  : i64
    %84 = llvm.sub %82, %83  : i64
    %85 = llvm.inttoptr %84 : i64 to !llvm.ptr
    %86 = llvm.insertvalue %80, %21[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %87 = llvm.insertvalue %85, %86[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %88 = llvm.insertvalue %6, %87[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %89 = llvm.insertvalue %10, %88[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %90 = llvm.insertvalue %8, %89[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.br ^bb7(%6 : i64)
  ^bb7(%91: i64):  // 2 preds: ^bb6, ^bb8
    %92 = llvm.icmp "slt" %91, %10 : i64
    llvm.cond_br %92, ^bb8, ^bb9
  ^bb8:  // pred: ^bb7
    %93 = llvm.getelementptr %85[%91] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %9, %93 : f32, !llvm.ptr
    %94 = llvm.add %91, %8  : i64
    llvm.br ^bb7(%94 : i64)
  ^bb9:  // pred: ^bb7
    %95 = llvm.mul %10, %8  : i64
    %96 = llvm.getelementptr %39[1] : (!llvm.ptr) -> !llvm.ptr, f32
    %97 = llvm.ptrtoint %96 : !llvm.ptr to i64
    %98 = llvm.mul %95, %97  : i64
    "llvm.intr.memcpy"(%85, %20, %98) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %99 = llvm.call @spar_ciface_allocate_reg() : () -> i32
    %100 = llvm.call @spar_ciface_allocate_reg() : () -> i32
    %101 = llvm.alloca %5 x !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store %56, %101 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr
    llvm.call @spar_ciface_loadm(%99, %101) : (i32, !llvm.ptr) -> ()
    llvm.call @spar_ciface_reduce(%100, %99) : (i32, i32) -> ()
    %102 = llvm.call @spar_ciface_allocate_reg() : () -> i32
    %103 = llvm.call @spar_ciface_allocate_reg() : () -> i32
    %104 = llvm.alloca %5 x !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store %90, %104 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr
    %105 = llvm.alloca %5 x !llvm.array<4 x i32> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    %106 = llvm.getelementptr %105[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %4, %106 : i32, !llvm.ptr
    %107 = llvm.getelementptr %105[0, 1] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %5, %107 : i32, !llvm.ptr
    %108 = llvm.getelementptr %105[0, 2] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %4, %108 : i32, !llvm.ptr
    %109 = llvm.getelementptr %105[0, 3] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %4, %109 : i32, !llvm.ptr
    llvm.call @spar_ciface_loadv_ex(%102, %104, %105) : (i32, !llvm.ptr, !llvm.ptr) -> ()
    llvm.call @spar_ciface_add(%103, %100, %102) : (i32, i32, i32) -> ()
    %110 = llvm.alloca %5 x !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store %90, %110 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr
    llvm.call @spar_ciface_storecolv(%103, %110) : (i32, !llvm.ptr) -> ()
    %111 = llvm.call @malloc(%79) : (i64) -> !llvm.ptr
    %112 = llvm.ptrtoint %111 : !llvm.ptr to i64
    %113 = llvm.add %112, %45  : i64
    %114 = llvm.urem %113, %1  : i64
    %115 = llvm.sub %113, %114  : i64
    %116 = llvm.inttoptr %115 : i64 to !llvm.ptr
    %117 = llvm.insertvalue %111, %21[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %118 = llvm.insertvalue %116, %117[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %119 = llvm.insertvalue %6, %118[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %120 = llvm.insertvalue %10, %119[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %121 = llvm.insertvalue %8, %120[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.br ^bb10(%6 : i64)
  ^bb10(%122: i64):  // 2 preds: ^bb9, ^bb11
    %123 = llvm.icmp "slt" %122, %10 : i64
    llvm.cond_br %123, ^bb11, ^bb12
  ^bb11:  // pred: ^bb10
    %124 = llvm.getelementptr %116[%122] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %9, %124 : f32, !llvm.ptr
    %125 = llvm.add %122, %8  : i64
    llvm.br ^bb10(%125 : i64)
  ^bb12:  // pred: ^bb10
    %126 = llvm.call @malloc(%79) : (i64) -> !llvm.ptr
    %127 = llvm.ptrtoint %126 : !llvm.ptr to i64
    %128 = llvm.add %127, %45  : i64
    %129 = llvm.urem %128, %1  : i64
    %130 = llvm.sub %128, %129  : i64
    %131 = llvm.inttoptr %130 : i64 to !llvm.ptr
    %132 = llvm.insertvalue %126, %21[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %133 = llvm.insertvalue %131, %132[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %134 = llvm.insertvalue %6, %133[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %135 = llvm.insertvalue %10, %134[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %136 = llvm.insertvalue %8, %135[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.br ^bb13(%6 : i64)
  ^bb13(%137: i64):  // 2 preds: ^bb12, ^bb14
    %138 = llvm.icmp "slt" %137, %10 : i64
    llvm.cond_br %138, ^bb14, ^bb15
  ^bb14:  // pred: ^bb13
    %139 = llvm.getelementptr %131[%137] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %9, %139 : f32, !llvm.ptr
    %140 = llvm.add %137, %8  : i64
    llvm.br ^bb13(%140 : i64)
  ^bb15:  // pred: ^bb13
    %141 = llvm.call @spar_ciface_allocate_reg() : () -> i32
    %142 = llvm.call @spar_ciface_allocate_reg() : () -> i32
    %143 = llvm.call @spar_ciface_allocate_reg() : () -> i32
    %144 = llvm.alloca %5 x !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store %90, %144 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr
    %145 = llvm.alloca %5 x !llvm.array<4 x i32> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    %146 = llvm.getelementptr %145[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %4, %146 : i32, !llvm.ptr
    %147 = llvm.getelementptr %145[0, 1] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %4, %147 : i32, !llvm.ptr
    %148 = llvm.getelementptr %145[0, 2] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %4, %148 : i32, !llvm.ptr
    %149 = llvm.getelementptr %145[0, 3] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %4, %149 : i32, !llvm.ptr
    llvm.call @spar_ciface_loadv_ex(%141, %144, %145) : (i32, !llvm.ptr, !llvm.ptr) -> ()
    %150 = llvm.alloca %5 x !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store %26, %150 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr
    %151 = llvm.alloca %5 x !llvm.array<4 x i32> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    %152 = llvm.getelementptr %151[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %4, %152 : i32, !llvm.ptr
    %153 = llvm.getelementptr %151[0, 1] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %4, %153 : i32, !llvm.ptr
    %154 = llvm.getelementptr %151[0, 2] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %4, %154 : i32, !llvm.ptr
    %155 = llvm.getelementptr %151[0, 3] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %4, %155 : i32, !llvm.ptr
    llvm.call @spar_ciface_loadv_ex(%142, %150, %151) : (i32, !llvm.ptr, !llvm.ptr) -> ()
    llvm.call @spar_ciface_add(%143, %141, %142) : (i32, i32, i32) -> ()
    %156 = llvm.alloca %5 x !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store %136, %156 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr
    llvm.call @spar_ciface_storev(%143, %156) : (i32, !llvm.ptr) -> ()
    %157 = llvm.insertvalue %7, %27[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %158 = llvm.insertvalue %7, %157[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %159 = llvm.insertvalue %8, %158[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %160 = llvm.insertvalue %7, %33[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %161 = llvm.insertvalue %10, %160[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %162 = llvm.insertvalue %2, %161[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %163 = llvm.insertvalue %7, %162[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %164 = llvm.insertvalue %8, %163[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %165 = llvm.call @spar_ciface_allocate_reg() : () -> i32
    %166 = llvm.call @spar_ciface_allocate_reg() : () -> i32
    %167 = llvm.call @spar_ciface_allocate_reg() : () -> i32
    %168 = llvm.alloca %5 x !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store %159, %168 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr
    %169 = llvm.alloca %5 x !llvm.array<4 x i32> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    %170 = llvm.getelementptr %169[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %5, %170 : i32, !llvm.ptr
    %171 = llvm.getelementptr %169[0, 1] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %4, %171 : i32, !llvm.ptr
    %172 = llvm.getelementptr %169[0, 2] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %3, %172 : i32, !llvm.ptr
    %173 = llvm.getelementptr %169[0, 3] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %4, %173 : i32, !llvm.ptr
    llvm.call @spar_ciface_loadv_ex(%165, %168, %169) : (i32, !llvm.ptr, !llvm.ptr) -> ()
    %174 = llvm.alloca %5 x !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store %164, %174 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr
    llvm.call @spar_ciface_loadm(%166, %174) : (i32, !llvm.ptr) -> ()
    llvm.call @spar_ciface_mul(%167, %165, %166) : (i32, i32, i32) -> ()
    %175 = llvm.alloca %5 x !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store %56, %175 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr
    llvm.call @spar_ciface_storem(%167, %175) : (i32, !llvm.ptr) -> ()
    %176 = llvm.call @malloc(%79) : (i64) -> !llvm.ptr
    %177 = llvm.ptrtoint %176 : !llvm.ptr to i64
    %178 = llvm.add %177, %45  : i64
    %179 = llvm.urem %178, %1  : i64
    %180 = llvm.sub %178, %179  : i64
    %181 = llvm.inttoptr %180 : i64 to !llvm.ptr
    %182 = llvm.insertvalue %176, %21[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %183 = llvm.insertvalue %181, %182[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %184 = llvm.insertvalue %6, %183[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %185 = llvm.insertvalue %10, %184[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %186 = llvm.insertvalue %8, %185[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.br ^bb16(%6 : i64)
  ^bb16(%187: i64):  // 2 preds: ^bb15, ^bb17
    %188 = llvm.icmp "slt" %187, %10 : i64
    llvm.cond_br %188, ^bb17, ^bb18
  ^bb17:  // pred: ^bb16
    %189 = llvm.getelementptr %181[%187] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %9, %189 : f32, !llvm.ptr
    %190 = llvm.add %187, %8  : i64
    llvm.br ^bb16(%190 : i64)
  ^bb18:  // pred: ^bb16
    "llvm.intr.memcpy"(%181, %20, %98) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %191 = llvm.call @spar_ciface_allocate_reg() : () -> i32
    %192 = llvm.call @spar_ciface_allocate_reg() : () -> i32
    %193 = llvm.alloca %5 x !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store %56, %193 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr
    llvm.call @spar_ciface_loadm(%191, %193) : (i32, !llvm.ptr) -> ()
    llvm.call @spar_ciface_reduce(%192, %191) : (i32, i32) -> ()
    %194 = llvm.call @spar_ciface_allocate_reg() : () -> i32
    %195 = llvm.call @spar_ciface_allocate_reg() : () -> i32
    %196 = llvm.alloca %5 x !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store %186, %196 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr
    %197 = llvm.alloca %5 x !llvm.array<4 x i32> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    %198 = llvm.getelementptr %197[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %4, %198 : i32, !llvm.ptr
    %199 = llvm.getelementptr %197[0, 1] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %5, %199 : i32, !llvm.ptr
    %200 = llvm.getelementptr %197[0, 2] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %4, %200 : i32, !llvm.ptr
    %201 = llvm.getelementptr %197[0, 3] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %4, %201 : i32, !llvm.ptr
    llvm.call @spar_ciface_loadv_ex(%194, %196, %197) : (i32, !llvm.ptr, !llvm.ptr) -> ()
    llvm.call @spar_ciface_add(%195, %192, %194) : (i32, i32, i32) -> ()
    %202 = llvm.alloca %5 x !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store %186, %202 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr
    llvm.call @spar_ciface_storecolv(%195, %202) : (i32, !llvm.ptr) -> ()
    %203 = llvm.call @spar_ciface_allocate_reg() : () -> i32
    %204 = llvm.call @spar_ciface_allocate_reg() : () -> i32
    %205 = llvm.call @spar_ciface_allocate_reg() : () -> i32
    %206 = llvm.alloca %5 x !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store %186, %206 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr
    %207 = llvm.alloca %5 x !llvm.array<4 x i32> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    %208 = llvm.getelementptr %207[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %4, %208 : i32, !llvm.ptr
    %209 = llvm.getelementptr %207[0, 1] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %4, %209 : i32, !llvm.ptr
    %210 = llvm.getelementptr %207[0, 2] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %4, %210 : i32, !llvm.ptr
    %211 = llvm.getelementptr %207[0, 3] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %4, %211 : i32, !llvm.ptr
    llvm.call @spar_ciface_loadv_ex(%203, %206, %207) : (i32, !llvm.ptr, !llvm.ptr) -> ()
    %212 = llvm.alloca %5 x !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store %136, %212 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr
    %213 = llvm.alloca %5 x !llvm.array<4 x i32> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    %214 = llvm.getelementptr %213[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %4, %214 : i32, !llvm.ptr
    %215 = llvm.getelementptr %213[0, 1] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %4, %215 : i32, !llvm.ptr
    %216 = llvm.getelementptr %213[0, 2] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %4, %216 : i32, !llvm.ptr
    %217 = llvm.getelementptr %213[0, 3] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.store %4, %217 : i32, !llvm.ptr
    llvm.call @spar_ciface_loadv_ex(%204, %212, %213) : (i32, !llvm.ptr, !llvm.ptr) -> ()
    llvm.call @spar_ciface_add(%205, %203, %204) : (i32, i32, i32) -> ()
    %218 = llvm.alloca %5 x !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store %121, %218 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr
    llvm.call @spar_ciface_storev(%205, %218) : (i32, !llvm.ptr) -> ()
    llvm.call @free(%43) : (!llvm.ptr) -> ()
    llvm.call @free(%80) : (!llvm.ptr) -> ()
    llvm.call @free(%126) : (!llvm.ptr) -> ()
    llvm.call @free(%176) : (!llvm.ptr) -> ()
    llvm.return %121 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  }
  llvm.func @_mlir_ciface_run_main_graph(%arg0: !llvm.ptr) attributes {llvm.emit_c_interface} {
    %0 = llvm.call @run_main_graph() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    llvm.store %0, %arg0 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr
    llvm.return
  }
}
