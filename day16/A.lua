local util = require("util")
local tset = util.tset
local tget = util.tget

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
  if y < 1 or y > #g then return false end
  return 1 <= x and x <= #g[y]
end

local function solve(sy, sx, sd)
  local q = {{sy, sx, sd}}
  local qs = 1
  local seen = {}
  tset(seen, {sy, sx, sd}, true)
  while qs <= #q do
    local y, x, d = table.unpack(q[qs])
    qs = qs + 1
    for i = 1, #refl[g[y][x]][d] do
      local dy, dx = table.unpack(refl[g[y][x]][d][i])
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
        if f then
          c = c + 1
        end
      end
      if c > 0 then
        res = res + 1
      end
    end
  end
  return res
end

print(solve(1, 1, 1))  -- 7623

