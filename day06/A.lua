local t = {}
local d = {}
for a in io.read():gmatch("%d+") do
  table.insert(t, tonumber(a))
end
for a in io.read():gmatch("%d+") do
  table.insert(d, tonumber(a))
end

local res = 1
for i = 1, #t do
  local c = 0
  for j = 1, t[i] do
    if d[i] < (t[i] - j) * j then
      c = c + 1
    end
  end
  res = res * c
end
print(res)

