-- 实现原理：将六位号码的前三位和后三位分别累加并比较。
local n = tonumber(io.read("*l"))
for _ = 1, n do
    local ticket = io.read("*l")
    local left, right = 0, 0
    for i = 1, 3 do left = left + tonumber(ticket:sub(i, i)) end
    for i = 4, 6 do right = right + tonumber(ticket:sub(i, i)) end
    print(left == right and "You are lucky!" or "Wish you good luck.")
end
