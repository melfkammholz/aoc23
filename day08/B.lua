local function gcd(a, b)
  if b == 0 then return a end
  return gcd(b, a % b)
end

local function lcm(a, b)
  return a * b // gcd(a, b)
end

local function lcml(a, n)
  local r = 1
  for i = 1, n do
    if not a[i] then return nil end
    r = lcm(r, a[i])
  end
  return r
end

local dirs = io.read()
io.read()

local currs = {}
local adj = {}
for line in io.lines() do
  local a, l, r = line:match("(%w+) = .(%w+), (%w+).")
  if a:sub(3, 3) == "A" then table.insert(currs, a) end
  adj[a] = {l, r}
end

local lr = {L = 0, R = 1}

local last = {}
local res
local i = 0
while not res do
  i = i + 1

  -- step
  for j = 1, #currs do
    local k = (i - 1) % string.len(dirs) + 1
    currs[j] = adj[currs[j]][lr[dirs:sub(k, k)] + 1]

    -- assumption over the input
    if currs[j]:sub(3, 3) == "Z" then
      last[j] = i
    end
  end

  res = lcml(last, #currs)
end
print(res)

