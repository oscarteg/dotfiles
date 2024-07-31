if exists("current_compiler")
  finish
endif
let current_compiler = "bun"

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=bun\ run\ %
CompilerSet errorformat=%f:%l:%c:\ %m
