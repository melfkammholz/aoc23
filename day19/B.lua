local util = require("util")
local unp = table.unpack
local copy = util.deepcopy

local wfs = {}
for r in io.lines() do
  if r == "" then
    break
  else
    local wf = {}
    local n1, fs = r:match("(%a+)%{([^%}]+)%}")
    for f in fs:gmatch("[^,]+") do
      if f:match("^%a+$") then
        wf[#wf + 1] = {"x", "<", 4001, f}
      else
        for p, c, m, n2 in f:gmatch("([amsx])([<>=])(%d+):(%a+)") do
          m = tonumber(m)
          wf[#wf + 1] = {p, c, m, n2}
        end
      end
    end
    wfs[n1] = wf
  end
end

local ars = {}
local function dfs(v, r1)
  if v == "A" then
    for _, p in pairs(r1) do
      if p[1] > p[2] then return end
    end
    ars[#ars + 1] = r1
    return
  elseif v == "R" then
    return
  end

  for _, wf in pairs(wfs[v]) do
    local p, c, k, w = unp(wf)
    local r2 = copy(r1)
    if c == "<" then
      r2[p][2] = math.min(r1[p][2], k - 1)
      r1[p][1] = math.max(r1[p][1], k)
    end
    if c == ">" then
      r2[p][1] = math.max(r1[p][1], k + 1)
      r1[p][2] = math.min(r1[p][2], k)
    end
    dfs(w, r2)
  end
end
dfs("in", {x = {1, 4000}, m = {1, 4000}, a = {1, 4000}, s = {1, 4000}})

local res = 0
for _, ar in ipairs(ars) do
  local a = 1
  for _, p in pairs(ar) do
    a = a * (p[2] - p[1] + 1)
  end
  res = res + a
end
print(res)  -- 123331556462603
