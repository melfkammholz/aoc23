local stringmt = getmetatable("")

-- adds subscript operator for strings
function stringmt:__index(k)
  if string[k] then
    return string[k]
  end

  k = k < 0 and k + #self + 1 or k
  local c = self:sub(k, k)
  return #c > 0 and c or nil
end

local function any(as, p)
  for k, v in pairs(as) do
    if p(k == "J" and 0 or v) then return true end
  end
  return false
end

local function tolist(t)
  local s = {}
  for k, v in pairs(t) do
    if k ~= "J" then table.insert(s, v) end
  end
  return s
end

local function count(x, t)
  local c = 0
  for i = 1, #t do
    if x == t[i] then c = c + 1 end
  end
  return c
end

local function kind5(s) return any(s, function(n) return n + s.J == 5 end) end
local function kind4(s) return any(s, function(n) return n + s.J == 4 end) end
local function kind3(s) return any(s, function(n) return n + s.J == 3 end) end
local function kind2(s) return any(s, function(n) return n + s.J == 2 end) end
local function full(s)
  local t = tolist(s)
  if count(3, t) == 1 and count(2, t) == 1 then return true end
  if count(3, t) == 1 and s.J >= 1 then return true end
  if count(2, t) == 2 and s.J >= 1 then return true end
  if count(2, t) == 1 and s.J >= 2 then return true end
  if count(2, t) == 0 and s.J >= 3 then return true end
  return false
end

local function pair2(s)
  local c = 0
  for cr, a in pairs(s) do
    if cr ~= "J" then
      if a == 2 then c = c + 1 end
    end
  end

  if c == 0 and (s.J >= 2) then return true end
  if c == 1 and (s.J >= 1) then return true end
  return c == 2 or s.J >= 3
end

local function high() return true end

local ord = {kind5, kind4, full, kind3, pair2, kind2, high}
local cval = {}
for v = 2, 9 do cval[tostring(v)] = v end
cval["T"] = 10
cval["J"] = 1
cval["Q"] = 12
cval["K"] = 13
cval["A"] = 14

local function cmp(a, b)
  local i, j = 1, 1
  while i <= #ord do
    if ord[i](a[1]) then break end
    i = i + 1
  end
  while j <= #ord do
    if ord[j](b[1]) then break end
    j = j + 1
  end

  if i == j then
    for k = 1, #a[3] do
      if cval[a[3][k]] < cval[b[3][k]] then return true end
      if cval[a[3][k]] > cval[b[3][k]] then return false end
    end
    return false
  else
    return i > j
  end
end

local hs = {}
for line in io.lines() do
  local h, v = string.match(line, "(%w+)[ ]*(%d+)")
  local s = {["J"] = 0}
  for i = 1, #h do
    if not s[h[i]] then s[h[i]] = 0 end
    s[h[i]] = s[h[i]] + 1
  end
  table.insert(hs, {s, tonumber(v), h})
end
table.sort(hs, cmp)

local res = 0
for i = 1, #hs do
  local _, v = table.unpack(hs[i])
  res = res + v * i
end
print(res)  -- 252137472

