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


local g = {}
for r in io.lines() do
  table.insert(g, r)
end

local dirs = {{-1, 0}, {-1, 1}, {0, 1}, {1, 1}, {1, 0}, {1, -1}, {0, -1}, {-1, -1}}

-- check if a symbol adjacent to the given position
local function ch(y, x)
  for _, dir in pairs(dirs) do
    local dy, dx = table.unpack(dir)
    local ny, nx = y + dy, x + dx
    if 1 <= ny and ny <= #g and 1 <= nx and nx <= #g[1] then
      if not isDigit(g[ny][nx]) and g[ny][nx] ~= "." then
        return true
      end
    end
  end
  return false
end

local res = 0
for y = 1, #g do
  local x = 1
  while x <= #g[y] do
    local n = 0
    local p = false
    local z = x
    while z <= #g[y] and isDigit(g[y][z]) do
      n = n * 10
      n = n + tonumber(g[y][z])
      p = p or ch(y, z)
      z = z + 1
    end
    if p then res = res + n end
    x = x == z and x + 1 or z
  end
end

print(res)  -- 550934

