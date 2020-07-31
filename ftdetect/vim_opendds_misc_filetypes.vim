augroup vim_opendds_misc_filetypes
  autocmd!

  " *.ypp are yacc files
  autocmd BufNewFile,BufRead *.ypp setf yacc

  " *.ll are lex files
  autocmd BufNewFile,BufRead *.ll setf lex

  " *.GNU are make files
  autocmd BufNewFile,BufRead *.GNU setf make
augroup END
