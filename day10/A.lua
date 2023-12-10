local fun = require("fun")

local util = require("util")
local tocharlist = util.tocharlist
local tget = util.tget
local tset = util.tset

-- read input
local g = {}
for r in io.lines() do
  table.insert(g, r)
end
g = fun.map(tocharlist, g):totable()

-- build adjacency lists
local adj = {}

local function inb(y, x)
  if y < 1 or y > #g then return false end
  return 1 <= x and x <= #g[y]
end

local function ins(fy, fx, ty, tx)
  if not inb(ty, tx) then return end
  local adjl = tget(adj, {fy, fx}, {})
  table.insert(adjl, {ty, tx})
  tset(adj, {fy, fx}, adjl)
end

-- start position
local sy, sx

local h = {[-1] = "[-FL]", [1] = "[-7J]"}
local v = {[-1] = "[|F7]", [1] = "[|JL]"}
local s = {
  tr = "L",
  tb = "|",
  tl = "J",
  br = "F",
  bt = "|",
  bl = "7",
  lr = "-",
  rl = "-"
}

for y = 1, #g do
  for x = 1, #g[y] do
    if g[y][x] == "S" then
      -- replace S with appropriate pipe
      local p = {}
      if inb(y + 1, x) and g[y + 1][x]:match(v[1]) then table.insert(p, "b") end
      if inb(y - 1, x) and g[y - 1][x]:match(v[-1]) then table.insert(p, "t") end
      if inb(y, x + 1) and g[y][x + 1]:match(h[1]) then table.insert(p, "r") end
      if inb(y, x - 1) and g[y][x - 1]:match(h[-1]) then table.insert(p, "l") end
      g[y][x] = s[p[1] .. p[2]]
      sy, sx = y, x
    end

    -- hard coded because why not
    -- TODO refactor maybe never
    if g[y][x] == "|" and inb(y - 1, x) and g[y - 1][x]:match(v[-1]) then ins(y, x, y - 1, x) end
    if g[y][x] == "|" and inb(y + 1, x) and g[y + 1][x]:match(v[1]) then ins(y, x, y + 1, x) end
    if g[y][x] == "F" and inb(y + 1, x) and g[y + 1][x]:match(v[1]) then ins(y, x, y + 1, x) end
    if g[y][x] == "F" and inb(y, x + 1) and g[y][x + 1]:match(h[1]) then ins(y, x, y, x + 1) end
    if g[y][x] == "J" and inb(y - 1, x) and g[y - 1][x]:match(v[-1]) then ins(y, x, y - 1, x) end
    if g[y][x] == "J" and inb(y, x - 1) and g[y][x - 1]:match(h[-1]) then ins(y, x, y, x - 1) end
    if g[y][x] == "L" and inb(y - 1, x) and g[y - 1][x]:match(v[-1]) then ins(y, x, y - 1, x) end
    if g[y][x] == "L" and inb(y, x + 1) and g[y][x + 1]:match(h[1]) then ins(y, x, y, x + 1) end
    if g[y][x] == "-" and inb(y, x - 1) and g[y][x - 1]:match(h[-1]) then ins(y, x, y, x - 1) end
    if g[y][x] == "-" and inb(y, x + 1) and g[y][x + 1]:match(h[1]) then ins(y, x, y, x + 1) end
    if g[y][x] == "7" and inb(y + 1, x) and g[y + 1][x]:match(v[1]) then ins(y, x, y + 1, x) end
    if g[y][x] == "7" and inb(y, x - 1) and g[y][x - 1]:match(h[-1]) then ins(y, x, y, x - 1) end
  end
end

local d = {}

local q = {{sy, sx}}
tset(d, {sy, sx}, 0)
local i, j = 1, 1
while i <= j do
  for _, w in pairs(tget(adj, q[i], {})) do
    local cd = tget(d, q[i])
    if cd and cd + 1 < tget(d, w, math.maxinteger) then
      tset(d, w, cd + 1)
      table.insert(q, w)
      j = j + 1
    end
  end
  i = i + 1
end

local res = fun.range(#g):foldl(function(r1, y)
  return math.max(r1, fun.range(#g[y]):foldl(function(r2, x)
    return math.max(r2, tget(d, {y, x}, 0))
  end, 0))
end, 0)

print(res)  -- 6947

