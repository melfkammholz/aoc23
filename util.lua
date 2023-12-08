local M = {}

local stringmt = getmetatable("")

-- adds subscript operator for strings
function stringmt:__index(k)
  if string[k] then
    return string[k]
  end

  k = k < 0 and k + #self + 1 or k
  local c = self:sub(k, k)
  return #c > 0 and c or nil
end

function M.tablecmp(l1, l2)
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

function M.gcd(a, b)
  while b ~= 0 do
    a, b = b, a % b
  end
  return a
end

function M.lcm(a, b)
  return a // M.gcd(a, b) * b
end

return M

