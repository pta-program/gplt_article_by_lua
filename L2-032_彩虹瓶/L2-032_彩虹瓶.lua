-- L2-032 彩虹瓶
-- 实现原理：临时货架满足后进先出，直接模拟栈顶是否正好是下一待装颜色。
-- 货架超过容量或最终不能按 1..N 取完时，该发货序列不可行。

local n, limit, k = io.read("*n"), io.read("*n"), io.read("*n")
for _ = 1, k do
    local order = {}
    for i = 1, n do order[i] = io.read("*n") end
    local stack, need, ok = {}, 1, true
    for _, color in ipairs(order) do
        if color == need then
            need = need + 1
            while #stack > 0 and stack[#stack] == need do stack[#stack] = nil; need = need + 1 end
        elseif #stack >= limit then
            ok = false
        else
            stack[#stack + 1] = color
        end
    end
    while #stack > 0 and stack[#stack] == need do stack[#stack] = nil; need = need + 1 end
    print(ok and need == n + 1 and "YES" or "NO")
end
