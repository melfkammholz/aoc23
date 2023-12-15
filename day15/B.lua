require("util")

local function ha(c, v)
  return 17 * (v + c:byte()) % 256
end

local boxes = {}
local last = setmetatable({}, {__index = function() return 1 end})

for line in io.lines() do
  local box = 0
  local j = 0
  for i = 1, #line do
    if line[i] == "," then
      box = 0
      j = i + 1
    elseif line[i] == "-" then
      for k = 1, last[box] - 1 do
        if boxes[box][k] and boxes[box][k][1] == line:sub(j, i - 1) then
          boxes[box][k] = nil
        end
      end
    elseif i + 1 <= #line and line[i] == "=" then
      if not boxes[box] then boxes[box] = {} end
      for k = 1, last[box] - 1 do
        if boxes[box][k] and boxes[box][k][1] == line:sub(j, i - 1) then
          boxes[box][k][2] = line[i + 1]
          goto continue
        end
      end
      boxes[box][last[box]] = {line:sub(j, i - 1), line[i + 1]}
      last[box] = last[box] + 1
    elseif line[i]:match("[0-9]") then
      goto continue
    elseif line[i]:match("%a") then
      box = ha(line[i], box)
    end
    ::continue::
  end
end

local res = 0
for i, box in pairs(boxes) do
  local k = 1
  for j = 1, last[i] - 1 do
    if box[j] then
      res = res + (i + 1) * k * tonumber(box[j][2])
      k = k + 1
    end
  end
end
print(res)  -- 244461


