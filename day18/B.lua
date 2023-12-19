require("util")
local unp = table.unpack

local ds, ss = {}, {}
for line in io.lines() do
  local s = line:match("[RDLU] %d+ %(#(%x+)%)")
  ds[#ds + 1] = tonumber(s[#s])
  s = tonumber(s:sub(1, #s - 1), 16)
  ss[#ss + 1] = s
end

local dirs = {[0] = {0, 1}, [1] = {1, 0}, [2] = {0, -1}, [3] = {-1, 0}}

local ps = {{0, 0}}
local x, y = 0, 0
for i = 1, #ds do
  local d, s = ds[i], ss[i]
  local dy, dx = unp(dirs[d])
  x = x + s * dx
  y = y + s * dy
  ps[#ps + 1] = {x, y}
end

local a = 0
local b = 1
for i = 1, #ps - 1 do
  -- https://en.wikipedia.org/wiki/Shoelace_formula
  -- https://en.wikipedia.org/wiki/Pick%27s_theorem
  a = a + ps[i][1] * ps[i + 1][2] - ps[i][2] * ps[i + 1][1]
  b = b + math.abs(ps[i][1] - ps[i + 1][1]) + math.abs(ps[i][2] - ps[i + 1][2])
end
print(a // 2 + b // 2 - 1 + 2)  -- 106941819907437
