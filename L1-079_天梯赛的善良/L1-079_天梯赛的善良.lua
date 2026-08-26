-- 实现原理：一次遍历维护最小值、最大值及它们各自的出现次数。
local _ = io.read("*l")
local minimum, maximum, min_count, max_count = math.huge, -math.huge, 0, 0
for token in io.read("*l"):gmatch("%d+") do
    local value = tonumber(token)
    if value < minimum then minimum, min_count = value, 1 elseif value == minimum then min_count = min_count + 1 end
    if value > maximum then maximum, max_count = value, 1 elseif value == maximum then max_count = max_count + 1 end
end
print(minimum .. " " .. min_count)
print(maximum .. " " .. max_count)
