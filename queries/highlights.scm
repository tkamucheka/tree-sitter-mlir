; Comments
(comment) @comment

; Literals
(string_literal) @string
(integer_literal) @number
(float_literal) @number.float
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

; User-defined type and attribute aliases
(type_alias) @type
(type_alias_def (bare_id) @type.definition)
(attribute_alias) @attribute
(attribute_alias_def (bare_id) @attribute.definition)

; Dialect types and attributes
(dialect_type) @type
(dialect_attribute) @attribute

; Attribute keywords
(dense_attribute "dense" @keyword)
(dense_resource_attribute "dense_resource" @keyword)
(sparse_attribute "sparse" @keyword)
(opaque_attribute "opaque" @keyword)
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

; Operation names
(custom_operation . (bare_id) @variable)
(generic_operation (string_literal) @function.call)

; Dictionary attribute keys
(attribute_entry . (bare_id) @property)
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
"%" @punctuation.special
"@" @punctuation.special
"#" @punctuation.special
"!" @punctuation.special
"^" @punctuation.special
