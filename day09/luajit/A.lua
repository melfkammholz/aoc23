local ffi = require("ffi")
ffi.cdef("int solve(int *a, int n);")
local lib = ffi.load("./libextrap.so")

local function extrap(a)
  local ca = ffi.new("int[?]", #a, a)
  return lib.solve(ca, #a)
end

local res = 0
for line in io.lines() do
  local as = {}
  for a in line:gmatch("-?%d+") do
    table.insert(as, tonumber(a))
  end

  res = res + extrap(as)
end
print(res)  -- 1901217887
