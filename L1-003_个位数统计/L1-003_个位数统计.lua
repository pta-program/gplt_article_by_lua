-- 实现原理：将大整数按字符串读取，避免数值范围限制；统计每个字符数字的出现次数。
local s = io.read("*l")
local count = {}
for i = 0, 9 do count[i] = 0 end
for digit in s:gmatch("%d") do
    local value = tonumber(digit)
    count[value] = count[value] + 1
end
for i = 0, 9 do
    if count[i] > 0 then print(i .. ":" .. count[i]) end
end
