module {
  memref.global "private" constant @__constant_4xf32 : memref<4xf32> = dense<0.000000e+00> {alignment = 64 : i64}
  memref.global "private" constant @__constant_1x16xf32 : memref<1x16xf32> = dense<[[1.000000e+00, -2.000000e+00, 5.000000e-01, 3.000000e+00, -1.000000e+00, 2.000000e+00, 2.500000e-01, -7.500000e-01, 1.500000e+00, -5.000000e-01, 2.000000e+00, -1.000000e+00, 5.000000e-01, 1.000000e+00, -2.000000e+00, 4.000000e+00]]> {alignment = 64 : i64}
  memref.global "private" constant @__constant_4x16xf32 : memref<4x16xf32> = dense<[[1.000000e+00, -2.000000e+00, 3.000000e+00, 5.000000e-01, -1.000000e+00, 4.000000e+00, 2.000000e+00, -3.000000e+00, 2.500000e-01, -5.000000e-01, 1.500000e+00, 2.000000e+00, -4.000000e+00, 3.000000e+00, 1.000000e+00, -2.000000e+00], [-1.000000e+00, 0.000000e+00, 2.000000e+00, -3.000000e+00, 5.000000e+00, 1.000000e+00, -2.000000e+00, 5.000000e-01, 1.250000e+00, -1.500000e+00, 0.000000e+00, 1.000000e+00, 2.000000e+00, -7.500000e-01, 4.000000e+00, -1.000000e+00], [5.000000e-01, 1.500000e+00, -2.000000e+00, 1.000000e+00, 3.000000e+00, -1.000000e+00, 2.500000e+00, -5.000000e-01, -1.000000e+00, 2.000000e+00, 5.000000e-01, -3.000000e+00, 1.000000e+00, 2.000000e+00, -1.500000e+00, 4.000000e+00], [2.000000e+00, -1.000000e+00, 5.000000e-01, -5.000000e-01, 1.000000e+00, 2.000000e+00, -3.000000e+00, 4.000000e+00, 7.500000e-01, -2.500000e+00, 1.000000e+00, 0.000000e+00, -1.000000e+00, 3.000000e+00, 2.000000e+00, -4.000000e+00]]> {alignment = 64 : i64}
  func.func @run_main_graph() -> memref<4xf32> attributes {llvm.emit_c_interface} {
    %c4 = arith.constant 4 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c1 = arith.constant 1 : index
    %c8 = arith.constant 8 : index
    %c0 = arith.constant 0 : index
    %0 = memref.get_global @__constant_4x16xf32 : memref<4x16xf32>
    %1 = memref.get_global @__constant_1x16xf32 : memref<1x16xf32>
    %2 = memref.get_global @__constant_4xf32 : memref<4xf32>
    %subview = memref.subview %1[0, 0] [1, 8] [1, 1] : memref<1x16xf32> to memref<1x8xf32, strided<[16, 1]>>
    %base_buffer, %offset, %sizes:2, %strides:2 = memref.extract_strided_metadata %subview : memref<1x8xf32, strided<[16, 1]>> -> memref<f32>, index, index, index, index, index
    %reinterpret_cast = memref.reinterpret_cast %base_buffer to offset: [%c0], sizes: [%c8], strides: [%c1] : memref<f32> to memref<8xf32, strided<[?], offset: ?>>
    %subview_0 = memref.subview %0[0, 0] [4, 8] [1, 1] : memref<4x16xf32> to memref<4x8xf32, strided<[16, 1]>>
    %alloc = memref.alloc() {alignment = 64 : i64, spar.zero_init_inserted} : memref<4x8xf32>
    scf.for %arg0 = %c0 to %c4 step %c1 {
      scf.for %arg1 = %c0 to %c8 step %c1 {
        memref.store %cst, %alloc[%arg0, %arg1] : memref<4x8xf32>
      }
    }
    %3 = spar_ll.allocate_reg() : !spar_ll.reg<8xf32>
    %4 = spar_ll.allocate_reg() : !spar_ll.reg<4x8xf32>
    %5 = spar_ll.allocate_reg() : !spar_ll.reg<4x8xf32>
    %6 = spar_ll.loadv(%reinterpret_cast, %3) {anchor = 0 : i32, broadcast = 4 : i32, offset = 0 : i32, orientation = 1 : i32} : (memref<8xf32, strided<[?], offset: ?>>) into !spar_ll.reg<8xf32>
    %7 = spar_ll.loadm(%subview_0, %4) : (memref<4x8xf32, strided<[16, 1]>>) into !spar_ll.reg<4x8xf32>
    %8 = spar_ll.mul(%5, %6, %7) : (!spar_ll.reg<8xf32>, !spar_ll.reg<4x8xf32>) -> !spar_ll.reg<4x8xf32>
    %9 = spar_ll.storem(%8, %alloc) : (!spar_ll.reg<4x8xf32>) into memref<4x8xf32>
    %alloc_1 = memref.alloc() {alignment = 64 : i64, spar.zero_init_inserted} : memref<4xf32>
    scf.for %arg0 = %c0 to %c4 step %c1 {
      memref.store %cst, %alloc_1[%arg0] : memref<4xf32>
    }
    memref.copy %2, %alloc_1 : memref<4xf32> to memref<4xf32>
    %10 = spar_ll.allocate_reg() : !spar_ll.reg<4x8xf32>
    %11 = spar_ll.allocate_reg() : !spar_ll.reg<4xf32>
    %12 = spar_ll.loadm(%alloc, %10) : (memref<4x8xf32>) into !spar_ll.reg<4x8xf32>
    %13 = spar_ll.reduce(%11, %12) : (!spar_ll.reg<4x8xf32>) -> !spar_ll.reg<4xf32>
    %14 = spar_ll.allocate_reg() : !spar_ll.reg<4xf32>
    %15 = spar_ll.allocate_reg() : !spar_ll.reg<4xf32>
    %16 = spar_ll.loadv(%alloc_1, %14) {anchor = 1 : i32, broadcast = 0 : i32, offset = 0 : i32, orientation = 0 : i32} : (memref<4xf32>) into !spar_ll.reg<4xf32>
    %17 = spar_ll.add(%15, %13, %16) : (!spar_ll.reg<4xf32>, !spar_ll.reg<4xf32>) -> !spar_ll.reg<4xf32>
    %18 = spar_ll.storecolv(%17, %alloc_1) : (!spar_ll.reg<4xf32>) into memref<4xf32>
    %alloc_2 = memref.alloc() {alignment = 64 : i64, spar.zero_init_inserted} : memref<4xf32>
    scf.for %arg0 = %c0 to %c4 step %c1 {
      memref.store %cst, %alloc_2[%arg0] : memref<4xf32>
    }
    %alloc_3 = memref.alloc() {alignment = 64 : i64, spar.zero_init_inserted} : memref<4xf32>
    scf.for %arg0 = %c0 to %c4 step %c1 {
      memref.store %cst, %alloc_3[%arg0] : memref<4xf32>
    }
    %19 = spar_ll.allocate_reg() : !spar_ll.reg<4xf32>
    %20 = spar_ll.allocate_reg() : !spar_ll.reg<4xf32>
    %21 = spar_ll.allocate_reg() : !spar_ll.reg<4xf32>
    %22 = spar_ll.loadv(%alloc_1, %19) : (memref<4xf32>) into !spar_ll.reg<4xf32>
    %23 = spar_ll.loadv(%2, %20) : (memref<4xf32>) into !spar_ll.reg<4xf32>
    %24 = spar_ll.add(%21, %22, %23) : (!spar_ll.reg<4xf32>, !spar_ll.reg<4xf32>) -> !spar_ll.reg<4xf32>
    %25 = spar_ll.storev(%24, %alloc_3) : (!spar_ll.reg<4xf32>) into memref<4xf32>
    %subview_4 = memref.subview %1[0, 8] [1, 8] [1, 1] : memref<1x16xf32> to memref<1x8xf32, strided<[16, 1], offset: 8>>
    %base_buffer_5, %offset_6, %sizes_7:2, %strides_8:2 = memref.extract_strided_metadata %subview_4 : memref<1x8xf32, strided<[16, 1], offset: 8>> -> memref<f32>, index, index, index, index, index
    %reinterpret_cast_9 = memref.reinterpret_cast %base_buffer_5 to offset: [%c8], sizes: [%c8], strides: [%c1] : memref<f32> to memref<8xf32, strided<[?], offset: ?>>
    %subview_10 = memref.subview %0[0, 8] [4, 8] [1, 1] : memref<4x16xf32> to memref<4x8xf32, strided<[16, 1], offset: 8>>
    %26 = spar_ll.allocate_reg() : !spar_ll.reg<8xf32>
    %27 = spar_ll.allocate_reg() : !spar_ll.reg<4x8xf32>
    %28 = spar_ll.allocate_reg() : !spar_ll.reg<4x8xf32>
    %29 = spar_ll.loadv(%reinterpret_cast_9, %26) {anchor = 0 : i32, broadcast = 4 : i32, offset = 0 : i32, orientation = 1 : i32} : (memref<8xf32, strided<[?], offset: ?>>) into !spar_ll.reg<8xf32>
    %30 = spar_ll.loadm(%subview_10, %27) : (memref<4x8xf32, strided<[16, 1], offset: 8>>) into !spar_ll.reg<4x8xf32>
    %31 = spar_ll.mul(%28, %29, %30) : (!spar_ll.reg<8xf32>, !spar_ll.reg<4x8xf32>) -> !spar_ll.reg<4x8xf32>
    %32 = spar_ll.storem(%31, %alloc) : (!spar_ll.reg<4x8xf32>) into memref<4x8xf32>
    %alloc_11 = memref.alloc() {alignment = 64 : i64, spar.zero_init_inserted} : memref<4xf32>
    scf.for %arg0 = %c0 to %c4 step %c1 {
      memref.store %cst, %alloc_11[%arg0] : memref<4xf32>
    }
    memref.copy %2, %alloc_11 : memref<4xf32> to memref<4xf32>
    %33 = spar_ll.allocate_reg() : !spar_ll.reg<4x8xf32>
    %34 = spar_ll.allocate_reg() : !spar_ll.reg<4xf32>
    %35 = spar_ll.loadm(%alloc, %33) : (memref<4x8xf32>) into !spar_ll.reg<4x8xf32>
    %36 = spar_ll.reduce(%34, %35) : (!spar_ll.reg<4x8xf32>) -> !spar_ll.reg<4xf32>
    %37 = spar_ll.allocate_reg() : !spar_ll.reg<4xf32>
    %38 = spar_ll.allocate_reg() : !spar_ll.reg<4xf32>
    %39 = spar_ll.loadv(%alloc_11, %37) {anchor = 1 : i32, broadcast = 0 : i32, offset = 0 : i32, orientation = 0 : i32} : (memref<4xf32>) into !spar_ll.reg<4xf32>
    %40 = spar_ll.add(%38, %36, %39) : (!spar_ll.reg<4xf32>, !spar_ll.reg<4xf32>) -> !spar_ll.reg<4xf32>
    %41 = spar_ll.storecolv(%40, %alloc_11) : (!spar_ll.reg<4xf32>) into memref<4xf32>
    %42 = spar_ll.allocate_reg() : !spar_ll.reg<4xf32>
    %43 = spar_ll.allocate_reg() : !spar_ll.reg<4xf32>
    %44 = spar_ll.allocate_reg() : !spar_ll.reg<4xf32>
    %45 = spar_ll.loadv(%alloc_11, %42) : (memref<4xf32>) into !spar_ll.reg<4xf32>
    %46 = spar_ll.loadv(%alloc_3, %43) : (memref<4xf32>) into !spar_ll.reg<4xf32>
    %47 = spar_ll.add(%44, %45, %46) : (!spar_ll.reg<4xf32>, !spar_ll.reg<4xf32>) -> !spar_ll.reg<4xf32>
    %48 = spar_ll.storev(%47, %alloc_2) : (!spar_ll.reg<4xf32>) into memref<4xf32>
    return %alloc_2 : memref<4xf32>
  }
}
