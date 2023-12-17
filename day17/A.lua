local util = require("util")
local tset = util.tset
local tget = util.tget
local unp = table.unpack
local heap = util.heap

local g = {}
for r in io.lines() do
  g[#g + 1] = {}
  for i = 1, #r do
    g[#g][i] = tonumber(r[i])
  end
end

local dirs = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}}

local function inb(y, x)
  return 1 <= y and y <= #g and 1 <= x and x <= #g[y]
end

local q = heap:new(function(a, b) return a[1] < b[1] end)
q:push({0, 1, 1, 1, 0})
q:push({0, 1, 1, 2, 0})
local h = {}
tset(h, {1, 1, 1, 0}, 0)
tset(h, {1, 1, 2, 0}, 0)
while q.size > 0 do
  local _, y, x, d, s = unp(q:pop())
  for i = 1, #dirs do
    if d == i and s == 3 or (d + 2) % #dirs == i then
      goto continue
    end
    local dy, dx = unp(dirs[i])
    local ny, nx = y + dy, x + dx
    if not inb(ny, nx) then
      goto continue
    end

    local ch = tget(h, {y, x, d, s})
    local ns = d == i and (s + 1) or 1
    local nh = tget(h, {ny, nx, i, ns}, math.maxinteger)
    if ch + g[ny][nx] < nh then
      tset(h, {ny, nx, i, ns}, ch + g[ny][nx])
      q:push({ch + g[ny][nx], ny, nx, i, ns})
    end
    ::continue::
  end
end

local res = math.maxinteger
for i = 1, #dirs do
  for j = 1, 3 do
    res = math.min(res, tget(h, {#g, #g[#g], i, j}, math.maxinteger))
  end
end
print(res)  -- 1128
