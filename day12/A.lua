local lanes = require("lanes").configure()
require("util")

-- read input
local fs, rs = {}, {}
local rep = 1
for r in io.lines() do
  local f, g = r:match("(%S+) (%S+)")
  fs[#fs + 1] = f
  for _ = 1, rep - 1 do
    fs[#fs] = fs[#fs] .. "?" .. f
  end

  local gs = {}
  for n in g:gmatch("%d+") do
    gs[#gs + 1] = tonumber(n)
  end

  rs[#rs + 1] = {}
  for _ = 1, rep do
    for _, n in ipairs(gs) do
      rs[#rs][#rs[#rs] + 1] = n
    end
  end
end

-- all positions where n springs could be placed starting at i
local function places(f, i, n)
  local p = {}
  for j = i, #f - n + 1 do
    -- cannot skip spring
    if j > 1 and f[j - 1] == "#" then break end

    -- check if position is feasible
    local c = 0
    while c < n and f[j + c] ~= "." do c = c + 1 end

    -- group cannot be succeeded by a spring
    if c == n and f[j + n] ~= "#" then p[#p + 1] = j end
  end
  return p
end

-- solve one instance
local function solve(f, r)
  local util = require("util")
  local tset = util.tset

  -- table for memoization
  local dp = {}
  local function sol(i, j)
    -- if a solution is already available then use it
    if dp[i] and dp[i][j] then
      return dp[i][j]
    end

    if j > #r then
      -- check if there is spring that is not part of group
      return (i <= #f and f:sub(i, #f):match('#')) and 0 or 1
    end

    local res = 0
    local ps = places(f, i, r[j])
    for _, p in pairs(ps) do
      res = res + sol(p + r[j] + 1, j + 1)
    end
    tset(dp, {i, j}, res)
    return res
  end
  sol(1, 1)
  return dp[1][1]
end

local total = 0
local res = {}
local _solve = lanes.gen("*", solve)  -- lua parallelization
for i = 1, #fs do
  res[i] = _solve(fs[i], rs[i])
end
for i = 1, #fs do
  total = total + res[i][1]  -- waits for results of i-th thread
end
print(total)  -- 7032

