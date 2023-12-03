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

local function isDigit(s)
  return string.byte("0") <= s:byte(1) and s:byte(1) <= string.byte("9")
end



local Tuple = {}

function Tuple:new(t)
  setmetatable(t, self)
  self.__index = self
  return t
end

function Tuple:__eq(other)
  assert(#self == #other)
  for i = 1, #self do
    if self[i] ~= other[i] then return false end
  end
  return true
end

function Tuple:__lt(other)
  assert(#self == #other)
  for i = 1, #self do
    if self[i] < other[i] then
      return true
    elseif self[i] > other[i] then
      return false
    end
  end
  return false
end



local function lowerbound(t, v)
  local l, r = 1, #t
  while l < r do
    local m = l + (r - l) // 2
    if t[m] < v then
      l = m + 1
    else
      r = m
    end
  end

  if l <= #t then return l end
end

-- get all unique values in t
local function uniq(t)
  local u = {}
  local i = 1
  while i <= #t do
    table.insert(u, t[i])
    while i <= #t and u[#u] == t[i] do
      i = i + 1
    end
  end
  return u
end



local g = {}
for r in io.lines() do
  table.insert(g, r)
end

local dirs = {{-1, 0}, {-1, 1}, {0, 1}, {1, 1}, {1, 0}, {1, -1}, {0, -1}, {-1, -1}}

local m = {}

for y = 1, #g do
  local x = 1
  while x <= #g[y] do
    if isDigit(g[y][x]) then
      -- parse part number starting at position x in line y
      local n = 0
      local z = x
      while z <= #g[y] and isDigit(g[y][z]) do
        n = n * 10
        n = n + tonumber(g[y][z])
        z = z + 1
      end

      -- remember parsed number for each digit
      while x < z do
        table.insert(m, Tuple:new {y, x, z, n})
        x = x + 1
      end
    else
      x = x + 1
    end
  end
end

-- make m binary searchable
table.sort(m)

local res = 0
for y = 1, #g do
  for x = 1, #g[y] do
    if g[y][x] == "*" then
      -- find part numbers adjacent to gear
      local s = {}
      for _, dir in pairs(dirs) do
        local dy, dx = table.unpack(dir)
        local ny, nx = y + dy, x + dx
        local k = lowerbound(m, Tuple:new {ny, nx, nx, 0})
        if k and m[k][1] == ny and m[k][2] == nx then
          local _, _, z, n = table.unpack(m[k])
          table.insert(s, Tuple:new {ny, z, n})
        end
      end

      -- add gear ratios
      table.sort(s)
      local su = uniq(s)
      if #su == 2 then
        local f = 1
        for _, p in pairs(su) do
          local _, _, n = table.unpack(p)
          f = f * n
        end
        res = res + f
      end
    end
  end
end

print(res)  -- 81997870

