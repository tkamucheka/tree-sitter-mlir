; Operations (statements) — the fundamental unit in MLIR
(operation) @statement.outer

; Function-like: any operation that contains a region
; @function.outer = the whole operation, @function.inner = the region body
(operation
  (custom_operation
    (custom_op_body
      (custom_op_terminal
        (region
          (region_body) @function.inner)))))
@function.outer

(operation
  (generic_operation
    (region_list
      (region
        (region_body) @function.inner))))
@function.outer

; Regions — useful for selecting the body of any block-structured op
(region) @block.outer
(region_body) @block.inner

; Individual blocks within a region
(block) @class.outer
(block
  (block_label) .
  (operation) @_first .)
@class.inner

; Parameters: function/block arguments (value_id_and_type)
(value_id_and_type) @parameter.inner

; Wraps the comma too for outer selection
(block_arg_list
  (value_id_and_type) @parameter.outer)

; Op results (the LHS of %x, %y = op ...)
(op_result) @parameter.inner

; Attribute entries inside dicts
(attribute_entry) @parameter.inner

; Type annotations
(type_annotation) @parameter.inner

; Comments
(comment) @comment.outer
