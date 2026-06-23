# Query File Reference

Six [tree-sitter query](https://tree-sitter.github.io/tree-sitter/using-parsers/queries/) files live in `queries/`. Each targets a distinct editor feature.

## Syntax Highlighting (`highlights.scm`)

Maps AST node types to standard [highlight capture names](https://tree-sitter.github.io/tree-sitter/syntax-highlighting).

| Capture                  | Matched Nodes                                                    |
|--------------------------|------------------------------------------------------------------|
| `@comment`               | Line comments (`// ...`)                                         |
| `@string`                | String literals; quoted op names in generic operations           |
| `@number`                | Integer and float literals, `tensor_dim` (`4x`, `?x`), `dense_integer`, `dense_float` |
| `@boolean`               | `true`, `false`                                                  |
| `@constant.builtin`      | `unit`                                                           |
| `@type.builtin`          | `i32`, `f64`, `index`, `none`, `tensor`, `memref`, etc.         |
| `@type`                  | Type aliases (`!MyType`) and dialect types (`!llvm.ptr`)         |
| `@type.definition`       | Type alias definitions (`!MyType = ...`)                         |
| `@attribute`             | Attribute aliases (`#MyAttr`) and dialect attributes             |
| `@attribute.definition`  | Attribute alias definitions (`#MyAttr = ...`)                    |
| `@variable`              | SSA value identifiers (`%0`, `%arg0`)                            |
| `@variable.definition`   | SSA value definitions (op results and block arguments)           |
| `@label`                 | Block labels and caret successors (`^bb0`, `^bb1`)               |
| `@function`              | Symbol references (`@main_graph`, `@func`)                       |
| `@function.call`         | Op mnemonic (last `bare_id` in `op_id`, e.g. `func` in `func.func`) |
| `@module`                | Dialect prefix in op names (`func.` in `func.func`) and dotted attr keys |
| `@property`              | Attribute entry keys (last component) and `key = value` op format keys |
| `@operator`              | `->`, `=`                                                        |
| `@keyword`               | `module`, `constant` structural ops; `loc`, `dense`, `dense_resource`, `sparse`, `opaque`, `strided`, `offset`, `affine_map`, `affine_set`; qualifier keywords (`private`, `public`, `external`, `internal`) |
| `@keyword.operator`      | `to`, `into` (in type annotations); `to`, `step` (in custom op prefix position) |
| `@punctuation.variable`  | `%` (SSA value sigil)                                            |
| `@punctuation.*`         | Other delimiters, brackets, and sigils (`@`, `#`, `!`, `^`)     |

## Semantic Scoping (`locals.scm`)

Declares the SSA value scope hierarchy for editors that support semantic rename, go-to-definition, and reference highlighting. MLIR's SSA form has lexical scoping rules: values defined in a region are not visible outside it, and block arguments shadow outer definitions.

| Capture               | Matched Nodes                                            |
|-----------------------|----------------------------------------------------------|
| `@local.scope`        | `region`, `block` — introduces a new SSA scope           |
| `@local.definition`   | `value_id` in op result lists and block argument lists   |
| `@local.reference`    | `value_id` inside `value_use` nodes                      |

Editors with `locals.scm` support (e.g. Neovim with `nvim-treesitter`) use these declarations to:

- **Rename symbol** — rename `%val` at all use sites within its defining scope without affecting identically named values in sibling scopes
- **Go to definition** — navigate from a use of `%arg0` to its definition in the block argument list or op result
- **Highlight references** — illuminate all uses of the value under the cursor within its scope

## Indentation Hints (`indents.scm`)

Provides indentation rules for editors that derive auto-indent from the parse tree rather than regex heuristics.

| Capture          | Trigger                                        |
|------------------|------------------------------------------------|
| `@indent.begin`  | `{` opening a `region` or `dictionary_attribute` |
| `@indent.end`    | `}` closing a `region` or `dictionary_attribute` |

These hints are consumed by editors such as Neovim (via `nvim-treesitter` indent module), Helix, and Zed to compute the correct indentation column when the user presses Enter or applies `=` to reindent a range.

## Code Folding (`folds.scm`)

Marks subtrees that editors may collapse into a single summary line.

| Capture | Node               | Typical Content                                      |
|---------|--------------------|------------------------------------------------------|
| `@fold` | `region`           | Function bodies, module bodies, loop bodies          |
| `@fold` | `dictionary_attribute` | Inline attribute dictionaries (`{key = val, ...}`) |
| `@fold` | `angle_body`       | Parametric type/attribute bodies (`<...>`)           |
| `@fold` | `dense_attribute`  | Dense literal nodes (`dense<...>`)                   |

Folding is activated via editor-specific commands (e.g. `za` / `zc` in Neovim, `:fold` in Helix).

## Symbol Indexing (`tags.scm`)

Provides structured symbol information for code navigation tools, ctags-compatible indexers, and host services such as GitHub's code navigation.

**Definitions:**

| Capture                | Matched Pattern                                   |
|------------------------|---------------------------------------------------|
| `@definition.function` | `func.func @name`, `func.private @name`, etc.     |
| `@definition.module`   | `module @name`, `gpu.module @name`, `llvm.mlir.global @name`, `memref.global @name` |
| `@definition.type`     | `!MyType = ...` type alias definitions            |
| `@definition.var`      | `#MyAttr = ...` attribute alias definitions       |

Op names are matched with `#match?` predicates on the `bare_id` node, so only semantically meaningful definitions are tagged rather than every custom operation.

**References:**

| Capture              | Matched Pattern                        |
|----------------------|----------------------------------------|
| `@reference.function` | Symbol references in op body prefixes |
| `@reference.var`     | SSA value uses                         |

## Structural Text Objects (`textobjects.scm`)

Defines named AST regions for structural editing motions. Consumed by `nvim-treesitter-textobjects` and similar plugins to enable object-aware selection, deletion, and navigation.

| Capture                                | Selects                                                            |
|----------------------------------------|--------------------------------------------------------------------|
| `@statement.outer`                     | A complete `operation` node (one MLIR statement)                   |
| `@function.outer` / `@function.inner`  | An op containing a region / the `region_body` inside               |
| `@block.outer` / `@block.inner`        | A `region` node / the `region_body` inside                         |
| `@class.outer` / `@class.inner`        | A labeled `block` / the operations within a block                  |
| `@parameter.inner`                     | A `value_id_and_type` (func/block arg), `op_result`, or `attribute_entry` |
| `@parameter.outer`                     | Same, with surrounding delimiter included                          |
| `@comment.outer`                       | A `comment` node                                                   |

Example motions in Neovim with `nvim-treesitter-textobjects`:

| Keymap (example) | Action                                              |
|------------------|-----------------------------------------------------|
| `vaf`            | Select the entire function-like operation and its region |
| `vif`            | Select only the region body (inner function)        |
| `vab` / `vib`    | Select around / inside a region                     |
| `vip`            | Select a function argument or op result             |
| `das`            | Delete a complete MLIR operation                    |
| `]m` / `[m`      | Jump to next / previous function-like operation     |
