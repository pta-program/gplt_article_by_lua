-- L2-039 清点代码库
-- 实现原理：将同一组 M 个输出编码为一个字符串键并计数，等价键即功能相同。
-- 输出时按出现次数降序、数值序列字典序升序排序。

local n, m = io.read("*n"), io.read("*n")
local groups = {}
for _ = 1, n do
    local values, key = {}, {}
    for i = 1, m do values[i] = io.read("*n"); key[i] = values[i] end
    key = table.concat(key, ",")
    if not groups[key] then groups[key] = { count = 0, values = values } end
    groups[key].count = groups[key].count + 1
end
local result = {}
for _, group in pairs(groups) do result[#result + 1] = group end
table.sort(result, function(a, b)
    if a.count ~= b.count then return a.count > b.count end
    for i = 1, m do
        if a.values[i] ~= b.values[i] then return a.values[i] < b.values[i] end
    end
    return false
end)
print(#result)
for _, group in ipairs(result) do
    local out = { group.count }
    for _, value in ipairs(group.values) do out[#out + 1] = value end
    print(table.concat(out, " "))
end
