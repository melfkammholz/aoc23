local extrap = require("extrap").solve

local res = 0
for line in io.lines() do
  local as = {}
  for a in line:gmatch("[-]?%d+") do
    table.insert(as, tonumber(a))
  end

  res = res + extrap(as)
end
print(res)  -- 1901217887
