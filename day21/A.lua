local util = require("util")
local tget = util.tget
local tset = util.tset
local unp = table.unpack

local sy, sx = 0, 0
local g = {}
for r in io.lines() do
  g[#g + 1] = {}
  for i = 1, #r do
    g[#g][i] = r:sub(i, i)
    if g[#g][i] == "S" then
      sy, sx = #g, i
      g[#g][i] = "."
    end
  end
end

local dx = {0, 1, 0, -1}
local dy = {1, 0, -1, 0}

local q = {{sy, sx}}
local qs = 1
for _ = 1, 64 do
  local inq = {}
  local e = #q
  while qs <= e do
    local y, x = unp(q[qs])
    qs = qs + 1
    for i = 1, #dx do
      local ny, nx = y + dy[i], x + dx[i]
      if ny < 1 or ny > #g or nx < 1 or nx > #g[ny] then
        goto continue
      end
      if g[ny][nx] == "#" then
        goto continue
      end
      if not tget(inq, {ny, nx}, false) then
        q[#q + 1] = {ny, nx}
        tset(inq, {ny, nx}, true)
      end
      ::continue::
    end
  end
end
print(#q - qs + 1)  -- 3572

