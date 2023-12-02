local res = 0

for line in io.lines() do
  -- check maximum draw of each color in a set
  local cnt = {red = 0, green = 0, blue = 0}
  local _, ss = line:match('Game (%d+): (.+)')
  for s in ss:gmatch('([^;]+)') do
    for n, c in s:gmatch('(%d+) ([^,]+)') do
      cnt[c] = math.max(cnt[c], tonumber(n))
    end
  end

  -- add power
  local u = 1
  for _, m in pairs(cnt) do
    u = u * m
  end
  res = res + u
end

print(res)  -- 68638

