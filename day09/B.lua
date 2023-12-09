local res = 0
for line in io.lines() do
  local as = {}
  for a in line:gmatch("[-]?%d+") do
    a = tonumber(a)
    table.insert(as, a)
  end

  for i = 1, #as do
    for j = #as - 1, i, -1 do
      as[j + 1] = as[j + 1] - as[j]
    end
  end

  local b = 0
  for i = #as - 1, 1, -1 do
    b = as[i] - b
  end
  res = res + b
end
print(res)  -- 905

