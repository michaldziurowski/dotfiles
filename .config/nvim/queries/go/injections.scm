; extends

;this is injection for something like this
;
;html := /* html */ `
;   <html>
;     <body>
;       <a href="smtn"></a>
;     </body>
;   </html>
;   `

(short_var_declaration
  (comment) @injection.language (#offset! @injection.language 0 3 0 -3)
  right: (expression_list
          (raw_string_literal
            (raw_string_literal_content) @injection.content
            )
          )
	)

; at this moment I don't exactly remember what is this for, probably for params of methods named html
(call_expression
  function: (identifier) @fName (#eq? @fName "html")
  arguments: (argument_list
                  (raw_string_literal) @injection.content
                  (#offset! @injection.content 0 1 0 -1)
                  (#set! injection.language "html")
                  )
  )

