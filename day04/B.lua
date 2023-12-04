local m = {[0] = 0}  -- helps with prefix sums
setmetatable(m, {__index = function() return 1 end})  -- table with default value

local k = 0
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
  for j = 1, p do
    m[k + j] = m[k + j] + m[k]
  end
  m[k] = m[k] + m[k - 1]
end

print(m[k])  -- 9496801

