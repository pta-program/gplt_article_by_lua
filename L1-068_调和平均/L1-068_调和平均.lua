-- 实现原理：调和平均为 N / (1/a1 + 1/a2 + ... + 1/aN)。
local n = tonumber(io.read("*l"))
local reciprocal_sum = 0
for value in io.read("*l"):gmatch("[%d.]+") do reciprocal_sum = reciprocal_sum + 1 / tonumber(value) end
print(string.format("%.2f", n / reciprocal_sum))
