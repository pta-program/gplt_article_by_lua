-- 实现原理：先求 A+B，再从 1 连乘到该值计算阶乘。
local a, b = io.read("*l"):match("(%d+)%s+(%d+)")
local result = 1
for i = 1, tonumber(a) + tonumber(b) do result = result * i end
print(result)
