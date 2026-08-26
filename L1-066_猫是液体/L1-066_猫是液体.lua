-- 实现原理：长方体体积等于长、宽、高三条边长的乘积。
local a, b, c = io.read("*l"):match("(%d+)%s+(%d+)%s+(%d+)")
print(tonumber(a) * tonumber(b) * tonumber(c))
