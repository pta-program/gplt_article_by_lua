-- 实现原理：BMI 等于体重除以身高平方，超过 25 时判为 PANG。
local weight, height = io.read("*l"):match("([%d.]+)%s+([%d.]+)")
local bmi = tonumber(weight) / tonumber(height) ^ 2
print(string.format("%.1f", bmi))
print(bmi > 25 and "PANG" or "Hai Xing")
