local lim = {red = 12, green = 13, blue = 14}

local res = 0

for line in io.lines() do
  -- check maximum draw of each color in a set
  local cnt = {red = 0, green = 0, blue = 0}
  local id, ss = line:match('Game (%d+): (.+)')
  for s in ss:gmatch('([^;]+)') do
    for n, c in s:gmatch('(%d+) ([^,]+)') do
      cnt[c] = math.max(cnt[c], tonumber(n))
    end
  end

  -- check bounds
  local ok = true
  for c, m in pairs(lim) do
    print(c, cnt[c], m)
    ok = ok and cnt[c] <= m
  end
  if ok then res = res + id end
end

print(res)  -- 2276

