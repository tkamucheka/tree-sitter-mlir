#map = affine_map<(d0) -> (-d0 + 10, 8)>
module {
  memref.global "private" constant @__constant_10xf32_0 : memref<10xf32> = dense<[1.000000e+01, 9.000000e+00, 8.000000e+00, 7.000000e+00, 6.000000e+00, 5.000000e+00, 4.000000e+00, 3.000000e+00, 2.000000e+00, 1.000000e+00]> {alignment = 64 : i64}
  memref.global "private" constant @__constant_10xf32 : memref<10xf32> = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00, 5.000000e+00, 6.000000e+00, 7.000000e+00, 8.000000e+00, 9.000000e+00, 1.000000e+01]> {alignment = 64 : i64}
  func.func @run_main_graph() -> memref<10xf32> attributes {llvm.emit_c_interface} {
    %cst = arith.constant 0.000000e+00 : f32
    %c1 = arith.constant 1 : index
    %c8 = arith.constant 8 : index
    %c10 = arith.constant 10 : index
    %c0 = arith.constant 0 : index
    %0 = memref.get_global @__constant_10xf32 : memref<10xf32>
    %1 = memref.get_global @__constant_10xf32_0 : memref<10xf32>
    %alloc = memref.alloc() {alignment = 64 : i64, spar.zero_init_inserted} : memref<10xf32>
    scf.for %arg0 = %c0 to %c10 step %c1 {
      memref.store %cst, %alloc[%arg0] : memref<10xf32>
    }
    scf.for %arg0 = %c0 to %c10 step %c8 {
      %2 = affine.min #map(%arg0)
      %subview = memref.subview %0[%arg0] [%2] [1] : memref<10xf32> to memref<?xf32, strided<[1], offset: ?>>
      %subview_0 = memref.subview %1[%arg0] [%2] [1] : memref<10xf32> to memref<?xf32, strided<[1], offset: ?>>
      %alloc_1 = memref.alloc(%2) {alignment = 64 : i64, spar.zero_init_inserted} : memref<?xf32>
      scf.for %arg1 = %c0 to %2 step %c1 {
        memref.store %cst, %alloc_1[%arg1] : memref<?xf32>
      }
      %3 = spar_ll.allocate_reg() : !spar_ll.reg<?xf32>
      %4 = spar_ll.allocate_reg() : !spar_ll.reg<?xf32>
      %5 = spar_ll.allocate_reg() : !spar_ll.reg<?xf32>
      %6 = spar_ll.loadv(%subview, %3) : (memref<?xf32, strided<[1], offset: ?>>) into !spar_ll.reg<?xf32>
      %7 = spar_ll.loadv(%subview_0, %4) : (memref<?xf32, strided<[1], offset: ?>>) into !spar_ll.reg<?xf32>
      %8 = spar_ll.add(%5, %6, %7) : (!spar_ll.reg<?xf32>, !spar_ll.reg<?xf32>) -> !spar_ll.reg<?xf32>
      %9 = spar_ll.storev(%8, %alloc_1) : (!spar_ll.reg<?xf32>) into memref<?xf32>
      %subview_2 = memref.subview %alloc[%arg0] [%2] [1] : memref<10xf32> to memref<?xf32, strided<[1], offset: ?>>
      memref.copy %alloc_1, %subview_2 : memref<?xf32> to memref<?xf32, strided<[1], offset: ?>>
    }
    spar_ll.printstr punctuation = "["
    scf.for %arg0 = %c0 to %c10 step %c1 {
      %2 = memref.load %alloc[%arg0] : memref<10xf32>
      %3 = arith.addi %arg0, %c1 : index
      %4 = arith.cmpi ult, %3, %c10 : index
      scf.if %4 {
        spar_ll.print(%2) punctuation = ", " : f32
      }
      %5 = arith.cmpi uge, %3, %c10 : index
      scf.if %5 {
        spar_ll.print(%2) punctuation = "]\0A" : f32
      }
    }
    return %alloc : memref<10xf32>
  }
}
