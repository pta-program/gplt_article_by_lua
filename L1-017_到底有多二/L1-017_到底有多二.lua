-- 实现原理：按字符串统计数字 2 的个数，随后根据负数与偶数条件乘以对应系数。
local s = io.read("*l")
local negative = s:sub(1, 1) == "-"
local digits = negative and s:sub(2) or s
local count = select(2, digits:gsub("2", ""))
local ratio = count / #digits * 100
if negative then ratio = ratio * 1.5 end
if tonumber(digits:sub(-1)) % 2 == 0 then ratio = ratio * 2 end
print(string.format("%.2f%%", ratio))
