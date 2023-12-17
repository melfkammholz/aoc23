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

function M.tocharlist(s)
  local l = {}
  for i = 1, #s do
    l[i] = s[i]
  end
  return l
end

-- Table functions

function M.tget(t, k, de)
  for i = 1, #k do
    if t[k[i]] then
      t = t[k[i]]
    else
      return de
    end
  end
  return t
end

function M.tset(t, k, v)
  for i = 1, #k - 1 do
    if not t[k[i]] then t[k[i]] = {} end
    t = t[k[i]]
  end

  t[k[#k]] = v
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

local heap = {}

function heap:new(cmp)
  local h = {cmp = cmp, size = 0}
  setmetatable(h, self)
  self.__index = self
  return h
end

function heap:push(val)
  self[self.size + 1] = val
  self.size = self.size + 1
  self:heapifyUp(self.size)
end

function heap:pop()
  local val = self[1]
  self[1] = self[self.size]
  self.size = self.size - 1
  self:heapifyDown(1)
  return val
end

function heap:heapifyUp(n)
  while n // 2 ~= 0 and not self.cmp(self[n // 2], self[n]) do
    self[n // 2], self[n] = self[n], self[n // 2]
    n = n // 2
  end
end

function heap:heapifyDown(n)
  while true do
    local k = n
    if 2 * n + 1 <= self.size and not self.cmp(self[k], self[2 * n + 1]) then
      k = 2 * n + 1
    end
    if 2 * n <= self.size and not self.cmp(self[k], self[2 * n]) then
      k = 2 * n
    end
    if n == k then break end
    self[n], self[k] = self[k], self[n]
    n = k
  end
end

M.heap = heap

return M
