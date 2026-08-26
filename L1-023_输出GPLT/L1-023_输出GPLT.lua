-- 实现原理：统计 G、P、L、T（忽略大小写）的数量，再循环按 GPLT 顺序尽量输出。
local count = { G = 0, P = 0, L = 0, T = 0 }
for ch in io.read("*l"):upper():gmatch(".") do
    if count[ch] then count[ch] = count[ch] + 1 end
end
local answer, order = {}, {"G", "P", "L", "T"}
while count.G + count.P + count.L + count.T > 0 do
    for _, ch in ipairs(order) do
        if count[ch] > 0 then
            answer[#answer + 1] = ch
            count[ch] = count[ch] - 1
        end
    end
end
print(table.concat(answer))
