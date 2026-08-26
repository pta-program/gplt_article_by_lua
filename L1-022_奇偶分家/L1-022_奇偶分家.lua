-- 实现原理：遍历输入数列，按模 2 的结果分别计数。
local n = tonumber(io.read("*l"))
local odd = 0
for value in io.read("*l"):gmatch("%d+") do
    if tonumber(value) % 2 == 1 then odd = odd + 1 end
end
print(odd .. " " .. (n - odd))
