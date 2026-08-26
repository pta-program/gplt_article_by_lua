-- 实现原理：每行输出 N 个字符，行数取 N 的一半并按四舍五入取整。
local n, ch = io.read("*l"):match("(%d+)%s+(%S)")
n = tonumber(n)
local rows = math.floor(n / 2 + 0.5)
for _ = 1, rows do print(string.rep(ch, n)) end
