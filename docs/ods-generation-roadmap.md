# ODS-Driven Dialect Grammar Roadmap

## Goal

Evolve the parser from a purely general MLIR grammar into a hybrid grammar that
provides precise syntax trees for known upstream dialects without sacrificing
support for unknown, experimental, or downstream dialects.

The parser will remain a single Tree-sitter grammar. Its operation rules will
have three layers, ordered from most specific to most general:

1. Handwritten overrides for assembly syntax that cannot be derived safely.
2. Generated rules for declarative ODS assembly formats.
3. The existing general MLIR rules as an unconditional fallback.

The general grammar is the compatibility contract. Generated dialect rules add
precision; they must never be required to parse otherwise valid MLIR.

## Why ODS Is Useful, but Not Sufficient

MLIR's Operation Definition Specification records operation names, operands,
results, attributes, properties, regions, successors, and, for many operations,
a declarative `assemblyFormat`. After TableGen resolves includes, inheritance,
templates, and substitutions, that information can drive Tree-sitter rule
generation.

ODS cannot describe every accepted token sequence:

- `hasCustomAssemblyFormat` delegates the syntax to handwritten C++.
- `custom<Directive>` delegates part of a declarative format to C++.
- Some attribute and type parsers are handwritten.
- ODS constraints can be semantic rather than syntactic.
- MLIR's generated parsers can enforce context-sensitive conditions that a
  Tree-sitter concrete syntax grammar should not attempt to reproduce.

Consequently, the generator will produce syntax recognition, not an MLIR
verifier, and it will expose explicit escape hatches for unsupported constructs.

## Proposed Architecture

```text
upstream *.td files
        |
        v
resolved TableGen records
        |
        v
ODS extraction backend
        |
        v
normalized syntax IR
        |
        +-------------------+
        |                   |
        v                   v
generated dialect rules   coverage manifest
        |
        v
handwritten overrides
        |
        v
single composed grammar
        |
        v
general MLIR fallback
```

Generated files will be deterministic, checked in, and clearly marked as
generated. They must not be edited manually. Overrides will be keyed by the
fully qualified operation, attribute, or type name.

A likely source layout is:

```text
grammar/
  core.js
  dialects/
    generated/
      arith.js
      func.js
    overrides/
      affine.js
      gpu.js
  compose.js
tools/
  ods/
    extract
    generate
    directives.js
    schema.json
generated/
  ods-coverage.json
```

The final layout should follow what the prototype demonstrates rather than
forcing this structure onto the current grammar prematurely.

## Extraction Strategy

Do not parse `.td` source files directly. Raw source does not expose the final
values produced by TableGen inheritance and substitutions.

Prototype with TableGen's JSON backend because it is easy to inspect and keeps
the first implementation independent of LLVM C++ internals. If the JSON loses
important MLIR-specific structure, replace the extractor with an
`mlir-tblgen` backend using MLIR's `Operator`, attribute, type, and format APIs.

The extractor should record at least:

- Fully qualified operation name and dialect namespace.
- Declarative assembly format, when present.
- Whether the operation uses a custom assembly parser.
- Named operands, results, attributes, properties, regions, and successors.
- Optional and variadic cardinality.
- Attribute and type mnemonics and their assembly formats.
- Custom directives encountered by each format.
- LLVM revision used to produce the data.

The extractor output should be a stable, project-owned intermediate format.
This separates LLVM/TableGen changes from the Tree-sitter generator.

## Normalized Syntax IR

Parse each declarative `assemblyFormat` into a small syntax tree rather than
translating its text directly into JavaScript. The intermediate representation
should include:

- Sequences and alternatives.
- Literal keywords and punctuation.
- Operand, result, region, successor, attribute, and property variables.
- Optional groups, including anchors and else branches.
- Repetition and order-independent lists.
- Type and functional-type directives.
- Attribute and property dictionaries.
- Qualified attributes and types.
- Known and unknown custom directives.

This representation makes the translation testable without regenerating the
Tree-sitter parser and provides a place to normalize constructs that have no
one-to-one Tree-sitter equivalent.

## Rule Generation

The generator will translate the normalized format into reusable Tree-sitter
combinators. For example:

```tablegen
$callee `(` $args `)` attr-dict `:` functional-type($args, results)
```

can produce a rule shaped like:

```javascript
seq(
  field("callee", $.symbol_ref),
  "(",
  optional(commaSep($.value_use)),
  ")",
  optional($.dictionary_attribute),
  ":",
  $.function_type,
)
```

The exact mapping must be derived from both the format element and the ODS
declaration. Variadicity alone does not determine separators; the surrounding
assembly format does.

Generated alternatives must preserve a specificity order:

1. Known operation syntax.
2. Known dialect fallback, if it proves useful during prototyping.
3. General custom operation syntax.
4. Generic quoted operation syntax.

Tree-sitter conflicts and dynamic precedence must be added deliberately and
documented. The generator must not emit broad conflict declarations merely to
make generation succeed.

## Overrides and Custom Directives

Handwritten overrides are a supported part of the design, not generator
failures to hide.

An override may:

- Replace an entire operation rule using its fully qualified name.
- Implement a custom assembly directive shared by multiple operations.
- Refine a generated attribute or type rule.
- Disable a generated rule that causes unacceptable ambiguity or recovery.

Known custom directives should live in a registry mapping directive names to
Tree-sitter combinators. Unknown directives must be reported in the coverage
manifest and use a bounded permissive rule or force the containing operation to
the general fallback. They must never silently generate an allegedly precise
rule.

## Compatibility Requirements

The hybrid grammar must retain these properties:

- Unknown dialects parse at least as well as they do before generation.
- Mixed-dialect files produce one coherent syntax tree.
- Generic quoted operations remain fully supported.
- A failed specialized alternative recovers locally and does not consume the
  following operation.
