; Comments
(comment) @comment

; Literals
(string_literal) @string
(integer_literal) @number
(float_literal) @number
(bool_literal) @boolean
"unit" @constant.builtin

; Builtin types
(integer_type) @type.builtin
(float_type) @type.builtin
(index_type) @type.builtin
(none_type) @type.builtin
(tensor_type "tensor" @type.builtin)
(memref_type "memref" @type.builtin)
(vector_type "vector" @type.builtin)
(complex_type "complex" @type.builtin)
(tuple_type "tuple" @type.builtin)

; Tensor/memref/vector dimension tokens (e.g. 4x, ?x, *x)
(tensor_dim) @number

; Dense attribute literal content
(dense_integer) @number
(dense_float) @number

; User-defined type and attribute aliases
(type_alias) @type
(type_alias_def (bare_id) @type.definition)
(attribute_alias) @attribute
(attribute_alias_def (bare_id) @attribute.definition)

; Dialect types and attributes
(dialect_type) @type
(dialect_type (bare_id) @module ".")
(dialect_attribute) @attribute
(dialect_attribute (bare_id) @module ".")

; Attribute keywords
(dense_attribute "dense" @keyword)
(dense_resource_attribute "dense_resource" @keyword)
(sparse_attribute "sparse" @keyword)
(opaque_attribute "opaque" @keyword)
(strided_layout "strided" @keyword)
((strided_layout (angle_body (angle_body_content (bare_id) @keyword)))
 (#eq? @keyword "offset"))
(affine_map_attribute "affine_map" @keyword)
(affine_set_attribute "affine_set" @keyword)

; SSA values
(value_id) @variable
(op_result (value_id) @variable.definition)
(value_id_and_type (value_id) @variable.definition)

; Block labels and successors
(block_label (caret_id) @label)
(caret_id) @label

; Symbol references (functions, globals)
(symbol_ref_id) @function

; Operation names — dialect prefix gets @module, mnemonic gets @function.call
; Structural ops (module, constant): placed after @function.call so later-wins ordering picks @keyword
(custom_operation . (op_id (bare_id) @module "."))
((custom_operation . (op_id (bare_id) @function.call .))
 (#set! priority 90))
((custom_operation . (op_id . (bare_id) @keyword .))
 (#match? @keyword "^(module|constant)$")
 (#set! priority 101))
(generic_operation (string_literal) @string)

; Qualifier keywords inside op bodies (linkage, storage class, etc.)
; bare_id inside custom_op_full_prefix — does not match op names in op_id
((custom_op_full_prefix (bare_id) @keyword)
 (#match? @keyword "^(constant|private|public|external|internal)$"))
(custom_op_full_prefix "to" @keyword.operator)
(custom_op_full_prefix "iter_args" @keyword)
(attributes_dict_pair "attributes" @keyword)
((custom_op_full_prefix (bare_id) @keyword.operator)
 (#match? @keyword.operator "^step$"))

; Dictionary attribute keys
(attribute_entry . (attr_key . (bare_id) @module "."))
(attribute_entry . (attr_key (bare_id) @property .))
(attribute_entry . (string_literal) @property)
(custom_op_kv . (bare_id) @property)

; Type annotation keywords and operators
"->" @operator
"=" @operator
":" @punctuation.delimiter
"," @punctuation.delimiter
"::" @punctuation.delimiter
"to" @keyword.operator
"into" @keyword.operator

; Location keyword
"loc" @keyword

; Variadic marker
"..." @punctuation.special

; Brackets and delimiters
"(" @punctuation.bracket
")" @punctuation.bracket
"[" @punctuation.bracket
"]" @punctuation.bracket
"{" @punctuation.bracket
"}" @punctuation.bracket
"<" @punctuation.bracket
">" @punctuation.bracket

; Sigils
"%" @punctuation.variable
"@" @punctuation.special
"#" @punctuation.special
"!" @punctuation.special
"^" @punctuation.special
