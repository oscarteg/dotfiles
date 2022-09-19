" Vim compiler file
" Compiler:	Typescript with Bun Compiler
" Maintainer:	Oscar te Giffel <oscar@tegiffel.com>
" Last Change:	2022 Sep 19

if exists("current_compiler")
  finish
endif
let current_compiler = "bun"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo&vim

" CompilerSet makeprg=bun

CompilerSet makeprg=bun
CompilerSet errorformat=%f\ %#(%l\\,%c):\ %trror\ TS%n:\ %m,
		       \%trror\ TS%n:\ %m,
		       \%-G%.%#

let &cpo = s:cpo_save
unlet s:cpo_save
