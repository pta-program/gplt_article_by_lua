-- 实现原理：直接代入温度转换公式 C = 5 * (F - 32) / 9。
local f = tonumber(io.read("*l"))
local c = 5 * (f - 32) / 9
print("Celsius = " .. c)
