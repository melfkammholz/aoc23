require("util")

local function ha(c, v)
  return 17 * (v + c:byte()) % 256
end

local res = 0
for line in io.lines() do
  local sum = 0
  for i = 1, #line do
    if line[i] == "," then
      res = res + sum
      sum = 0
    else
      sum = ha(line[i], sum)
    end
  end
  res = res + sum
end
print(res)  -- 514025


