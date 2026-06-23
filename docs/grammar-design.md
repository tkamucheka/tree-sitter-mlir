# Grammar Design Notes

## Custom Operation Parsing

MLIR's custom operation format is fully open-ended: each dialect defines its own syntax, and the generic textual form provides no delimiter between one operation and the next. The grammar resolves this with a two-path GLR structure:

1. **`with_terminal`** — zero or more prefix tokens followed by a required terminal: a type annotation (`: type`), a region (`{ ... }`), or a block successor (`^bb`). The terminal provides an unambiguous endpoint.
2. **`safe_prefix_only`** — one or more tokens that cannot be mistaken for the start of the next operation's result list or name. This handles ops that emit no type annotation and open no region.

This structure avoids consuming tokens belonging to the following operation while still supporting the wide variety of prefix token types appearing in real-world dialects.

## GLR Conflict Declarations

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

## `key: [...]` Syntax

Several dialects (e.g. `memref.reinterpret_cast`) use a `key: [values]` format for named offset/size/stride lists. This is handled with a dedicated `custom_op_kv_brackets` rule (`bare_id ':' custom_brackets`) rather than admitting `':'` as a bare token in the prefix list. Admitting a bare `':'` token would allow GLR to maintain a "`:` as prefix" parse path in parallel with "`:` as type annotation terminal," causing the error-recovery path to span across operation boundaries and produce cascading parse failures.
