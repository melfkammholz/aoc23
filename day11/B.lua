local fun = require("fun")
local util = require("util")

local g = fun.tabulate(function() return io.read("l") end)
  :take_while(fun.operator.truth)
  :map(util.tocharlist)
  :totable()

-- compute indices of empty rows
local rows = fun.range(#g)
  :filter(function(y)
    return not fun.foldl(function(a, x) return a or x == "#" end, false, g[y])
  end)
  :totable()

-- compute indices of empty cols
local cols = fun.range(#g[1])
  :filter(function(x)
    return not fun.range(#g)
      :foldl(function(a, y) return a or g[y][x] == "#" end, false)
  end)
  :totable()

-- compute positions of galaxies
local pos = fun.range(#g):foldl(function(a, y)
  return fun.range(#g[y])
    :map(function(x)
      return g[y][x] == "#" and {y, x} or false
    end)
    :foldl(function(b, p)
      if p then
        b[#b + 1] = p
      end
      return b
    end, a)
end, {})

-- count empty rows/cols in range [l, r]
local function inrange(x, l, r)
  if l > r then l, r = r, l end
  -- linear search instead of binary search :)
  return fun.range(#x)
    :filter(function(i) return l <= x[i] and x[i] <= r end)
    :length()
end

-- compute distances
local res = fun.range(#pos - 1):foldl(function(r1, i)
  local y1, x1 = table.unpack(pos[i])
  return fun.range(i + 1, #pos):foldl(function(r2, j)
    local y2, x2 = table.unpack(pos[j])
    local s1 = inrange(rows, y1, y2)
    local s2 = inrange(cols, x1, x2)
    r2 = r2 + math.abs(y2 - y1) + math.abs(x2 - x1)
    r2 = r2 + (s1 + s2) * (1000000 - 1)  -- account for double counting -1
    return r2
  end, r1)
end, 0)
print(res)  -- 699909023130

