local M = {}

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

return M

