-- 实现原理：相邻数字同奇偶时，将其中较大的字符追加到处理结果。
local function transform(s)
    local result = {}
    for i = 2, #s do
        local previous, current = tonumber(s:sub(i - 1, i - 1)), tonumber(s:sub(i, i))
        if previous % 2 == current % 2 then result[#result + 1] = math.max(previous, current) end
    end
    return table.concat(result)
end
local first, second = transform(io.read("*l")), transform(io.read("*l"))
print(first)
if first ~= second then print(second) end
