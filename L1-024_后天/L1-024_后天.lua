-- 实现原理：星期按 7 天循环，后天对应 (D + 1) % 7 + 1。
local d = tonumber(io.read("*l"))
print(d % 7 + 1)
