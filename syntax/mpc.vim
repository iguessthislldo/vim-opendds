if exists("b:current_syntax")
  finish
endif

" Comments
syntax keyword mpc_todo contained TODO FIXME XXX
syntax match mpc_comment "//.*" contains=mpc_todo,@Spell

syntax region mpc_string_literal start="\"" end="\"" contains=mpc_variable

" Whitespace Errors
syntax match mpc_error display excludenl "\s\+$"
syntax match mpc_error display "\t"
syntax match mpc_error display "^\(  \)* [^ ]"
" syntax match mpc_error "[^ ]  \+[^ ]"

syntax keyword mpc_keyword contained
  \ project workspace
  \ compile_flags
  \ Define_Custom Modify_Custom
  \ exename sharedname staticname buildflags dependent_upon dllout libout
  \ exeout managed no_pch pch_header pch_source postbuild prebuild postclean
  \ recurse version macros libpaths recursive_libpaths includes libs
  \ recursive_includes lit_libs pure_libs after custom_only dynamicflags
  \ staticflags verbatim specific expand conditional requires avoids webapp
  \ dependent_upon generates_source subtype
  \ automatic automatic_in automatic_out command commandflags dependent
  \ dependent_libs inputext keyword libpath output_option output_follows_input
  \ pch_postrule postcommand pre_extension source_pre_extension
  \ inline_pre_extension header_pre_extension template_pre_extension
  \ resource_pre_extension documentation_pre_extension generic_pre_extension
  \ pre_filename source_pre_filename inline_pre_filename header_pre_filename
  \ template_pre_filename resource_pre_filename documentation_pre_filename
  \ generic_pre_filename pre_dirname source_pre_dirname inline_pre_dirname
  \ header_pre_dirname template_pre_dirname resource_pre_dirname
  \ documentation_pre_dirname generic_pre_dirname source_outputext
  \ inline_outputext header_outputext template_outputext resource_outputext
  \ documentation_outputext generic_outputext
  \ feature prop else associate exclude cmdline Release Debug

" Any block like project and worspace and any block inside them except for
" verbatim.
syntax match mpc_block_start
  \ "[A-Za-z0-9_]\+\s*\((!\?[A-Za-z0-9_\*]\+)\s*\)\?\(:\s\+[A-Za-z0-9_\*, ]\+\)\?"
  \ transparent
  \ contains=mpc_setting_name,mpc_break_line
  \ skipwhite nextgroup=mpc_block
syntax region mpc_block start="{" end="}"
  \ contains=mpc_path,mpc_comment,mpc_setting,mpc_block_start,mpc_verbatim

" verbatim block
syntax match mpc_verbatim "verbatim\s*\(([A-Za-z0-9_\*, ]\+)\)\?\s*{"
  \ transparent excludenl skipwhite contained
  \ contains=mpc_setting_name,mpc_break_line,mpc_verbatim_block
" For some reason matchgroup=NONE doesn't work here, so I used matchgroup ALL
" to keep it from highlighting the {}.
syntax region mpc_verbatim_block matchgroup=ALL start="{" matchgroup=ALL end="}"

" Might not actually be a path, but for lines that aren't settings
syntax match mpc_path "[^{}=]\+$" contained contains=mpc_variable,mpc_comment

" name = value
syntax match mpc_setting "[A-Za-z0-9_]\+\s*[+-]\?=" contains=mpc_setting_name,mpc_setting_op nextgroup=mpc_text
syntax match mpc_setting_name "[A-Za-z0-9_\*]\+" contained contains=mpc_keyword skipwhite
syntax match mpc_setting_op "[+-]\?=" contained skipwhite
syntax region mpc_text start="[^{}]" end="$" excludenl contained skipwhite
  \ contains=mpc_variable,mpc_comment,mpc_break_line,mpc_text_template
syntax region mpc_text_template start="<%" end="%>" contained

" Variables
syntax match mpc_variable "\$([A-Za-z0-9_]\+)"
syntax match mpc_variable "\$[A-Za-z0-9_]\+"

syntax match mpc_break_line "\\$" " Continue statment on next line

highlight default link mpc_todo Todo
highlight default link mpc_comment Comment
highlight default link mpc_verbatim_block String
highlight default link mpc_string_literal String
highlight default link mpc_setting_op Operator
highlight default link mpc_setting_name Identifier
highlight default link mpc_text String
highlight default link mpc_path String
highlight default link mpc_error Error
highlight default link mpc_keyword Keyword
highlight default link mpc_variable PreProc
highlight default link mpc_text_template PreProc
highlight default link mpc_break_line Special

let b:current_syntax = "mpc"
