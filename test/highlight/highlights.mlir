// This is a comment
// <- comment

!MyAlias = i64
// <- punctuation.special
//^ type.definition
//         ^ type.builtin

#myattr = dense<1> : tensor<1xi64>
// <- punctuation.special
//^ attribute.definition
//        ^ keyword

func.func @foo(%arg0: i32, %arg1: f32) -> i32 {
// <- module
//   ^ function.call
//         ^ function
//              ^ variable.definition
//                    ^ type.builtin
//                          ^ variable.definition
//                                ^ type.builtin
//                                        ^ type.builtin
  %0 = arith.constant 42 : i32
// ^ variable.definition
//   ^ operator
//     ^ module
//           ^ function.call
//                    ^ number
//                         ^ type.builtin
  %1 = arith.addi %0, %0 : i32
// ^ variable.definition
//     ^ module
//           ^ function.call
//                          ^ type.builtin
  return %1 : i32
//  ^ function.call
//              ^ type.builtin
}
// <- punctuation.bracket

module @mymod {
// <- keyword
//      ^ function
}

func.func @dtfn(%p: !llvm.ptr) {
//                        ^ type
  llvm.return
//^ module
//     ^ function.call
}
