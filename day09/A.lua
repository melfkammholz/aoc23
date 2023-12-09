local res = 0
for line in io.lines() do
  local as = {}
  for a in line:gmatch("[-]?%d+") do
    a = tonumber(a)
    table.insert(as, a)
  end

  for i = 1, #as do
    res = res + as[#as - i + 1]
    for j = 1, #as - i do
      as[j] = as[j + 1] - as[j]
    end
  end
end
print(res)  -- 1901217887
