-- 实现原理：维护当前阶乘 i!，每轮乘以 i 后加入累计和，避免重复计算阶乘。
local n = tonumber(io.read("*l"))
local factorial, sum = 1, 0
for i = 1, n do
    factorial = factorial * i
    sum = sum + factorial
end
print(sum)
