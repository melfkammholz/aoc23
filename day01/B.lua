-- TODO write Tuple class
local function tuplecmp(l1, l2)
  local n = math.min(#l1, #l2)
  for i = 1, n do
    if l1[i] < l2[i] then
      return true
    elseif l1[i] > l2[i] then
      return false
    end
  end
  return #l1 < #l2
end


local nums = {
  'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'
}

local sum = 0

for line in io.lines() do
  local set = {}

  -- check for any digit
  for i = 1, #line do
    local val = tonumber(line:sub(i, i))  -- no subscript operator :'(
    if val then
      table.insert(set, {i, val})
    end
  end

  -- collect all positions of a number
  for val, num in pairs(nums) do
    for i = 1, #line do
      if line:sub(i, math.min(i + #num - 1, #line)) == num then
        table.insert(set, {i, val})
      end
    end
  end
  table.sort(set, tuplecmp)

  sum = sum + set[1][2] * 10 + set[#set][2]
end

print(sum)  -- 56324

