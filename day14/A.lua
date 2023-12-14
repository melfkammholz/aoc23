local util = require("util")

local g = {}
for r in io.lines() do
  g[#g + 1] = util.tocharlist(r)
end

local res = 0
local b = setmetatable({}, {__index = function() return 0 end})
for y = 1, #g do
  for x = 1, #g[y] do
    if g[y][x] == "#" then
      b[x] = y
    elseif g[y][x] == "O" then
      res = res + #g - b[x]
      b[x] = b[x] + 1
    end
  end
end
print(res)

