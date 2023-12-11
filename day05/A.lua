local function cmp(l1, l2)
  assert(#l1 == #l2)
  local n = #l1
  for i = 1, n do
    if l1[i] < l2[i] then
      return true
    elseif l1[i] > l2[i] then
      return false
    end
  end
  return false
end

-- accidently did not save solution for the first part, so I slightly modified
-- my solution for the second part
local as = {}
for a in io.read("l"):gmatch("%d+") do
  a = tonumber(a)
  table.insert(as, {a, a})
end

io.read("l")

while true do
  local map = io.read("l")
  if not map then break end

  -- parse map
  local rs = {}
  while true do
    local line = io.read("l")
    if not line or line == "" then break end
    local ds, ss, r = line:match("(%d+) (%d+) (%d+)")
    ds, ss, r = tonumber(ds), tonumber(ss), tonumber(r)
    table.insert(rs, {ss, r, ds})
  end
  table.sort(rs, cmp)

  local bs = {}
  for i = 1, #as do
    local a, b = table.unpack(as[i])

    for j = 1, #rs do
      local ss, r, ds = table.unpack(rs[j])

      -- handle sub-interval before lower bound of rs[i]
      if a < ss then
        if b < ss then
          table.insert(bs, {a, b})
          break
        else
          table.insert(bs, {a, ss - 1})
          a = ss
        end
      end

      -- a is in rs[i]
      if ss <= a and a < ss + r then
        local d = a - ss
        local s = ds + d
        local e = math.min(ds + b - ss, ds + r - 1)
        table.insert(bs, {s, e})
        a = a + (e - s + 1)
      end

      -- fully processed the original interval [a, b]
      if a > b then break end
    end

    -- anything that is left
    if a <= b then
      table.insert(bs, {a, b})
    end
  end

  as = bs
end

local res = math.maxinteger
for _, a in ipairs(as) do
  res = math.min(res, a[1])
end

print(res)  -- 26273516

