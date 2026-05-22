module {
  memref.global "private" constant @__constant_4x4xf32 : memref<4x4xf32> = dense<1.000000e+00> {alignment = 64 : i64}
  memref.global "private" constant @__constant_4xf32 : memref<4xf32> = dense<0.000000e+00> {alignment = 64 : i64}
  func.func @run_main_graph() -> memref<4xf32> attributes {llvm.emit_c_interface} {
    %cst = arith.constant 0.000000e+00 : f32
    %c4 = arith.constant 4 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %0 = memref.get_global @__constant_4xf32 : memref<4xf32>
    %1 = memref.get_global @__constant_4x4xf32 : memref<4x4xf32>
    %alloc = memref.alloc() {alignment = 64 : i64, spar.zero_init_inserted} : memref<4xf32>
    scf.for %arg0 = %c0 to %c4 step %c1 {
      memref.store %cst, %alloc[%arg0] : memref<4xf32>
    }
    memref.copy %0, %alloc : memref<4xf32> to memref<4xf32>
    %2 = spar_ll.allocate_reg() : !spar_ll.reg<4x4xf32>
    %3 = spar_ll.allocate_reg() : !spar_ll.reg<4xf32>
    %4 = spar_ll.loadm(%1, %2) : (memref<4x4xf32>) into !spar_ll.reg<4x4xf32>
    %5 = spar_ll.reduce(%3, %4) : (!spar_ll.reg<4x4xf32>) -> !spar_ll.reg<4xf32>
    %6 = spar_ll.allocate_reg() : !spar_ll.reg<4xf32>
    %7 = spar_ll.allocate_reg() : !spar_ll.reg<4xf32>
    %8 = spar_ll.loadv(%alloc, %6) {anchor = 1 : i32, broadcast = 0 : i32, offset = 0 : i32, orientation = 0 : i32} : (memref<4xf32>) into !spar_ll.reg<4xf32>
    %9 = spar_ll.add(%7, %5, %8) : (!spar_ll.reg<4xf32>, !spar_ll.reg<4xf32>) -> !spar_ll.reg<4xf32>
    %10 = spar_ll.storecolv(%9, %alloc) : (!spar_ll.reg<4xf32>) into memref<4xf32>
    spar_ll.printstr punctuation = "["
    scf.for %arg0 = %c0 to %c4 step %c1 {
      %11 = memref.load %alloc[%arg0] : memref<4xf32>
      %12 = arith.addi %arg0, %c1 : index
      %13 = arith.cmpi ult, %12, %c4 : index
      scf.if %13 {
        spar_ll.print(%11) punctuation = ", " : f32
      }
      %14 = arith.cmpi uge, %12, %c4 : index
      scf.if %14 {
        spar_ll.print(%11) punctuation = "]\0A" : f32
      }
    }
    return %alloc : memref<4xf32>
  }
}
