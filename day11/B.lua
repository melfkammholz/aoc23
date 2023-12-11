require("util")

-- read input
local g = {}
for r in io.lines() do
  g[#g + 1] = r
end

local rows, cols = {}, {}

-- compute indices of empty rows
for y = 1, #g do
  local cont = false
  for x = 1, #g[y] do
    cont = cont or g[y][x] == "#"
  end
  if not cont then rows[#rows + 1] = y end
end

-- compute indices of empty cols
for x = 1, #g[1] do
  local cont = false
  for y = 1, #g do
    cont = cont or g[y][x] == "#"
  end
  if not cont then cols[#cols + 1] = x end
end

-- compute positions of galaxies
local pos = {}
for y = 1, #g do
  for x = 1, #g[y] do
    if g[y][x] == "#" then
      pos[#pos + 1] = {y, x}
    end
  end
end

-- count empty rows/cols in range [l, r]
local function inrange(x, l, r)
  local cnt = 0
  if l > r then l, r = r, l end
  -- linear search instead of binary search :)
  for i = 1, #x do
    if l <= x[i] and x[i] <= r then
      cnt = cnt + 1
    end
  end
  return cnt
end

-- compute distances
local res = 0
for i = 1, #pos do
  local y1, x1 = table.unpack(pos[i])
  for j = i + 1, #pos do
    local y2, x2 = table.unpack(pos[j])
    local s1 = inrange(rows, y1, y2)
    local s2 = inrange(cols, x1, x2)
    res = res + math.abs(y2 - y1) + math.abs(x2 - x1)
    res = res + (s1 + s2) * (1000000 - 1)  -- account for double counting -1
  end
end
print(res)  -- 699909023130

