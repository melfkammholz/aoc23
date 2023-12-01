local sum = 0

for line in io.lines() do
  -- TODO one match possible?
  local a, b = line:match('(%d).*(%d)')
  if a and b then
    sum = sum + tonumber(a) * 10 + tonumber(b)
  else
    a = line:match('%d')
    sum = sum + tonumber(a) * 10 + tonumber(a)
  end
end

print(sum)  -- 55108

