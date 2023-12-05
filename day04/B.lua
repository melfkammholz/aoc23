local defaulttable = {}
function defaulttable:new (f, t)
  t = t or {}
  setmetatable(t, {self, __index = f})
  return t
end

local m = defaulttable:new(function () return 1 end, {[0] = 0})
local d = defaulttable:new(function () return 0 end)

local k = 0
local e = 0
for line in io.lines() do
  local win, got
  k, win, got = line:match("Card[ ]+(%d+): ([^|]+) | (.*)")
  k = tonumber(k)
  local wcs = {}
  for c in win:gmatch('%d+') do
    wcs[tonumber(c)] = true
  end

  local p = 0
  for c in got:gmatch('%d+') do
    p = p + (wcs[tonumber(c)] and 1 or 0)
  end

  -- accumulate extra cards in e, discard previously accounted for extra cards
  -- when (k + p)-th card has been reached
  e = e + d[k]
  if p > 0 then
    d[k + p] = d[k + p] - m[k]
    e = e + m[k]
  end
  m[k] = m[k] + m[k - 1]  -- prefix sum
  m[k + 1] = m[k + 1] + e
end

print(m[k])  -- 9496801

