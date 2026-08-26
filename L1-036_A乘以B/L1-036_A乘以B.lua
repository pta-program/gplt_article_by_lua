-- 实现原理：读入两个整数后直接输出它们的乘积。
local a, b = io.read("*l"):match("(-?%d+)%s+(-?%d+)")
print(tonumber(a) * tonumber(b))
