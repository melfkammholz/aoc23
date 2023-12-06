local t = io.read():gsub("[^%d]", "")
local d = io.read():gsub("[^%d]", "")
t, d = tonumber(t), tonumber(d)

local res = 0
for j = 1, t do
  if d < (t - j) * j then
    res = res + 1
  end
end
print(res)

