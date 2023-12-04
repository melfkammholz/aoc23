local res = 0

for line in io.lines() do
  local _, win, got = line:match("Card[ ]+(%d+): ([^|]+) | (.*)")
  local wcs = {}
  for c in win:gmatch('%d+') do
    wcs[c] = true
  end

  local p = 0
  for c in got:gmatch('%d+') do
    if wcs[c] then
      if p == 0 then p = 1 else p = p * 2 end
    end
  end
  res = res + p
end

print(res)  -- 27845

