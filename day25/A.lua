local inspect = require("inspect")
local unp = table.unpack

local DSU = {}

function DSU:new(n)
  local a = {groups = n}
  for v = 1, n do
    a[v] = -1
  end

  setmetatable(a, self)
  self.__index = self
  return a
end

function DSU:merge(a, b)
  local pa = self:find(a)
  local pb = self:find(b)
  if pa == pb then return pa end
  if math.abs(self[pa]) < math.abs(self[pb]) then
    pa, pb = pb, pa
  end
  self[pa] = self[pa] + self[pb]
  self[pb] = pa
  self.groups = self.groups - 1
  return pa
end

function DSU:find(a)
  local b = a
  while self[b] > 0 do
    b = self[b]
  end
  while self[a] > 0 do
    a, self[a] = self[a], b
  end
  return b
end

local id = 1
local vs = {}
local es = {}
for r in io.lines() do
  local a, bs = r:match("(%w+): ([%w, ]+)")
  for b in bs:gmatch("%w+") do
    if not vs[a] then
      vs[a] = id
      id = id + 1
    end
    if not vs[b] then
      vs[b] = id
      id = id + 1
    end
    es[#es + 1] = {vs[a], vs[b]}
    table.sort(es[#es])
  end
end

local function shuf(t)
  for i = 1, #t - 1 do
    local j = math.random(i + 1, #t)
    t[i], t[j] = t[j], t[i]
  end
end

-- 77      426
-- 328     641
-- 959     1157
local d
repeat
  shuf(es)
  d = DSU:new(id - 1)
  for _, e in pairs(es) do
    local a, b = unp(e)
    if d.groups > 2 then
      d:merge(a, b)
    end
  end
until d.groups > 2

local res = 1
for i = 1, #d do
  if d[i] < 0 then
    res = res * math.abs(d[i])
  end
end
print(res)  -- 514786
