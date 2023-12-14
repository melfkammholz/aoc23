local util = require("util")

local g = {}
for r in io.lines() do
  g[#g + 1] = util.tocharlist(r)
end

local function tostr(g)
  local s = ""
  for y = 1, #g do
    for x = 1, #g[y] do
      s = s .. g[y][x]
    end
  end
  return s
end

local function val(g)
  local res = 0
  for y = 1, #g do
    for x = 1, #g[y] do
      if g[y][x] == "O" then
        res = res + #g - y + 1
      end
    end
  end
  return res
end

local function tilt(g, d)
  if d == "n" then
    local b = setmetatable({}, {__index = function() return 0 end})
    for y = 1, #g do
      for x = 1, #g[y] do
        if g[y][x] == "#" then
          b[x] = y
        elseif g[y][x] == "O" then
          g[y][x], g[b[x] + 1][x] = g[b[x] + 1][x], g[y][x]
          b[x] = b[x] + 1
        end
      end
    end
  elseif d == "e" then
    local b = setmetatable({}, {__index = function() return #g[1] + 1 end})
    for y = 1, #g do
      for x = #g[y], 1, -1 do
        if g[y][x] == "#" then
          b[y] = x
        elseif g[y][x] == "O" then
          g[y][x], g[y][b[y] - 1] = g[y][b[y] - 1], g[y][x]
          b[y] = b[y] - 1
        end
      end
    end
  elseif d == "s" then
    local b = setmetatable({}, {__index = function() return #g + 1 end})
    for y = #g, 1, -1 do
      for x = 1, #g[y] do
        if g[y][x] == "#" then
          b[x] = y
        elseif g[y][x] == "O" then
          g[y][x], g[b[x] - 1][x] = g[b[x] - 1][x], g[y][x]
          b[x] = b[x] - 1
        end
      end
    end
  elseif d == "w" then
    local b = setmetatable({}, {__index = function() return 0 end})
    for y = 1, #g do
      for x = 1, #g[y] do
        if g[y][x] == "#" then
          b[y] = x
        elseif g[y][x] == "O" then
          g[y][x], g[y][b[y] + 1] = g[y][b[y] + 1], g[y][x]
          b[y] = b[y] + 1
        end
      end
    end
  end
end

local a = {}
local b = {}
local ds = {"n", "w", "s", "e"}
local i = 1
while true do
  for _, d in ipairs(ds) do
    tilt(g, d)
  end
  local s = tostr(g)
  if a[s] then break end
  b[i] = s
  a[s] = {val(g), i}
  i = i + 1
end

local r = 1000000000

local _, j = table.unpack(a[tostr(g)])
local c, _ = table.unpack(a[b[(r - j) % (i - j) + j]])
print(c)

