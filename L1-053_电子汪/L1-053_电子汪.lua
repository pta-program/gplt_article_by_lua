-- 实现原理：两堆球的总数等于需要连续输出的 Wang! 次数。
local a, b = io.read("*l"):match("(%d+)%s+(%d+)")
print(string.rep("Wang!", tonumber(a) + tonumber(b)))