- Existing query captures remain stable unless a documented migration is
  necessary.
- Generated node names are deterministic across machines.
- Updating LLVM does not require LLVM at parser installation time.

## Testing Strategy

Testing will operate at several levels:

1. **Extractor tests** verify resolved ODS records and revision metadata.
2. **Format parser tests** snapshot the normalized syntax IR.
3. **Generator tests** snapshot deterministic Tree-sitter output.
4. **Dialect corpus tests** cover representative upstream syntax, optional
   groups, variadics, regions, successors, attributes, and types.
5. **Fallback corpus tests** use invented namespaces and operations to prevent
   accidental closed-world assumptions.
6. **Regression tests** compare parse errors and operation boundaries against
   the current general grammar.
7. **Upstream fixture tests** parse selected LLVM MLIR test files at the pinned
   revision, subject to compatible licensing and repository size.

For generated rules, success means useful and stable concrete syntax trees. It
does not mean duplicating MLIR verification or rejecting semantically invalid
programs.

## Coverage Manifest

Each generation run should produce a machine-readable manifest and a concise
human summary. Track each construct as one of:

- `generated`: fully derived from a declarative format.
- `generated-with-directives`: generated using known directive handlers.
- `override`: implemented manually.
- `fallback`: handled by the general grammar.
- `unsupported`: currently produces unacceptable parsing and blocks a release.

Example:

```text
arith: 41 generated, 2 generated-with-directives, 0 overrides, 0 unsupported
affine: 12 generated, 4 generated-with-directives, 3 overrides, 0 unsupported
```

Coverage numbers should always name the LLVM revision. They describe syntactic
handling, not semantic correctness.

## Roadmap

### Phase 0: Establish the Baseline

- Pin an LLVM revision for the first prototype.
- Record current corpus results and parse-error counts.
- Add fallback cases using invented dialects, attributes, and types.
- Identify node names and query captures that form the compatibility surface.

**Exit criterion:** the current grammar has a reproducible baseline against
which generated rules can be compared.

### Phase 1: Prove ODS Extraction

- Select one small declarative dialect, initially `arith` or `func`.
- Resolve its records using the TableGen JSON backend.
- Emit the project-owned intermediate representation.
- Inventory declarative formats, handwritten formats, and custom directives.
- Decide whether JSON is sufficient or a native `mlir-tblgen` backend is
  required.

**Exit criterion:** every operation in the pilot dialect is classified and the
extractor output is deterministic.

### Phase 2: Parse Declarative Formats

- Implement the normalized syntax IR.
- Parse literals, variables, directives, optional groups, and else groups.
- Add support for `oilist`, type directives, dictionaries, and qualification.
- Produce actionable diagnostics for unhandled syntax.

**Exit criterion:** all declarative formats in the pilot dialect normalize
without silently discarding information.

### Phase 3: Generate the First Dialect

- Translate normalized formats into Tree-sitter combinators.
- Compose generated rules with the current general grammar.
- Add corpus tests derived from upstream examples and tests.
- Compare operation boundaries, error nodes, and query captures with baseline.

**Exit criterion:** the pilot dialect gains more precise trees while all
general fallback tests remain unchanged or improve.

### Phase 4: Design the Escape Hatches

- Implement the custom-directive registry.
- Define whole-operation and attribute/type overrides.
- Add explicit fallback behavior for unknown directives.
- Generate the first coverage manifest.

**Exit criterion:** no opaque syntax is falsely reported as generated, and one
operation requiring C++ syntax is handled cleanly by override or fallback.

### Phase 5: Expand Upstream Coverage

- Add `builtin`, `func`, `arith`, `memref`, `scf`, and `affine` incrementally.
- Add larger or more specialized dialects only after measuring grammar size,
  generation time, parse time, ambiguity, and recovery quality.
- Keep each dialect change reviewable through generated diffs and corpus tests.

**Exit criterion:** a representative mixed-dialect upstream corpus parses with
no regression in unknown-dialect handling and acceptable parser size and speed.

### Phase 6: Automate Updates

- Add a pinned LLVM revision file.
- Provide one command to extract, generate, format, and report coverage.
- Add CI checks that generated files are current and deterministic.
- Document the LLVM update and override-review process.

**Exit criterion:** a contributor can update the pinned LLVM revision and
receive an auditable diff of syntax additions, removals, and new escape hatches.

### Phase 7: Stabilize the Public Grammar

- Review generated node names and query behavior across supported editors.
- Document support levels: structural fallback, dialect-aware, and
  operation-complete.
- Publish performance and coverage data for the pinned LLVM revision.
- Define the compatibility policy for generated node changes.

**Exit criterion:** the hybrid grammar is ready to replace the general-only
implementation on the default branch.

## Non-Goals

- Reimplementing MLIR semantic verification in Tree-sitter.
- Requiring LLVM or TableGen when installing the parser.
- Claiming complete support merely because an ODS record was discovered.
- Removing the general custom-operation fallback.
- Parsing handwritten C++ to infer assembly syntax.
- Updating automatically to LLVM `main` without review and corpus validation.

## Initial Questions to Answer

The prototype should answer these before broad implementation:

1. Does TableGen JSON preserve enough structure to identify all relevant ODS
   entities, or is a native backend immediately necessary?
2. What percentage of a pilot dialect is purely declarative?
3. Which custom directives recur across dialects and deserve shared handlers?
4. How much does dialect generation increase parser size and generation time?
5. Do specialized rules improve trees without worsening operation-boundary
   recovery?
6. Can generated nodes preserve the existing query capture contract?
7. Is a known-dialect fallback useful, or is the global general fallback
   sufficient?

The result of Phase 1 should refine this roadmap before the grammar is
restructured.
