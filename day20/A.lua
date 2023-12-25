local util = require("util")
local inspect = require("inspect")
local unp = table.unpack
local lcm = util.lcm

local function lcml(a, n)
  local r = 1
  for i = 1, n do
    if not a[i] then return nil end
    r = lcm(r, a[i])
  end
  return r
end

local adj = {}
local indeg = setmetatable({}, {__index = function() return 0 end})
local tys = {}
local ff = {}
local con = {}
for line in io.lines() do
  local ty, from, tos = line:match("([&%%]?)(%a+) %-> (.+)")
  tys[from] = ty
  if ty == "&" then
    con[from] = {high = 0, low = 0}
  end
  for to in tos:gmatch("[^ ,]+") do
    if not adj[from] then adj[from] = {} end
    adj[from][#adj[from] + 1] = to
    indeg[to] = indeg[to] + 1
  end
end
for n, ty in pairs(tys) do
  if ty == "&" then
    con[n].low = indeg[n]
  elseif ty == "%" then
    ff[n] = false
  end
end
for n, l in pairs(adj) do
  for _, m in pairs(l) do
    if tys[m] == "&" then
      con[m][n] = "low"
    end
  end
end

-- mr, kv, jg, rz
local track = {mr = true, kv = true, jg = true, rz = true}
local when = {}
local z = 0

print(inspect(adj))

local cnt = {high = 0, low = 0}
local k = 1
while true do
  local q = {{"broadcaster", "low"}}
  for _, v in ipairs(q) do
    local n, p, m = unp(v)
    if track[n] and not when[n] and p == "low" then
      when[n] = k
      z = z + 1
      if z == 4 then goto res end
    end
    assert(p == "low" or p == "high")
    cnt[p] = cnt[p] + 1
    local s
    if tys[n] == "" then
      assert(n == "broadcaster")
      s = p
    elseif tys[n] == "%" then
      local b = ff[n]
      if p == "low" then
        ff[n] = not ff[n]
      end
      if b ~= ff[n] then
        assert(p == "low")
        s = ff[n] and "high" or "low"
      else
        assert(p == "high")
        goto continue
      end
    elseif tys[n] == "&" then
      if con[n][m] ~= p then
        con[n][m] = p
        con[n][p] = con[n][p] + 1
        local oth = p == "low" and "high" or "low"
        con[n][oth] = con[n][oth] - 1

        assert(con[n][p] <= indeg[n])
        assert(con[n][oth] <= indeg[n])
      end
      s = con[n].high == indeg[n] and "low" or "high"
    end
    for _, w in ipairs(adj[n] or {}) do
      q[#q + 1] = {w, s, n}
    end
    ::continue::
  end
  k = k + 1
end
print(cnt.high * cnt.low)

::res::
print("hi")
print(inspect(when))
print(lcml({when.mr, when.jg, when.rz, when.kv}, 4))

