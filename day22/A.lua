local util = require("util")
local uniq = util.uniq

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

local adj = {}

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
        if not adj[bs[j][1]] then adj[bs[j][1]] = {} end
        adj[bs[j][1]][#adj[bs[j][1]] + 1] = g[y][x]
      end
      h[y][x] = mah + bs[j][3][3] - bs[j][2][3] + 1
      g[y][x] = bs[j][1]
    end
  end
  for y = bs[j][2][2], bs[j][3][2] do
    local x = bs[j][2][1]
    if g[y][x] ~= bs[j][1] then
      if h[y][x] == mah then
        if not adj[bs[j][1]] then adj[bs[j][1]] = {} end
        adj[bs[j][1]][#adj[bs[j][1]] + 1] = g[y][x]
      end
      h[y][x] = mah + bs[j][3][3] - bs[j][2][3] + 1
      g[y][x] = bs[j][1]
    end
  end
end
for v = 1, #bs do
  if adj[v] then
    table.sort(adj[v])
    uniq(adj[v])
  end
end

local crit = setmetatable({}, {__index = function() return false end})
local res = 0
for v = 1, #bs do
  if #adj[v] == 1 and adj[v][1] ~= 0 then
    crit[adj[v][1]] = true
  end
end
for v = 1, #bs do
  res = res + (crit[v] and 1 or 0)
end
print(#bs - res)  -- 393

