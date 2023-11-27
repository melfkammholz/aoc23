-- "only globals from the portable intersection of Lua 5.1, Lua 5.2, Lua 5.3
-- and LuaJIT 2.0 are used"
std = "min"

-- "on subsequent checks, only files which have changed since the last check
-- will be rechecked, improving run time significantly."
cache = true

-- only check solutions and meta specifications
include_files = {"day*/*.lua", "*.luacheckrc"}
