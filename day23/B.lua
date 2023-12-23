local inspect = require("inspect")
local util = require("util")
local get = util.tget
local set = util.tset
local unp = table.unpack

local g = {}
for r in io.lines() do
  g[#g + 1] = {}
  for i = 1, #r do
    g[#g][i] = r[i]
  end
end

local sy, sx = 1, 2
local ey, ex = #g, #g[#g] - 1
assert(g[sy][sx] == ".")
assert(g[ey][ex] == ".")

local dirs = {{-1, 0}, {0, 1}, {1, 0}, {0, -1}}

local function ing(v)
  local y, x = unp(v)
  return 1 <= y and y <= #g and 1 <= x and x <= #g[y]
end

-- neighbors iterator
local function neighs(v)
  local i = 1
  local y, x = unp(v)
  return function()
    local ny, nx
    local ok = false
    while i <= #dirs and not ok do
      local dy, dx = unp(dirs[i])
      ny, nx = y + dy, x + dx
      if ing({ny, nx}) and g[ny][nx] ~= "#" then
        ok = true
      end
      i = i + 1
    end
    if ok then
      return ny, nx
    end
  end
end

-- determine if a node is an intersection (node has degree > 2)
local function isint(v)
  local y, x = unp(v)
  if g[y][x] == "#" then return false end
  if y == sy and x == sx then return true end
  if y == ey and x == ex then return true end

  local deg = 0
  for _ in neighs(v) do
    deg = deg + 1
  end
  return deg > 2
end

-- collect all intersections
local ints = {}
for y = 1, #g do
  for x = 1, #g[y] do
    if isint({y, x}) then
      print(y, x)
      ints[#ints + 1] = {y, x}
    end
  end
end

-- determine if two nodes are connected by path without any intersections
local function okpath(v, w)
  local seen = {}
  set(seen, v, true)
  local q = {}
  for ny, nx in neighs(v) do
    assert(not isint({ny, nx}))
    q[#q + 1] = {ny, nx, 1}
    set(seen, {ny, nx}, true)
  end
  for _, u in ipairs(q) do
    local y, x, c = unp(u)
    if isint(u) then
      if y == w[1] and x == w[2] then
        return true, c
      end
    else
      for ny, nx in neighs(u) do
        if not get(seen, {ny, nx}, false) then
          set(seen, {ny, nx}, true)
          q[#q + 1] = {ny, nx, c + 1}
        end
      end
    end
  end
  return false
end

-- build condensed graph
local adj = {}
for i, s in ipairs(ints) do
  for j, d in ipairs(ints) do
    if i < j then
      local ok, c = okpath(s, d)
      if ok then
        print(inspect(s), inspect(d))
        local si = s[1] * #g + s[2]
        local di = d[1] * #g + d[2]
        if not adj[si] then adj[si] = {} end
        if not adj[di] then adj[di] = {} end
        adj[si][#adj[si] + 1] = {di, c}
        adj[di][#adj[di] + 1] = {si, c}
      end
    end
  end
end

-- bruteforce
local res = 0
local seen = {}
local function dfs(v, d)
  seen[v] = true
  if v == ey * #g + ex then
    res = math.max(res, d)
  end
  for _, w in pairs(adj[v]) do
    local u, c = unp(w)
    if not seen[u] then
      dfs(u, d + c)
    end
  end
  seen[v] = false
end
dfs(sy * #g + sx, 0)
print(res)

