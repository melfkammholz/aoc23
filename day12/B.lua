require("util")

-- read input
local fs, rs = {}, {}
local rep = 5
for r in io.lines() do
  local f, g = r:match("(%S+) (%S+)")
  fs[#fs + 1] = f
  for _ = 1, rep - 1 do
    fs[#fs] = fs[#fs] .. "?" .. f
  end

  local gs = {}
  for n in g:gmatch("%d+") do
    gs[#gs + 1] = tonumber(n)
  end

  rs[#rs + 1] = {}
  for _ = 1, rep do
    for _, n in ipairs(gs) do
      rs[#rs][#rs[#rs] + 1] = n
    end
  end
end

-- all positions where n springs could be placed starting at i
local function places(f, i, n)
  local p = {}
  local l, r = i, i
  while l <= #f - n + 1 do
    if l > 1 and f[l - 1] == "#" then break end
    while r - l < n and f[r] ~= "." do
      r = r + 1
    end
    if r - l == n and f[r] ~= "#" then
      p[#p + 1] = l
    end
    l = l + 1
    r = math.max(r, l)
  end
  return p
end

-- iterative dp
local function solve(f, r)
  local dp = {[1] = 1}
  for i = 1, #r do
    local newdp = {}
    for j, a in pairs(dp) do
      local ps = places(f, j, r[i])
      for _, k in pairs(ps) do
        newdp[k + r[i] + 1] = (newdp[k + r[i] + 1] or 0) + a
      end
    end
    dp = newdp
  end

  local res = 0
  local l = f:find("[^#]*$")
  for i, a in pairs(dp) do
    if i >= l then
      res = res + a
    end
  end
  return res
end

local res = 0
for i = 1, #fs do
  res = res + solve(fs[i], rs[i])
end
print(res)  -- 1493340882140

