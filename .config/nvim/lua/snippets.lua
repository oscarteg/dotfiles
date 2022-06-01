local ls = require("luasnip")
local s, i, t = ls.s, ls.insert_node, ls.text_node

-- This a choice snippet. You can move through with <c-l> (in my config)
--   c(1, { t {"hello"}, t {"world"}, }),
--
-- The first argument is the jump position
-- The second argument is a table of possible nodes.
--  Note, one thing that's nice is you don't have to include
--  the jump position for nodes that normally require one (can be nil)
local c = ls.choice_node

-- Function Node
--  Takes a function that returns text
local f = ls.function_node

require("luasnip.loaders.from_vscode").lazy_load()

