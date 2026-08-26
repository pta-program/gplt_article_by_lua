-- 实现原理：顺序枚举 [A, B]，每行累积 5 个右对齐数字，同时累加总和。
local line = io.read("*l")
local a, b = line:match("(-?%d+)%s+(-?%d+)")
a, b = tonumber(a), tonumber(b)
local sum = 0
for value = a, b do
    io.write(string.format("%5d", value))
    if (value - a + 1) % 5 == 0 or value == b then io.write("\n") end
    sum = sum + value
end
print("Sum = " .. sum)
