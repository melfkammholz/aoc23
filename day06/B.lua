local function fst(a) return a end

local t = tonumber(fst(io.read():gsub("[^%d]", "")))
local d = tonumber(fst(io.read():gsub("[^%d]", "")))

local res = 0
for j = 1, t do
  if d < (t - j) * j then
    res = res + 1
  end
end
print(res)

