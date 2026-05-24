# tree-sitter-mlir

A [tree-sitter](https://tree-sitter.github.io/tree-sitter/) grammar for [MLIR](https://mlir.llvm.org/) (Multi-Level Intermediate Representation). The grammar targets the generic MLIR textual format as specified by the [MLIR Language Reference](https://mlir.llvm.org/docs/LangRef/), and handles the extensible custom operation format used by dialect-specific lowerings.

## Language Coverage

The grammar covers the full MLIR textual IR, including:

- **Generic operations** — the `"opname"(args) {attrs} : functype` form
- **Custom operations** — dialect-specific formats with arbitrary prefix tokens, type annotations, regions, and successor blocks
- **Types** — builtin scalar and parametric types (`tensor`, `memref`, `vector`, `complex`, `tuple`), dialect types (`!namespace.name<...>`), type aliases, and function types
- **Attributes** — all builtin attribute kinds (`dense`, `dense_resource`, `sparse`, `opaque`, `strided`, `affine_map`, `affine_set`, array, dictionary), dialect attributes, and attribute aliases
- **SSA values** — `%id`, result lists, block arguments with per-argument type annotations and attribute dicts
- **Regions and blocks** — entry blocks, labeled blocks with argument lists, block successors
- **Symbol references** — `@name` with nested `::` qualification

### Dialect Samples

The `samples/` directory contains corpus files used for parser validation across four dialect families:

| Directory   | Dialect            | Description                                       |
|-------------|--------------------|---------------------------------------------------|
| `llvm/`     | LLVM dialect       | Memory ops, arithmetic, control flow, function definitions |
| `onnx/`     | ONNX dialect       | Neural network graphs lowered to MLIR             |
| `spar_hl/`  | Spar high-level    | High-level Spar dialect ops                    |
| `spar_ll/`  | Spar low-level     | Low-level Spar dialect ops                     |

All 31 sample files parse with zero errors.

## Editor Query Files

Six [tree-sitter query](https://tree-sitter.github.io/tree-sitter/using-parsers/queries/) files are provided in `queries/`. Each targets a distinct editor feature.

### Syntax Highlighting (`highlights.scm`)

Maps AST node types to standard [highlight capture names](https://tree-sitter.github.io/tree-sitter/syntax-highlighting). The following categories are covered:

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

### Semantic Scoping (`locals.scm`)

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

### Indentation Hints (`indents.scm`)

Provides indentation rules for editors that derive auto-indent from the parse tree rather than regex heuristics. The grammar exposes two nesting constructs that affect indentation level:

| Capture          | Trigger                                        |
|------------------|------------------------------------------------|
| `@indent.begin`  | `{` opening a `region` or `dictionary_attribute` |
| `@indent.end`    | `}` closing a `region` or `dictionary_attribute` |

These hints are consumed by editors such as Neovim (via `nvim-treesitter` indent module), Helix, and Zed to compute the correct indentation column when the user presses Enter or applies `=` to reindent a range.

### Code Folding (`folds.scm`)

Marks subtrees that editors may collapse into a single summary line. Three node types are foldable:

| Capture | Node               | Typical Content                                      |
|---------|--------------------|------------------------------------------------------|
| `@fold` | `region`           | Function bodies, module bodies, loop bodies          |
| `@fold` | `dictionary_attribute` | Inline attribute dictionaries (`{key = val, ...}`) |
| `@fold` | `angle_body`       | Parametric type/attribute bodies (`<...>`)           |
| `@fold` | `dense_attribute`  | Dense literal nodes (`dense<...>`)                   |

Folding is activated via editor-specific commands (e.g. `za` / `zc` in Neovim, `:fold` in Helix).

### Symbol Indexing (`tags.scm`)

Provides structured symbol information for code navigation tools, ctags-compatible indexers, and host services such as GitHub's code navigation. Definitions and references are distinguished:

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

### Structural Text Objects (`textobjects.scm`)

Defines named AST regions for structural editing motions. These captures are consumed by `nvim-treesitter-textobjects` and similar plugins to enable object-aware selection, deletion, and navigation without relying on indentation or bracket matching.

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

## Installation

### Neovim (nvim-treesitter)

Register the parser as a custom grammar and point it at this repository:

```lua
-- In your nvim-treesitter config:
require("nvim-treesitter").setup({
  custom_parsers = {
    mlir = {
      install_info = {
        path = "/path/to/tree-sitter-mlir",
        files = { "src/parser.c" },
        queries = "queries",
        generate = true,
      },
      filetypes = { "mlir" },
    },
  },
})
```

For `nvim-treesitter-textobjects`, map the captures to keybindings:

```lua
require("nvim-treesitter.configs").setup({
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["as"] = "@statement.outer",
        ["ip"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      goto_next_start = { ["]m"] = "@function.outer" },
      goto_prev_start = { ["[m"] = "@function.outer" },
    },
  },
})
```

### Programmatic Use (Python)

```python
import tree_sitter_mlir as ts_mlir
from tree_sitter import Language, Parser

MLIR = Language(ts_mlir.language())
parser = Parser(MLIR)

with open("module.mlir", "rb") as f:
    tree = parser.parse(f.read())

print(tree.root_node.sexp())
```

### Programmatic Use (Rust)

```rust
let mut parser = tree_sitter::Parser::new();
parser.set_language(&tree_sitter_mlir::LANGUAGE.into())?;
let tree = parser.parse(source, None).unwrap();
```

### tree-sitter CLI

```sh
# Generate parser from grammar
npx tree-sitter generate

# Parse a file and print the CST
npx tree-sitter parse samples/llvm/addition.llvm.mlir

# Run the test suite
npx tree-sitter test

# Interactive playground (WebAssembly)
npm start
```

## Grammar Design Notes

### Custom Operation Parsing

MLIR's custom operation format is fully open-ended: each dialect defines its own syntax, and the generic textual form provides no delimiter between one operation and the next. The grammar resolves this with a two-path GLR structure:

1. **`with_terminal`** — zero or more prefix tokens followed by a required terminal: a type annotation (`: type`), a region (`{ ... }`), or a block successor (`^bb`). The terminal provides an unambiguous endpoint.
2. **`safe_prefix_only`** — one or more tokens that cannot be mistaken for the start of the next operation's result list or name. This handles ops that emit no type annotation and open no region.

This structure avoids consuming tokens belonging to the following operation while still supporting the wide variety of prefix token types appearing in real-world dialects.

### GLR Conflict Declarations

Several genuine structural ambiguities in the MLIR grammar require GLR mode. The declared conflicts are:

| Conflict set | Reason |
|---|---|
| `[region, dictionary_attribute]` | Both begin with `{`; context resolves which |
| `[custom_op_body]` | Two-path body is self-conflicting by design |
| `[custom_operation]` | Op name (`op_id`) overlaps with prefix tokens |
| `[custom_op_body, custom_op_full_prefix]` | Dynamic precedence resolves `dictionary_attribute` vs `safe_prefix_only` path |
| `[op_id, attr_key]` | Both are dotted `bare_id` sequences; context (op position vs attr entry) resolves which |
| `[custom_op_full_prefix, custom_op_safe_prefix]` | Shared token types across both prefix classes |
| `[type_alias, dialect_type]` | Both begin with `!`; resolved by presence of angle body |
| `[attribute_alias, dialect_attribute]` | Both begin with `#`; resolved by presence of angle body |
| `[type, non_function_type]` | `non_function_type` is a strict subset of `type` |
| `[function_type]` | `->` / `into` separator overlaps with `return_type_annotation` in op bodies |
| `[dialect_type]` | Optional `angle_body` creates local ambiguity |
| `[caret_successor, custom_op_full_prefix, custom_op_safe_prefix]` | Caret IDs are valid in both prefix and successor position |
| `[custom_op_kv_brackets, custom_op_full_prefix]` | Both begin with `bare_id` |

### `key: [...]` Syntax

Several dialects (e.g. `memref.reinterpret_cast`) use a `key: [values]` format for named offset/size/stride lists. This is handled with a dedicated `custom_op_kv_brackets` rule (`bare_id ':' custom_brackets`) rather than admitting `':'` as a bare token in the prefix list. Admitting a bare `':'` token would allow GLR to maintain a "`:` as prefix" parse path in parallel with "`:` as type annotation terminal," causing the error-recovery path to span across operation boundaries and produce cascading parse failures.

## License

MIT — see [LICENSE](LICENSE).
