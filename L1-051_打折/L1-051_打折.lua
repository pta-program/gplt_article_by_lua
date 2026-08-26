-- 实现原理：折扣 d 表示原价的 d/10，结果按两位小数格式化。
local price, discount = io.read("*l"):match("(%d+)%s+(%d+)")
print(string.format("%.2f", tonumber(price) * tonumber(discount) / 10))
