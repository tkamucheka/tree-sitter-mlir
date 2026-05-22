; Scopes: regions and blocks introduce new SSA scopes
(region) @local.scope
(block) @local.scope

; Definitions: op results define SSA values
(op_result (value_id) @local.definition)

; Definitions: block arguments define SSA values
(value_id_and_type (value_id) @local.definition)

; References: all other value_id occurrences are uses
(value_use (value_id) @local.reference)
