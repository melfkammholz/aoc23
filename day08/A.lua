local dirs = io.read()
io.read()

local adj = {}
for line in io.lines() do
  local a, l, r = line:match("(%a+) = .(%a+), (%a+).")
  adj[a] = {l, r}
end

local lr = {L = 0, R = 1}

local i = 0
local curr = "AAA"
while curr ~= "ZZZ" do
  i = i + 1
  local k = (i - 1) % string.len(dirs) + 1
  curr = adj[curr][lr[dirs:sub(k, k)] + 1]
end
print(i)

