local util = require("util")
local unp = table.unpack
local get = util.tget
local set = util.tset

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
local nogo = {}
set(nogo, {-1, 0}, '^')
set(nogo, {0, 1}, '>')
set(nogo, {1, 0}, 'v')
set(nogo, {0, -1}, '<')

local seen = {}
local t = {}
set(t, {sy, sx}, 0)
local function dfs(v)
  local y, x = unp(v)
  set(seen, v, true)
  for _, d in pairs(dirs) do
    local dy, dx = unp(d)
    local ny, nx = y + dy, x + dx
    if ny < 1 or ny > #g or nx < 1 or nx > #g[ny] then
      goto continue
    end
    if g[ny][nx] == "#" or get(seen, {ny, nx}, false) then
      goto continue
    end

    if g[ny][nx]:match("[%^>v<]") and get(nogo, d) ~= g[ny][nx] then
      goto continue
    end

    if get(t, {y, x}) + 1 >= get(t, {ny, nx}, 0) then
      set(t, {ny, nx}, get(t, {y, x}) + 1)
      dfs({ny, nx})
    end

    ::continue::
  end
  set(seen, v, false)
end

dfs({sy, sx})
print(get(t, {ey, ex}))

