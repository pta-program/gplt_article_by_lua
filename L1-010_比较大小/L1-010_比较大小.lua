-- 实现原理：读入三个整数后用 table.sort 升序排序，再用 -> 连接输出。
local values = {}
for number in io.read("*l"):gmatch("-?%d+") do values[#values + 1] = tonumber(number) end
table.sort(values)
print(table.concat(values, "->"))
