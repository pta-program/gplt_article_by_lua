-- 实现原理：每次相乘相邻两项；乘积为两位数时将十位、个位分别追加，直到得到 n 项。
local a, b, n = io.read("*l"):match("(%d+)%s+(%d+)%s+(%d+)")
local sequence = {tonumber(a), tonumber(b)}
n = tonumber(n)
local index = 1
while #sequence < n do
    local product = sequence[index] * sequence[index + 1]
    if product >= 10 then sequence[#sequence + 1] = product // 10 end
    if #sequence < n then sequence[#sequence + 1] = product % 10 end
    index = index + 1
end
local output = {}
for i = 1, n do output[i] = sequence[i] end
print(table.concat(output, " "))
