require("util")

local function calc(m, e)
  for sy = 1, #m - 1 do
    local y1 = sy
    local y2 = sy + 1
    local c = 0
    while 1 <= y1 and y2 <= #m do
      for x = 1, #m[sy] do
        c = c + (m[y1][x] == m[y2][x] and 0 or 1)
      end
      y1 = y1 - 1
      y2 = y2 + 1
    end
    if c == e then
      return 100 * sy
    end
  end

  for sx = 1, #m[1] - 1 do
    local x1 = sx
    local x2 = sx + 1
    local c = 0
    while 1 <= x1 and x2 <= #m[1] do
      for y = 1, #m do
        c = c + (m[y][x1] == m[y][x2] and 0 or 1)
      end
      x1 = x1 - 1
      x2 = x2 + 1
    end
    if c == e then
      return sx
    end
  end

  assert(false)
end

local m = {}
local res = 0
for r in io.lines() do
  if r == "" then
    res = res + calc(m, 0)
    m = {}
  else
    m[#m + 1] = r
  end
end
print(res + calc(m, 0))

