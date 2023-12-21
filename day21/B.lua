-- Thanks Reddit!
local util = require("util")
local tget = util.tget
local tset = util.tset
local unp = table.unpack

local s = 26501365

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
local n = #g

local dx = {0, 1, 0, -1}
local dy = {1, 0, -1, 0}

local xys = {}
local q = {{sy, sx}}
local qs = 1
for k = 1, s % n + 2 * n do
  local e = #q
  local inq = {}
  while qs <= e do
    local y, x = unp(q[qs])
    qs = qs + 1
    for i = 1, #dx do
      local ny, nx = y + dy[i], x + dx[i]
      if g[(ny - 1) % n + 1][(nx - 1) % n + 1] == "#" then
        goto continue
      end
      if not tget(inq, {ny, nx}, false) then
        q[#q + 1] = {ny, nx}
        tset(inq, {ny, nx}, true)
      else
      end
      ::continue::
    end
  end
  if k % n == s % n then
    xys[#xys + 1] = {k, #q - qs + 1}
  end
end

-- xys = {{65, 3648}, {196, 32781}, {327, 90972}}

-- polynomial interpolation with lagrange polynomials
local function lag(i, x)
  local r = 1
  for j = 1, #xys do
    if i ~= j then
      r = r * (x - xys[j][1]) / (xys[i][1] - xys[j][1])
    end
  end
  return r
end

local function quad(x)
  return math.floor(
    xys[1][2] * lag(1, x)
    + xys[2][2] * lag(2, x)
    + xys[3][2] * lag(3, x)
    + 0.5
  )
end

print(quad(s))  -- 594606492802848

