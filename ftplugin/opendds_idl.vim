" Get vim to see the '@' and the annotation names as a single word for certain
" purposes.
setlocal iskeyword+=@-@

" Copied from Vim's ftplugin/c.vim to make comments easier to deal with:

" Set 'comments' to format dashed lists in comments.
setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://

" Set 'formatoptions' to break comment lines but not other lines,
" and insert the comment leader when hitting <CR> or using "o".
setlocal fo-=t fo+=croql
