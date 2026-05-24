; Fold regions (function bodies, module bodies, etc.)
(region) @fold

; Fold dictionary attributes (can be large inline attribute dicts)
(dictionary_attribute) @fold

; Fold angle-bracket bodies (dialect types/attrs, strided_layout, sparse, etc.)
(angle_body) @fold

; Fold dense literals — dense<> uses bare <> tokens, not angle_body
(dense_attribute) @fold
