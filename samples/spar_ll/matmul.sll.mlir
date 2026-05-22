module {
  memref.global "private" constant @__constant_4xf32_0 : memref<4xf32> = dense<1.000000e+00> {alignment = 64 : i64}
  memref.global "private" constant @__constant_4x4xf32 : memref<4x4xf32> = dense<1.000000e+00> {alignment = 64 : i64}
  memref.global "private" constant @__constant_4xf32 : memref<4xf32> = dense<0.000000e+00> {alignment = 64 : i64}
  func.func @run_main_graph() -> memref<4xf32> attributes {llvm.emit_c_interface} {
    %cst = arith.constant 0.000000e+00 : f32
    %c4 = arith.constant 4 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %0 = memref.get_global @__constant_4xf32 : memref<4xf32>
    %1 = memref.get_global @__constant_4x4xf32 : memref<4x4xf32>
    %2 = memref.get_global @__constant_4xf32_0 : memref<4xf32>
    %alloc = memref.alloc() {alignment = 64 : i64, spar.zero_init_inserted} : memref<4x4xf32>
    scf.for %arg0 = %c0 to %c4 step %c1 {
      scf.for %arg1 = %c0 to %c4 step %c1 {
        memref.store %cst, %alloc[%arg0, %arg1] : memref<4x4xf32>
      }
    }
    %3 = spar_ll.allocate_reg() : !spar_ll.reg<4xf32>
    %4 = spar_ll.allocate_reg() : !spar_ll.reg<4x4xf32>
    %5 = spar_ll.allocate_reg() : !spar_ll.reg<4x4xf32>
    %6 = spar_ll.loadv(%2, %3) : (memref<4xf32>) into !spar_ll.reg<4xf32>
    %7 = spar_ll.loadm(%1, %4) : (memref<4x4xf32>) into !spar_ll.reg<4x4xf32>
    %8 = spar_ll.mul(%5, %6, %7) : (!spar_ll.reg<4xf32>, !spar_ll.reg<4x4xf32>) -> !spar_ll.reg<4x4xf32>
    %9 = spar_ll.storem(%8, %alloc) : (!spar_ll.reg<4x4xf32>) into memref<4x4xf32>
    spar_ll.printstr punctuation = "[\0A"
    scf.for %arg0 = %c0 to %c4 step %c1 {
      spar_ll.printstr punctuation = "  ["
      scf.for %arg1 = %c0 to %c4 step %c1 {
        %22 = memref.load %alloc[%arg0, %arg1] : memref<4x4xf32>
        %23 = arith.addi %arg1, %c1 : index
        %24 = arith.cmpi ult, %23, %c4 : index
        scf.if %24 {
          spar_ll.print(%22) punctuation = ", " : f32
        }
        %25 = arith.cmpi uge, %23, %c4 : index
        scf.if %25 {
          spar_ll.print(%22) punctuation = "]" : f32
        }
      }
      %19 = arith.addi %arg0, %c1 : index
      %20 = arith.cmpi ult, %19, %c4 : index
      scf.if %20 {
        spar_ll.printstr punctuation = ",\0A"
      }
      %21 = arith.cmpi uge, %19, %c4 : index
      scf.if %21 {
        spar_ll.printstr punctuation = "\0A"
      }
    }
    spar_ll.printstr punctuation = "]\0A"
    %alloc_0 = memref.alloc() {alignment = 64 : i64, spar.zero_init_inserted} : memref<4xf32>
    scf.for %arg0 = %c0 to %c4 step %c1 {
      memref.store %cst, %alloc_0[%arg0] : memref<4xf32>
    }
    memref.copy %0, %alloc_0 : memref<4xf32> to memref<4xf32>
    %10 = spar_ll.allocate_reg() : !spar_ll.reg<4x4xf32>
    %11 = spar_ll.allocate_reg() : !spar_ll.reg<4xf32>
    %12 = spar_ll.loadm(%alloc, %10) : (memref<4x4xf32>) into !spar_ll.reg<4x4xf32>
    %13 = spar_ll.reduce(%11, %12) : (!spar_ll.reg<4x4xf32>) -> !spar_ll.reg<4xf32>
    %14 = spar_ll.allocate_reg() : !spar_ll.reg<4xf32>
    %15 = spar_ll.allocate_reg() : !spar_ll.reg<4xf32>
    %16 = spar_ll.loadv(%alloc_0, %14) {anchor = 1 : i32, broadcast = 0 : i32, offset = 0 : i32, orientation = 0 : i32} : (memref<4xf32>) into !spar_ll.reg<4xf32>
    %17 = spar_ll.add(%15, %13, %16) : (!spar_ll.reg<4xf32>, !spar_ll.reg<4xf32>) -> !spar_ll.reg<4xf32>
    %18 = spar_ll.storecolv(%17, %alloc_0) : (!spar_ll.reg<4xf32>) into memref<4xf32>
    spar_ll.printstr punctuation = "["
    scf.for %arg0 = %c0 to %c4 step %c1 {
      %19 = memref.load %alloc_0[%arg0] : memref<4xf32>
      %20 = arith.addi %arg0, %c1 : index
      %21 = arith.cmpi ult, %20, %c4 : index
      scf.if %21 {
        spar_ll.print(%19) punctuation = ", " : f32
      }
      %22 = arith.cmpi uge, %20, %c4 : index
      scf.if %22 {
        spar_ll.print(%19) punctuation = "]\0A" : f32
      }
    }
    return %alloc_0 : memref<4xf32>
  }
}
