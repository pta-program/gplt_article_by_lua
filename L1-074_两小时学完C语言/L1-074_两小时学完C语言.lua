-- 实现原理：已阅读字数为每分钟阅读量乘阅读分钟数，用总字数减去即可。
local n, k, m = io.read("*l"):match("(%d+)%s+(%d+)%s+(%d+)")
print(tonumber(n) - tonumber(k) * tonumber(m))
