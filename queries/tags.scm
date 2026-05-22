; Type alias definitions: !MyType = ...
(type_alias_def
  (bare_id) @name) @definition.type

; Attribute alias definitions: #MyAttr = ...
(attribute_alias_def
  (bare_id) @name) @definition.var

; Function-like operations: func.func @name, func.private @name, etc.
; Matches any custom op whose first body prefix is a symbol_ref_id
(custom_operation
  (bare_id) @_op
  (custom_op_body
    (custom_op_full_prefix
      (symbol_ref_id) @name) .)
  (#match? @_op "^func\\."))
@definition.function

; Module-level named ops (e.g. gpu.module @name, llvm.mlir.global @name)
(custom_operation
  (bare_id) @_op
  (custom_op_body
    (custom_op_full_prefix
      (symbol_ref_id) @name) .)
  (#match? @_op "^(module|gpu\\.module|llvm\\.mlir\\.global|memref\\.global)$"))
@definition.module

; Generic op definitions where the op string names the function
(generic_operation
  (string_literal) @name)
@definition.function

; References: any symbol_ref_id that is not in a definition position
(value_use
  (value_id) @name)
@reference.var

(custom_op_full_prefix
  (symbol_ref_id) @name)
@reference.function
