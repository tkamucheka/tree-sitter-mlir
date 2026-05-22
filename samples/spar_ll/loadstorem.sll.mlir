module {
  memref.global "private" constant @__constant_4x4xf32 : memref<4x4xf32> = dense<[[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00], [5.000000e+00, 6.000000e+00, 7.000000e+00, 8.000000e+00], [9.000000e+00, 1.000000e+01, 1.100000e+01, 1.200000e+01], [1.300000e+01, 1.400000e+01, 1.500000e+01, 1.600000e+01]]> {alignment = 64 : i64}
  func.func @run_main_graph() -> memref<4x4xf32> attributes {llvm.emit_c_interface} {
    %c4 = arith.constant 4 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %0 = memref.get_global @__constant_4x4xf32 : memref<4x4xf32>
    spar_ll.printstr punctuation = "[\0A"
    scf.for %arg0 = %c0 to %c4 step %c1 {
      spar_ll.printstr punctuation = "  ["
      scf.for %arg1 = %c0 to %c4 step %c1 {
        %4 = memref.load %0[%arg0, %arg1] : memref<4x4xf32>
        %5 = arith.addi %arg1, %c1 : index
        %6 = arith.cmpi ult, %5, %c4 : index
        scf.if %6 {
          spar_ll.print(%4) punctuation = ", " : f32
        }
        %7 = arith.cmpi uge, %5, %c4 : index
        scf.if %7 {
          spar_ll.print(%4) punctuation = "]" : f32
        }
      }
      %1 = arith.addi %arg0, %c1 : index
      %2 = arith.cmpi ult, %1, %c4 : index
      scf.if %2 {
        spar_ll.printstr punctuation = ",\0A"
      }
      %3 = arith.cmpi uge, %1, %c4 : index
      scf.if %3 {
        spar_ll.printstr punctuation = "\0A"
      }
    }
    spar_ll.printstr punctuation = "]\0A"
    return %0 : memref<4x4xf32>
  }
}
