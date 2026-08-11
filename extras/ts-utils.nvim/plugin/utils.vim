if exists("g:loaded_utils")
    finish
endif
let g:loaded_utils = 1

let s:lua_rocks_deps_loc = expand("<sfile>:h:r") . "./../lua/utils/deps"
exe "lua package.path = package.path .. ';" . s:lua_rocks_deps_loc . "/lua-?/init.lua'"
