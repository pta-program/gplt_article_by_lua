-- 实现原理：令 S=A+B，依题意依次输出 S-16、S-3、S-1、S。
local a, b = io.read("*l"):match("(-?%d+)%s+(-?%d+)")
local sum = tonumber(a) + tonumber(b)
print(sum - 16)
print(sum - 3)
print(sum - 1)
print(sum)
