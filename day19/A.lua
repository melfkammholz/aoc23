local ps = {}
local wfs = {}
local wfsd = false
for r in io.lines() do
  if r == "" then
    wfsd = true
  elseif wfsd then
    local x, m, a, s = r:match("%{x=(%d+),m=(%d+),a=(%d+),s=(%d+)%}")
    ps[#ps + 1] = {f = "in", x = tonumber(x), m = tonumber(m), a = tonumber(a), s = tonumber(s)}
  else
    local wf = {}
    local n1, fs = r:match("(%a+)%{([^%}]+)%}")
    for f in fs:gmatch("[^,]+") do
      if f:match("^%a+$") then
        wf[#wf + 1] = {function() return true end, f}
      else
        for p, c, m, n2 in f:gmatch("([amsx])([<>=])(%d+):(%a+)") do
          m = tonumber(m)
          if c == "<" then
            wf[#wf + 1] = {function(q) return q[p] < m end, n2}
          elseif c == ">" then
            wf[#wf + 1] = {function(q) return q[p] > m end, n2}
          elseif c == "=" then
            wf[#wf + 1] = {function(q) return q[p] == m end, n2}
          end
        end
      end
    end
    wfs[n1] = wf
  end
end

local as = {}
for _, p in ipairs(ps) do
  while p.f ~= "A" or p.f ~= "R" do
    local i = 1
    while i <= #wfs[p.f] and not wfs[p.f][i][1](p) do
      i = i + 1
    end
    if wfs[p.f][i][1](p) then
      p.f = wfs[p.f][i][2]
      if p.f == "A" then
        as[#as + 1] = p
        goto continue
      elseif p.f == "R" then
        goto continue
      end
    end
  end
  ::continue::
end

local res = 0
for _, a in pairs(as) do
  res = res + a.x + a.m + a.a + a.s
end
print(res)  -- 418498

