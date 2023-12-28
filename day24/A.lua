local lb = 200000000000000
local ub = 400000000000000

local hs = {}
for r in io.lines() do
  local px, py, pz, vx, vy, vz =
    r:match("(-?%d+),[ ]*(-?%d+),[ ]*(-?%d+)[ ]*@[ ]*(-?%d+),[ ]*(-?%d+),[ ]*(-?%d+)")
  px = tonumber(px)
  py = tonumber(py)
  pz = tonumber(pz)
  vx = tonumber(vx)
  vy = tonumber(vy)
  vz = tonumber(vz)
  hs[#hs + 1] = {px = px, py = py, pz = pz, vx = vx, vy = vy, vz = vz}
end

local function det2(a1, a2)
  return a1[1] * a2[2] - a1[2] * a2[1]
end

local function int(i, j)
  local vi = {hs[i].vx, hs[i].vy}
  local vj = {-hs[j].vx, -hs[j].vy}
  local y = {hs[j].px - hs[i].px, hs[j].py - hs[i].py}
  local d = det2(vi, vj)
  if d == 0 then
    return false
  else
    local s1 = det2(y, vj) / d
    local s2 = det2(vi, y) / d
    if s1 > 0 and s2 > 0 then
      local cx = hs[i].px + s1 * hs[i].vx
      local cy = hs[i].py + s1 * hs[i].vy
      return lb <= cx and cx <= ub and lb <= cy and cy <= ub
    end
  end
end

local res = 0
for i = 1, #hs do
  for j = i + 1, #hs do
    if int(i, j) then res = res + 1 end
  end
end
print(res)

