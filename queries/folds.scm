; Fold regions (function bodies, module bodies, etc.)
(region) @fold

; Fold dictionary attributes (can be large inline attribute dicts)
(dictionary_attribute) @fold

; Fold angle-bracket bodies (e.g. dense<...>, tensor<...>)
(angle_body) @fold
