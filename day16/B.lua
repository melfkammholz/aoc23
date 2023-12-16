local lanes = require("lanes").configure()
local util = require("util")
local tset = util.tset

local g = {}
for r in io.lines() do
  g[#g + 1] = r
end

local dirs = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
local getdir = {}
for i = 1, #dirs do
  tset(getdir, dirs[i], i)
end

local refl = {
  ["\\"] = {{{1, 0}}, {{0, 1}}, {{-1, 0}}, {{0, -1}}},
  ["/"] = {{{-1, 0}}, {{0, -1}}, {{1, 0}}, {{0, 1}}},
  ["-"] = {{{0, 1}}, {{0, 1}, {0, -1}}, {{0, -1}}, {{0, 1}, {0, -1}}},
  ["|"] = {{{1, 0}, {-1, 0}}, {{1, 0}}, {{1, 0}, {-1, 0}}, {{-1, 0}}},
  ["."] = {{{0, 1}}, {{1, 0}}, {{0, -1}}, {{-1, 0}}}
}

local function inb(y, x)
  return 1 <= y and y <= #g and 1 <= x and x <= #g[y]
end

local function solve(sy, sx, sd)
  local unp = table.unpack
  local util = require("util")
  local tset = util.tset
  local tget = util.tget

  local q = {{sy, sx, sd}}
  local qs = 1
  local seen = {}
  tset(seen, {sy, sx, sd}, true)
  while qs <= #q do
    local y, x, d = unp(q[qs])
    qs = qs + 1
    for i = 1, #refl[g[y][x]][d] do
      local dy, dx = unp(refl[g[y][x]][d][i])
      local next = {y + dy, x + dx, getdir[dy][dx]}
      if not inb(next[1], next[2]) then
        goto continue
      end
      if not tget(seen, next, false) then
        tset(seen, next, true)
        q[#q + 1] = next
      end
      ::continue::
    end
  end

  local res = 0
  for y = 1, #g do
    for x = 1, #g[y] do
      local c = 0
      for i = 1, #dirs do
        local f = tget(seen, {y, x, i}, false)
        c = c + (f and 1 or 0)
      end
      res = res + (c > 0 and 1 or 0)
    end
  end
  return res
end

local _solve = lanes.gen("*", solve)

local mres = 0
for sx = 1, #g[1] do
  local a1 = _solve(1, sx, 1)
  local a2 = _solve(1, sx, 2)
  local a3 = _solve(1, sx, 3)
  local a4 = _solve(1, sx, 4)
  mres = math.max(mres, a1[1], a2[1], a3[1], a4[1])
  a1 = _solve(#g, sx, 1)
  a2 = _solve(#g, sx, 2)
  a3 = _solve(#g, sx, 3)
  a4 = _solve(#g, sx, 4)
  mres = math.max(mres, a1[1], a2[1], a3[1], a4[1])
end
for sy = 1, #g do
  local a1 = _solve(sy, 1, 1)
  local a2 = _solve(sy, 1, 2)
  local a3 = _solve(sy, 1, 3)
  local a4 = _solve(sy, 1, 4)
  mres = math.max(mres, a1[1], a2[1], a3[1], a4[1])
  a1 = _solve(sy, #g[1], 1)
  a2 = _solve(sy, #g[1], 2)
  a3 = _solve(sy, #g[1], 3)
  a4 = _solve(sy, #g[1], 4)
  mres = math.max(mres, a1[1], a2[1], a3[1], a4[1])
end
print(mres)  -- 8244

