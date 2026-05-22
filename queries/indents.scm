; Indent inside regions (curly braces)
(region "{" @indent.begin)
(region "}" @indent.end)

; Indent inside dictionary attributes
(dictionary_attribute "{" @indent.begin)
(dictionary_attribute "}" @indent.end)
