-- 实现原理：每天培育 v 微克拉，不足一天不计，结果为 N 整除 v。
local n, v = io.read("*l"):match("(%d+)%s+(%d+)")
print(tonumber(n) // tonumber(v))
