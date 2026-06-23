# MLIR EBNF Grammar Reference

This document contains the EBNF grammar productions from the MLIR Language Reference, used as the canonical source of truth for MLIR syntax.

## Notation

```
alternation ::= expr0 | expr1 | expr2      // Either expr0 or expr1 or expr2.
sequence    ::= expr0 expr1 expr2          // Sequence of expr0 expr1 expr2.
repetition0 ::= expr*                      // 0 or more occurrences.
repetition1 ::= expr+                      // 1 or more occurrences.
optionality ::= expr?                      // 0 or 1 occurrence.
grouping    ::= (expr)                     // Everything inside parens is grouped.
literal     ::= `abcd`                     // Matches the literal `abcd`.
```

## Common Syntax

```ebnf
digit     ::= [0-9]
hex_digit ::= [0-9a-fA-F]
letter    ::= [a-zA-Z]
id-punct  ::= [$._-]

integer-literal ::= decimal-literal | hexadecimal-literal
decimal-literal ::= digit+
hexadecimal-literal ::= `0x` hex_digit+
float-literal ::= [-+]?[0-9]+[.][0-9]*([eE][-+]?[0-9]+)?
string-literal  ::= `"` [^"\n\f\v\r]* `"`
```

## Identifiers and Keywords

```ebnf
// Identifiers
bare-id ::= (letter|[_]) (letter|digit|[_$.])*
bare-id-list ::= bare-id (`,` bare-id)*
value-id ::= `%` suffix-id
alias-name ::= bare-id
suffix-id ::= (digit+ | ((letter|id-punct) (letter|id-punct|digit)*))

symbol-ref-id ::= `@` (suffix-id | string-literal) (`::` symbol-ref-id)?
value-id-list ::= value-id (`,` value-id)*

// Uses of value, e.g. in an operand list to an operation.
value-use ::= value-id (`#` decimal-literal)?
value-use-list ::= value-use (`,` value-use)*
```

## Top Level

```ebnf
// Top level production
toplevel ::= (operation | attribute-alias-def | type-alias-def)*
```

## Operations

```ebnf
operation             ::= op-result-list? (generic-operation | custom-operation)
                          trailing-location?
generic-operation     ::= string-literal `(` value-use-list? `)`  successor-list?
                          dictionary-properties? region-list? dictionary-attribute?
                          `:` function-type
custom-operation      ::= bare-id custom-operation-format
op-result-list        ::= op-result (`,` op-result)* `=`
op-result             ::= value-id (`:` integer-literal)?
successor-list        ::= `[` successor (`,` successor)* `]`
successor             ::= caret-id (`:` block-arg-list)?
dictionary-properties ::= `<` dictionary-attribute `>`
region-list           ::= `(` region (`,` region)* `)`
dictionary-attribute  ::= `{` (attribute-entry (`,` attribute-entry)*)? `}`
trailing-location     ::= `loc` `(` location `)`
```

## Blocks

```ebnf
block           ::= block-label operation+
block-label     ::= block-id block-arg-list? `:`
block-id        ::= caret-id
caret-id        ::= `^` suffix-id
value-id-and-type ::= value-id `:` type

// Non-empty list of names and types.
value-id-and-type-list ::= value-id-and-type (`,` value-id-and-type)*

block-arg-list ::= `(` value-id-and-type-list? `)`
```

## Regions

```ebnf
region      ::= `{` entry-block? block* `}`
entry-block ::= operation+
```

## Types

```ebnf
type ::= type-alias | dialect-type | builtin-type

type-list-no-parens ::=  type (`,` type)*
type-list-parens ::= `(` `)`
                   | `(` type-list-no-parens `)`

// This is a common way to refer to a value with a specified type.
ssa-use-and-type ::= ssa-use `:` type
ssa-use ::= value-use

// Non-empty list of names and types.
ssa-use-and-type-list ::= ssa-use-and-type (`,` ssa-use-and-type)*

function-type ::= (type | type-list-parens) `->` (type | type-list-parens)
```

### Type Aliases

```ebnf
type-alias-def ::= `!` alias-name `=` type
type-alias ::= `!` alias-name
```

### Dialect Types

```ebnf
dialect-namespace ::= bare-id

dialect-type ::= `!` (opaque-dialect-type | pretty-dialect-type)
opaque-dialect-type ::= dialect-namespace dialect-type-body
pretty-dialect-type ::= dialect-namespace `.` pretty-dialect-type-lead-ident
                                              dialect-type-body?
pretty-dialect-type-lead-ident ::= `[A-Za-z][A-Za-z0-9._]*`

dialect-type-body ::= `<` dialect-type-contents+ `>`
dialect-type-contents ::= dialect-type-body
                            | `(` dialect-type-contents+ `)`
                            | `[` dialect-type-contents+ `]`
                            | `{` dialect-type-contents+ `}`
                            | [^\[<({\]>)}\0]+
```

### Builtin Types

The builtin dialect provides:
- Integer types: `i8`, `i16`, `i32`, `i64`, `si*`, `ui*`
- Float types: `f16`, `f32`, `f64`, `f80`, `f128`, `bf16`
- Other: `index`, `none`
- Function types: `(type, type) -> type`
- Complex, Memref, Tensor, Vector, etc. (via parametric types)

## Attributes

```ebnf
attribute-entry ::= (bare-id | string-literal) `=` attribute-value
attribute-value ::= attribute-alias | dialect-attribute | builtin-attribute
```

### Attribute Value Aliases

```ebnf
attribute-alias-def ::= `#` alias-name `=` attribute-value
attribute-alias ::= `#` alias-name
```

### Dialect Attribute Values

```ebnf
dialect-namespace ::= bare-id

dialect-attribute ::= `#` (opaque-dialect-attribute | pretty-dialect-attribute)
opaque-dialect-attribute ::= dialect-namespace dialect-attribute-body
pretty-dialect-attribute ::= dialect-namespace `.` pretty-dialect-attribute-lead-ident
                                              dialect-attribute-body?
pretty-dialect-attribute-lead-ident ::= `[A-Za-z][A-Za-z0-9._]*`

dialect-attribute-body ::= `<` dialect-attribute-contents+ `>`
dialect-attribute-contents ::= dialect-attribute-body
                            | `(` dialect-attribute-contents+ `)`
                            | `[` dialect-attribute-contents+ `]`
                            | `{` dialect-attribute-contents+ `}`
                            | [^\[<({\]>)}\0]+
```

### Builtin Attribute Values

The builtin dialect provides:
- Boolean: `true`, `false`, `unit`
- Integer: `42`, `0xFF`
- Float: `3.14`, `1.0e-10`
- String: `"hello"`
- Array: `[1, 2, 3]`
- Dictionary: `{key = value}`
- AffineMap: `affine_map<(d0) -> (d0 + 1)>`
- Dense/Sparse/Opaque elements

## Comments

MLIR supports standard BCPL-style comments:

```
// This is a comment that goes to end of line
```

## Notes

- This is the authoritative grammar from the MLIR Language Reference
- Dialects may define custom operations, types, and attributes
- The grammar is designed to be unambiguous for round-tripping
- Keywords never collide with identifiers due to sigils (`%`, `#`, `@`, `^`, `!`)