" Vim compiler file
" Compiler:	Docker-compose
" Maintainer:	Oscar te Giffel <oscar@tegiffel.com>
" Last Change:	2022 Nov 16

if exists("current_compiler")
  finish
endif
let current_compiler = "docker-compose"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo&vim

" CompilerSet makeprg=docker-compose

CompilerSet makeprg=docker-compose\ %
CompilerSet errorformat=%f\ %#(%l\\,%c):\ %trror\ TS%n:\ %m,
		       \%trror\ TS%n:\ %m,
		       \%-G%.%#

let &cpo = s:cpo_save
unlet s:cpo_save
