local util = require("util")
local uniq = util.uniq
local copy = util.deepcopy

local mix, miy, miz, max, may, maz
  = math.maxinteger, math.maxinteger, math.maxinteger,
    math.mininteger, math.mininteger, math.mininteger

local bs = {}

for line in io.lines() do
  local x1, y1, z1, x2, y2, z2 =
    line:match("(%d+),(%d+),(%d+)~(%d+),(%d+),(%d+)")
  x1 = tonumber(x1)
  y1 = tonumber(y1)
  z1 = tonumber(z1)
  x2 = tonumber(x2)
  y2 = tonumber(y2)
  z2 = tonumber(z2)

  assert(x1 <= x2)
  assert(y1 <= y2)
  assert(z1 <= z2)

  mix = math.min(mix, x1)
  miy = math.min(miy, y1)
  miz = math.min(miz, z1)
  max = math.max(max, x2)
  may = math.max(may, y2)
  maz = math.max(maz, z2)
  bs[#bs + 1] = {#bs + 1, {x1, y1, z1}, {x2, y2, z2}}
end
table.sort(bs, function(a, b) return a[2][3] < b[2][3] end)

local g = {}
local h = {}
for y = miy, may do
  for x = mix, max do
    if not g[y] then g[y] = {} end
    if not h[y] then h[y] = {} end
    g[y][x] = 0
    h[y][x] = 0
  end
end

local adj1, adj2 = {}, {}

for j = 1, #bs do
  local mah = 0
  for x = bs[j][2][1], bs[j][3][1] do
    local y = bs[j][2][2]
    mah = math.max(mah, h[y][x])
  end
  for y = bs[j][2][2], bs[j][3][2] do
    local x = bs[j][2][1]
    mah = math.max(mah, h[y][x])
  end

  for x = bs[j][2][1], bs[j][3][1] do
    local y = bs[j][2][2]
    if g[y][x] ~= bs[j][1] then
      if h[y][x] == mah then
        if not adj2[g[y][x]] then adj2[g[y][x]] = {} end
        if not adj1[bs[j][1]] then adj1[bs[j][1]] = {} end
        adj2[g[y][x]][#adj2[g[y][x]] + 1] = bs[j][1]
        adj1[bs[j][1]][#adj1[bs[j][1]] + 1] = g[y][x]
      end
      h[y][x] = mah + bs[j][3][3] - bs[j][2][3] + 1
      g[y][x] = bs[j][1]
    end
  end
  for y = bs[j][2][2], bs[j][3][2] do
    local x = bs[j][2][1]
    if g[y][x] ~= bs[j][1] then
      if h[y][x] == mah then
        if not adj2[g[y][x]] then adj2[g[y][x]] = {} end
        if not adj1[bs[j][1]] then adj1[bs[j][1]] = {} end
        adj2[g[y][x]][#adj2[g[y][x]] + 1] = bs[j][1]
        adj1[bs[j][1]][#adj1[bs[j][1]] + 1] = g[y][x]
      end
      h[y][x] = mah + bs[j][3][3] - bs[j][2][3] + 1
      g[y][x] = bs[j][1]
    end
  end
end
for v = 1, #bs do
  if adj1[v] then
    table.sort(adj1[v])
    uniq(adj1[v])
  end
  if adj2[v] then
    table.sort(adj2[v])
    uniq(adj2[v])
  end
end

local crit = setmetatable({}, {__index = function() return false end})
for v = 1, #bs do
  if #adj1[v] == 1 and adj1[v][1] ~= 0 then
    crit[adj1[v][1]] = true
  end
end

local indeg = setmetatable({}, {__index = function() return 0 end})
for _, l in pairs(adj2) do
  for _, w in pairs(l) do
    indeg[w] = indeg[w] + 1
  end
end

local res = 0
for v = 1, #bs do
  if crit[v] then
    local _indeg = copy(indeg)
    local q = {v}
    for _, w in ipairs(q) do
      for _, u in pairs(adj2[w] or {}) do
        if _indeg[u] > 1 then
          _indeg[u] = _indeg[u] - 1
        else
          res = res + 1
          q[#q + 1] = u
        end
      end
    end
  end
end
print(res)  -- 58440

