/// <reference types="tree-sitter-cli/dsl" />
// @ts-check

export default grammar({
  name: 'spar_mlir',

  extras: $ => [/\s+/, $.comment],

  word: $ => $.bare_id,

  conflicts: $ => [
    [$.region, $.dictionary_attribute],
    [$.custom_operation],
    [$.custom_op_full_prefix, $.custom_op_safe_prefix],
    [$.type_alias, $.dialect_type],
    [$.attribute_alias, $.dialect_attribute],
    [$.type, $.non_function_type],
    [$.function_type],
    [$.dialect_type],
    [$.caret_successor, $.custom_op_full_prefix, $.custom_op_safe_prefix],
    [$.caret_successor, $.custom_op_full_prefix],
    [$.caret_successor, $.custom_op_safe_prefix],
    [$.custom_op_kv_brackets, $.custom_op_full_prefix],
    [$.custom_op_body],
    [$.custom_op_body, $.custom_op_full_prefix],
    [$.custom_op_full_prefix, $.custom_op_kv],  // bare_id '=' is ambiguous: kv-pair vs two prefixes
    [$.custom_op_safe_prefix, $.type_annotation],  // ':' is both a safe_prefix token and start of type_annotation
    [$.type_annotation],      // optional trailing dict ambiguous with following custom_op_terminal region
    [$.dense_attribute],      // optional : type ambiguous with following type_annotation terminal
    [$.dialect_attribute],    // optional angle_body ambiguous with standalone angle_body prefix
    [$.op_id, $.attr_key],
  ],

  rules: {
    source_file: $ => repeat(choice(
      $.operation,
      $.attribute_alias_def,
      $.type_alias_def,
    )),

    comment: $ => /\/\/.*/,

    // --- Identifiers ---
    bare_id: $ => /[a-zA-Z_][a-zA-Z0-9_$]*/,

    // dot-separated op name: func.func, llvm.mlir.global, or bare: return, module
    op_id: $ => seq($.bare_id, repeat(seq('.', $.bare_id))),

    suffix_id: $ => choice(
      /[0-9]+/,
      /[a-zA-Z_$.\-][a-zA-Z0-9_$.\-]*/,
    ),

    value_id: $ => seq('%', $.suffix_id),

    caret_id: $ => seq('^', $.suffix_id),

    symbol_ref_id: $ => prec.right(seq(
      '@',
      choice($.suffix_id, $.string_literal),
      optional(seq('::', $.symbol_ref_id)),
    )),

    // --- Literals ---
    integer_literal: $ => token(choice(
      /0x[0-9a-fA-F]+/,
      /[0-9]+/,
    )),

    float_literal: $ => /[+-]?[0-9]+\.[0-9]*([eE][+-]?[0-9]+)?/,

    string_literal: $ => /"[^"\n\f\v\r]*"/,

    // --- Top level ---
    attribute_alias_def: $ => seq('#', $.bare_id, '=', $.attribute_value),
    type_alias_def: $ => seq('!', $.bare_id, '=', $.type),

    // --- Operations ---
    operation: $ => seq(
      optional($.op_result_list),
      choice($.generic_operation, $.custom_operation),
      optional($.trailing_location),
    ),

    op_result_list: $ => seq(commaSep1($.op_result), '='),
    op_result: $ => seq($.value_id, optional(seq(':', $.integer_literal))),

    trailing_location: $ => seq('loc', '(', $.location, ')'),
    location: $ => seq(
      $.string_literal, ':', $.integer_literal, ':', $.integer_literal,
    ),

    // Generic: "opname"(args) [succs] <dict-props> (regions) {attrs} : functype
    generic_operation: $ => seq(
      $.string_literal,
      '(', optional($.value_use_list), ')',
      optional($.successor_list),
      optional($.dictionary_properties),
      optional($.region_list),
      optional($.dictionary_attribute),
      ':', $.function_type,
    ),

    successor_list: $ => seq('[', commaSep1($.caret_id), ']'),
    dictionary_properties: $ => seq('<', $.dictionary_attribute, '>'),
    region_list: $ => seq('(', commaSep1($.region), ')'),

    // --- Custom operation ---
    // Body is one of two forms to prevent greedy consumption of the next op:
    //   1. with_terminal: any prefix tokens followed by a required terminal (: type or region)
    //   2. safe_prefix_only: only unambiguous tokens (no bare_id or value_use at top level)
    custom_operation: $ => seq(
      $.op_id,
      optional($.custom_op_body),
    ),

    custom_op_body: $ => choice(
      // terminal wins over dict when {…} is ambiguous — region beats unit-attr-dict
      prec.dynamic(3, seq(repeat($.custom_op_full_prefix), $.custom_op_terminal)),
      // dict fallback: wins when content can't be a valid region (e.g. k=v pairs)
      prec.dynamic(2, seq(repeat($.custom_op_full_prefix), $.dictionary_attribute)),
      prec.dynamic(1, repeat1($.custom_op_safe_prefix)),
    ),

    // 'attributes' always paired with its dict. In safe_prefix too so that after path-3 reduces,
    // the next token is '{' (region) which can't be an op_id — invalidating any split parse.
    attributes_dict_pair: $ => seq('attributes', $.dictionary_attribute),

    // Terminal: ends the operation cleanly
    custom_op_terminal: $ => choice(
      $.type_annotation,
      // region optionally followed by: do-region, return-type (linalg.generic), trailing-dict (scf.forall)
      seq($.region, optional(seq('do', $.region)),
        optional(choice($.type_annotation, $.return_type_annotation)),
        optional($.dictionary_attribute)),
      // type annotation THEN region: scf.reduce-style (: type { body })
      prec.dynamic(1, seq($.type_annotation, $.region)),
      // type annotation THEN two regions: scf.while-style (: types { body } do { body })
      prec.dynamic(2, seq($.type_annotation, $.region, 'do', $.region)),
      $.caret_successor,  // for terminator ops: llvm.br ^bb1, llvm.cond_br %c, ^bb1, ^bb2
    ),

    // One or more caret_id successors with optional value lists (llvm-style branch args)
    caret_successor: $ => seq(
      $.caret_id,
      optional($.custom_parens),
      repeat(seq(',', $.caret_id, optional($.custom_parens))),
    ),

    // Full prefix: appears before a terminal (bare_id, value_use, kv-pairs, etc.)
    custom_op_full_prefix: $ => choice(
      $.string_literal,
      $.symbol_ref_id,
      $.value_use,
      $.attribute_alias,
      $.integer_literal,
      $.float_literal,
      $.dense_attribute,
      $.dense_resource_attribute,
      $.affine_map_attribute,
      $.affine_set_attribute,
      $.sparse_attribute,
      $.opaque_attribute,
      $.dialect_type,   // for !type tokens appearing inline (e.g. llvm.alloca %n x !llvm.struct<...>)
      $.caret_id,       // for block successor refs in terminator ops
      $.dictionary_attribute,
      $.custom_parens,
      $.custom_brackets,
      $.return_type_annotation,
      $.custom_op_kv,
      $.custom_op_kv_brackets,  // for `key: [...]` syntax (e.g. offset: [...] in reinterpret_cast)
      $.fastmath_attribute,
      $.typed_array_attribute,
      $.angle_body,        // for bare keyword<...> patterns (e.g. locality<3>)
      $.bare_id,
      'to',
      'in',
      'do',
      'iter_args',
      $.attributes_dict_pair,
      '=',               // for iter-var assignment: (%ivs) = (%lbs) to (%ubs)
      '-',               // sign prefix for negative literals: -2, -1.0
      ',',
    ),

    // key: [...] — bare_id followed by a bracket list (e.g. offset: [%c0], sizes: [...])
    custom_op_kv_brackets: $ => seq($.bare_id, ':', $.custom_brackets),

    // Safe prefix: cannot be confused with a new operation's result or name
    custom_op_safe_prefix: $ => choice(
      $.string_literal,
      $.symbol_ref_id,
      $.attribute_alias,
      $.integer_literal,
      $.float_literal,
      $.value_use,        // %id — safe since % can never start an op name
      $.caret_id,         // for block successor refs (e.g. llvm.br ^bb1)
      $.custom_parens,
      $.custom_brackets,
      $.affine_map_attribute,  // safe: 'affine_map' is keyword-extracted
      $.affine_set_attribute,  // safe: 'affine_set' is keyword-extracted
      $.dense_attribute,       // safe: 'dense' is keyword-extracted
      $.fastmath_attribute,    // safe: 'fastmath' is keyword-extracted; prevents split-parse for e.g. addf %a,%b fastmath<fast> : f32
      $.typed_array_attribute, // safe: keyword-extracted similarly
      $.integer_type,          // safe: keyword-extracted (e.g. i32, si64)
      $.float_type,            // safe: keyword-extracted (e.g. f32, bf16)
      $.index_type,            // safe: keyword-extracted
      $.none_type,             // safe: keyword-extracted
      $.custom_op_kv,  // key = value without terminal (e.g. spar_ll.printstr punctuation = "...")
      $.return_type_annotation,  // for external func decls: llvm.func @f(i32) -> i32
      $.attributes_dict_pair,   // 'attributes' {dict}: safe since 'attributes' is keyword-extracted; paired with dict so split parse leaves '{region}' which can't be op_id
      ':',             // type separator (cf.switch, scf.reduce before region)
      ',',             // argument separator (cf.assert %arg, "msg")
    ),

    // -> type or -> (types) — used in func signatures and scf.for return types
    return_type_annotation: $ => seq(
      '->',
      choice($.type_list_parens, $.non_function_type),
    ),

    // Scoped key=value in custom op format (%i = %lo, punctuation = "...")
    custom_op_kv: $ => seq(
      choice($.bare_id, $.value_use),
      '=',
      choice($.attribute_value, $.value_use),
    ),

    // (...) in custom op: value lists, block args, iter_args, function decl args, etc.
    custom_parens: $ => seq(
      '(',
      repeat(choice(
        $.value_use,
        $.value_id_and_type,
        $.custom_parens,
        $.custom_brackets,  // for gather_dims([1, 2]) inside parens
        $.dialect_type,   // for !type tokens, e.g. llvm.func @f(!llvm.ptr)
        $.dense_attribute,
        $.tensor_type,
        $.memref_type,
        $.vector_type,
        $.angle_body,     // for <...> bodies after keyword tokens not handled above
        $.integer_type,
        $.float_type,
        $.index_type,
        $.none_type,
        $.bool_literal,
        $.integer_literal,
        $.float_literal,
        $.string_literal,
        $.bare_id,
        ':',
        ',',
        '=',
        '+',
        '-',
        '...',
      )),
      ')',
    ),

    // [...] in custom op: offsets, sizes, strides, reshape groups, cf.switch successor tables
    custom_brackets: $ => seq(
      '[',
      repeat(choice(
        $.value_use,
        $.caret_id,       // for cf.switch: [default: ^bb1, 42: ^bb2]
        $.custom_parens,  // for cf.switch: ^bb1(%x : i32)
        $.integer_literal,
        $.float_literal,
        $.bare_id,
        ':',
        ',',
        '+',
        '-',
        $.custom_brackets,
      )),
      ']',
    ),

    // type annotation: supports comma-separated type lists (e.g. llvm.store : type1, type2)
    type_annotation: $ => seq(
      ':', $.type_list_no_parens,
      optional(choice(
        seq('to', $.type),
        seq('into', $.type),
      )),
      optional(seq(',', $.custom_brackets)),   // e.g. cf.switch : i32, [default: ^bb1, ...]
      optional(seq('=', $.attribute_value)),  // e.g. memref.global : type = dense<...>
      optional($.dictionary_attribute),        // trailing attrs, e.g. {alignment = 64 : i64}
    ),

    // --- Blocks and regions ---
    region: $ => seq('{', optional($.region_body), '}'),

    region_body: $ => choice(
      seq($.entry_block, repeat($.block)),
      repeat1($.block),
    ),

    entry_block: $ => repeat1($.operation),
    block: $ => seq($.block_label, repeat1($.operation)),
    block_label: $ => seq($.caret_id, optional($.block_arg_list), ':'),
    block_arg_list: $ => seq('(', optional(commaSep1($.value_id_and_type)), ')'),
    // func args may carry per-arg attribute dicts: %arg0: tensor<?xf32> {onnx.name = "input"}
    value_id_and_type: $ => seq($.value_id, ':', $.type, optional($.dictionary_attribute)),

    // --- Value uses ---
    value_use: $ => prec.right(seq($.value_id, optional(seq('#', $.integer_literal)))),
    value_use_list: $ => commaSep1($.value_use),

    // --- Types ---
    type: $ => choice(
      $.type_alias,
      $.dialect_type,
      $.builtin_type,
      $.function_type,
    ),

    type_alias: $ => seq('!', $.bare_id),

    type_list_no_parens: $ => prec.right(commaSep1($.type)),
    // Each type in a paren list may carry an attribute dict (e.g. ONNX return types)
    type_list_parens: $ => seq(
      '(',
      optional(commaSep1(seq($.type, optional($.dictionary_attribute)))),
      ')',
    ),

    function_type: $ => seq(
      choice($.type_list_parens, $.non_function_type),
      choice('->', 'into'),
      choice($.type_list_parens, $.type_list_no_parens),
    ),

    non_function_type: $ => choice(
      $.type_alias,
      $.dialect_type,
      $.builtin_type,
    ),

    builtin_type: $ => choice(
      $.integer_type,
      $.float_type,
      $.index_type,
      $.none_type,
      // Parametric types parsed as opaque angle-bracket forms
      $.tensor_type,
      $.memref_type,
      $.vector_type,
      $.complex_type,
      $.tuple_type,
    ),

    // prec(1) ensures integer_type beats bare_id when both match (e.g. i32, si64)
    integer_type: $ => token(prec(1, /[su]?i[1-9][0-9]*/)),
    float_type: $ => choice('f16', 'f32', 'f64', 'f80', 'f128', 'bf16'),
    index_type: $ => 'index',
    none_type: $ => 'none',

    // Dimension token: `4x`, `?x`, `*x` — atomic so the lexer never splits `4x8xf32`
    tensor_dim: $ => token(choice(/[0-9]+x/, '?x', '*x')),
    // Scalable vector dimension: `[N]x` — e.g. vector<[8]xi64>
    scalable_dim: $ => token(/\[[0-9]+\]x/),

    tensor_type: $ => seq('tensor', '<', repeat($.tensor_dim), $.non_function_type,
      optional(seq(',', $.attribute_value)), '>'),
    memref_type: $ => seq('memref', '<', repeat($.tensor_dim), $.non_function_type,
      repeat(seq(',', $.attribute_value)), '>'),
    // repeat (not repeat1) supports 0D vectors; choice allows mixed static/scalable dims
    vector_type: $ => seq('vector', '<', repeat(choice($.tensor_dim, $.scalable_dim)), $.non_function_type, '>'),
    complex_type: $ => seq('complex', '<', $.type, '>'),
    tuple_type: $ => seq('tuple', '<', optional($.type_list_no_parens), '>'),

    // Opaque <...> body (handles arbitrary nesting)
    angle_body: $ => seq('<', optional($.angle_body_content), '>'),
    // Structured content: type keywords and dim tokens are recognized before the
    // catch-all so they get proper AST nodes. The catch-all covers non-word chars
    // (operators, colons, commas, sigils) that don't match any specific token.
    angle_body_content: $ => repeat1(choice(
      $.angle_body,
      seq('(', optional($.angle_body_content), ')'),
      seq('[', optional($.angle_body_content), ']'),
      seq('{', optional($.angle_body_content), '}'),
      $.scalable_dim,   // [N]x — scalable vector dim
      $.tensor_dim,     // 4x, ?x, *x — longer than integer_literal so wins for 4x...
      $.integer_type,   // i32, si64, ui8 — prec(1) beats bare_id on same-length match
      $.float_type,     // f32, f64, bf16 — keyword-extracted from bare_id
      $.index_type,     // index
      $.none_type,      // none
      $.bool_literal,   // true / false
      $.integer_literal,
      $.float_literal,
      $.string_literal,
      $.bare_id,        // everything else word-like
      /[^\[<({\]>)}\w"]+/,   // non-word catch-all: !, ?, *, ->, commas, colons …
    )),

    // --- Dialect types ---
    dialect_type: $ => seq('!', $.bare_id, repeat(seq('.', $.bare_id)), optional($.angle_body)),

    // --- Attributes ---
    attribute_alias: $ => seq('#', $.bare_id),

    attribute_value: $ => choice(
      $.attribute_alias,
      $.dialect_attribute,
      $.builtin_attribute,
    ),

    // #namespace or #namespace.name or #namespace<body> or #namespace.name<body>
    dialect_attribute: $ => seq('#', $.bare_id, repeat(seq('.', $.bare_id)), optional($.angle_body)),

    builtin_attribute: $ => choice(
      $.integer_attribute,
      $.float_attribute,
      $.string_literal,
      $.bool_literal,
      'unit',
      $.dense_attribute,
      $.dense_resource_attribute,
      $.sparse_attribute,
      $.opaque_attribute,
      $.strided_layout,
      $.typed_array_attribute,
      $.fastmath_attribute,
      $.array_attribute,
      $.dictionary_attribute,
      $.affine_map_attribute,
      $.affine_set_attribute,
      $.type_attribute,
      $.symbol_ref_id,  // e.g. {func = @main_graph}
    ),

    bool_literal: $ => choice('true', 'false'),

    // Integer attribute: literal optionally followed by : integer_type | index
    integer_attribute: $ => prec.right(seq(
      $.integer_literal,
      optional(seq(':', choice($.integer_type, $.index_type))),
    )),

    // Float attribute: literal optionally followed by : float_type
    float_attribute: $ => prec.right(seq(
      $.float_literal,
      optional(seq(':', $.float_type)),
    )),

    // Type used as an attribute
    type_attribute: $ => $.non_function_type,

    // Affine maps/sets use -> and >= internally — use special content regex
    affine_map_attribute: $ => seq('affine_map', '<', $.affine_expr_content, '>'),
    affine_set_attribute: $ => seq('affine_set', '<', $.affine_expr_content, '>'),
    // Matches affine map/set content: allows -> and >= but stops at bare >
    affine_expr_content: $ => /(->|>=|[^<>])*/,
    // optional `: type` covers typed dense attrs inside dicts: {foo = dense<> : tensor<0xi32>}
    dense_attribute: $ => seq('dense', '<', optional($.dense_value), '>', optional(seq(':', $.non_function_type))),

    // Number tokens inside dense — atomic so signed forms like -1 and -1.0 lex cleanly
    dense_integer: $ => token(choice(/[+-]?0x[0-9a-fA-F]+/, /[+-]?[0-9]+/)),
    dense_float: $ => token(/[+-]?[0-9]+\.[0-9]*([eE][+-]?[0-9]+)?/),

    dense_value: $ => choice(
      $.dense_float,
      $.dense_integer,
      $.string_literal,
      $.bool_literal,
      '...',
      $.dense_array,
      seq('(', commaSep1($.dense_value), ')'),  // complex/tuple: dense<(1.2, 2.3)>
    ),

    dense_array: $ => seq('[', optional(commaSep1($.dense_value)), ']'),
    dense_resource_attribute: $ => seq('dense_resource', $.angle_body),
    sparse_attribute: $ => seq('sparse', $.angle_body),
    opaque_attribute: $ => seq('opaque', $.angle_body),
    strided_layout: $ => seq('strided', $.angle_body),

    // array<type: val, val, ...> — MLIR dense array attribute
    typed_array_attribute: $ => seq(
      'array', '<', $.non_function_type, ':',
      optional(commaSep1(choice($.integer_literal, $.float_literal, $.bool_literal))),
      '>',
    ),

    // fastmath<flag, flag, ...> — arithmetic fastmath flags
    fastmath_attribute: $ => seq('fastmath', '<', commaSep1($.bare_id), '>'),

    array_attribute: $ => seq('[', optional(commaSep1($.attribute_value)), ']'),

    dictionary_attribute: $ => seq(
      '{',
      optional(commaSep1($.attribute_entry)),
      '}',
    ),

    // Attribute dict key: simple or dialect-dotted (e.g. onnx.name, sym_name)
    attr_key: $ => seq($.bare_id, repeat(seq('.', $.bare_id))),

    attribute_entry: $ => choice(
      seq(choice($.attr_key, $.string_literal), '=', $.attribute_value),
      // unit attribute shorthand: just the name, no = value
      choice($.attr_key, $.string_literal),
    ),
  },
});

function commaSep1(rule) {
  return seq(rule, repeat(seq(',', rule)));
}
