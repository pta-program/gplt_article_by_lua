-- 实现原理：标准体重（市斤）为 (身高 - 100) * 0.9 * 2，按一位小数输出。
local height = tonumber(io.read("*l"))
print(string.format("%.1f", (height - 100) * 1.8))
