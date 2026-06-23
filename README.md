# tree-sitter-mlir

A [tree-sitter](https://tree-sitter.github.io/tree-sitter/) grammar for [MLIR](https://mlir.llvm.org/) (Multi-Level Intermediate Representation). The grammar targets the generic MLIR textual format as specified by the [MLIR Language Reference](https://mlir.llvm.org/docs/LangRef/), and handles the extensible custom operation format used by dialect-specific lowerings.

## Motivation

The existing upstream parser works off a rigid list of dialects and their respective grammars. I couldn't help but wonder whether a general parser could be derived from MLIR's EBNF alone — one that handles arbitrary dialects without needing to enumerate them.

I'm a PhD candidate near defending my dissertation at the time of writing, so I had the idea but not the time to execute it properly. I decided to vibe code this entire project with Claude in the spare minutes before bed. I've done some testing, but not enough to give me full confidence. Use accordingly.

## Language Coverage

- **Generic operations** — the `"opname"(args) {attrs} : functype` form
- **Custom operations** — dialect-specific formats with arbitrary prefix tokens, type annotations, regions, and successor blocks
- **Types** — builtin scalar and parametric types (`tensor`, `memref`, `vector`, `complex`, `tuple`), dialect types (`!namespace.name<...>`), type aliases, and function types
- **Attributes** — all builtin attribute kinds (`dense`, `dense_resource`, `sparse`, `opaque`, `strided`, `affine_map`, `affine_set`, array, dictionary), dialect attributes, and attribute aliases
- **SSA values** — `%id`, result lists, block arguments with per-argument type annotations and attribute dicts
- **Regions and blocks** — entry blocks, labeled blocks with argument lists, block successors
- **Symbol references** — `@name` with nested `::` qualification

## Editor Query Files

Six [tree-sitter query](https://tree-sitter.github.io/tree-sitter/using-parsers/queries/) files are provided in `queries/`. See [docs/queries.md](docs/queries.md) for the full capture reference.

| File                  | Purpose                                           |
|-----------------------|---------------------------------------------------|
| `highlights.scm`      | Syntax highlighting — maps nodes to capture names |
| `locals.scm`          | SSA value scoping for rename and go-to-definition |
| `indents.scm`         | Auto-indent hints for region and dict `{}`        |
| `folds.scm`           | Code folding for regions, dicts, and angle bodies |
| `tags.scm`            | Symbol index — function/module definitions and references |
| `textobjects.scm`     | Structural text objects for motion and selection  |

## Installation

### Neovim (nvim-treesitter, Lazy.nvim)

Register the parser inside a `User TSUpdate` autocommand — this is the required hook for custom parsers:

```lua
{
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "TSUpdate",
      callback = function()
        require("nvim-treesitter.parsers").mlir = {
          install_info = {
            url = "https://github.com/tkamucheka/tree-sitter-mlir",
            files = { "src/parser.c" },
            queries = "queries",
            generate = true,
          },
        }
      end,
    })
    require("nvim-treesitter").setup()
  end,
}
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

## Development

Clone the repo and install dependencies:

```sh
git clone https://github.com/tkamucheka/tree-sitter-mlir
cd tree-sitter-mlir
npm install
```

Common workflows:

```sh
# Regenerate parser after editing grammar.js
npx tree-sitter generate

# Parse a file and print the concrete syntax tree
npx tree-sitter parse path/to/file.mlir

# Run the corpus and highlight test suite
npx tree-sitter test

# Interactive playground (requires WebAssembly build)
npm start
```

Corpus tests live in `test/corpus/` and highlight tests in `test/highlight/`. See [docs/grammar-design.md](docs/grammar-design.md) for the grammar's GLR conflict model before making structural changes.

## Grammar Design

The grammar uses GLR mode to handle MLIR's open-ended custom operation syntax and several genuine structural ambiguities. See [docs/grammar-design.md](docs/grammar-design.md) for details on the two-path custom op structure and all declared GLR conflicts.

## Acknowledgments

I would like to acknowledge [artagnon/tree-sitter-mlir](https://github.com/artagnon/tree-sitter-mlir) for their source snippets and test cases used in validating this grammar.

## License

MIT — see [LICENSE](LICENSE).
