local function fst(a) return a end

local t = tonumber(fst(io.read():gsub("%D", "")))
local d = tonumber(fst(io.read():gsub("%D", "")))

local res = 0
for j = 1, t do
  res = res + (d < (t - j) * j and 1 or 0)  -- Lua's ternary operator
end
print(res)

