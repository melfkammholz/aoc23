local res: integer = 0
for line in io.lines() do
  local as: {integer} = {}
  for a in line:gmatch("[-]?%d+") do
    table.insert(as, tonumber(a))
  end

  for i = 1, #as do
    res = res + as[#as - i + 1]
    for j = 1, #as - i do
      as[j] = as[j + 1] - as[j]
    end
  end
end
print(res)  -- 1901217887
