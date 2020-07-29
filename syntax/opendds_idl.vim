" TODO:
"   - Move misc keywords that have more appropriate places
"   - Fix issue with number in middle of id
"   - Highlight preproccessor Strings, Non-local Includes
"   - Highlight interface, struct, union, enum members?
"   - Enable folding
"   - Almost all of these could possibly solved by suppying a real syntax like
"     builtin IDL syntax is doing.

if exists("b:current_syntax")
  finish
endif

" Preprocessor
syntax match opendds_idl_preproc "#.*"

" Comments
syntax keyword opendds_idl_todo contained TODO FIXME XXX
syntax region opendds_idl_comment start="/\*" end="\*/" contains=opendds_idl_todo,@Spell
syntax match opendds_idl_comment "//.*" contains=opendds_idl_todo,@Spell

" Almost all of OMG IDL is case insensitive
syntax case ignore

" Literals
syntax keyword opendds_idl_boolean_literal true false
syntax match opendds_idl_int_literal display "-\?\(0x[a-f0-9]\+\|[0-9]\)"
syntax match opendds_idl_float_literal display
  \ "-\?\([0-9]\+\)\?\.\([0-9]\+\)\?e\?\([+-]\?[0-9]\+\)\?"
syntax match opendds_idl_char_literal display
  \ "L\?'\([^\']\|\\\([ntvbrfa\\?'\"]\|o[0-7]\+\|x[a-f0-9]\+\)\)'"
  \ contains=opendds_idl_escaped_chars
syntax match opendds_idl_escaped_chars contained "\\\([ntvbrfa\\?'\"]\|o[0-7]\+\|x[a-f0-9]\+\)"
syntax region opendds_idl_string_literal start="L\?\"" end="\"" skip="\\\""
  \ contains=@Spell,opendds_idl_escaped_chars

" Whitespace Errors
syntax match opendds_idl_errors display excludenl "\s\+$" " Trailing space
syntax match opendds_idl_errors display "\t" " No tabs
" Odd number of spaces in indents
syntax match opendds_idl_errors display "^\(  \)* \ze[^ ]"
syntax match opendds_idl_errors display "#\(  \)* \ze[^ ]"
syntax match opendds_idl_errors "[^ ]\zs  \+\ze[^ ]" " Superfluous spacing
" Common C++ keywords that don't exist in OMG IDL
syntax keyword opendds_idl_errors int class namespace bool

" Identifiers
syntax match opendds_idl_identifier contained "[a-z][a-z0-9_]*"

" Types
syntax keyword opendds_idl_type
  \ void
  \ unsigned boolean char wchar octet short long
  \ int8 uint8 int16 int32 int64 uint16 uint32 uint64
  \ float double fixed
  \ sequence string wstring map
syntax keyword opendds_idl_structure
  \ @annotation enum union module struct interface
  \ skipwhite nextgroup=opendds_idl_identifier
syntax match opendds_idl_annotation_identifier "@[a-z][a-z0-9_]*"
syntax keyword opendds_idl_storage_class const native in out inout local
syntax keyword opendds_idl_typedef typedef

" Misc keywords
syntax keyword opendds_idl_keyword
  \ abstract any alias attribute bitfield
  \ bitmask bitset case
  \ component connector consumes context
  \ custom default exception emits
  \ eventtype factory finder
  \ getraises home import
  \ manages mirrorport multiple
  \ Object oneway
  \ primarykey private port porttype provides
  \ public publishes raises readonly setraises
  \ supports
  \ switch truncatable typeid
  \ typename typeprefix uses
  \ ValueBase valuetype

" End of Almost all of OMG IDL is case insensitive
syntax case match

highlight default link opendds_idl_preproc PreProc
highlight default link opendds_idl_todo Todo
highlight default link opendds_idl_comment Comment
highlight default link opendds_idl_errors Error
highlight default link opendds_idl_structure Structure
highlight default link opendds_idl_type Type
highlight default link opendds_idl_boolean_literal Boolean
highlight default link opendds_idl_int_literal Number
highlight default link opendds_idl_float_literal Float
highlight default link opendds_idl_char_literal Character
highlight default link opendds_idl_escaped_chars Special
highlight default link opendds_idl_string_literal String
highlight default link opendds_idl_keyword Keyword
highlight default link opendds_idl_identifier Identifier
highlight default link opendds_idl_annotation_identifier Function
highlight default link opendds_idl_storage_class StorageClass
highlight default link opendds_idl_typedef Typedef

let b:current_syntax = "opendds_idl"
