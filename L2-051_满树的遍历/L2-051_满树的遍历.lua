-- L2-051 满树的遍历
-- 实现原理：由父编号反建有序孩子表，最大孩子数是树的度；所有非叶节点的
-- 孩子数都等于该度时为满树。用栈按孩子倒序压入即可得到前序遍历。

local n = io.read("*n")
local children, root = {}, nil
for i = 1, n do
    local p = io.read("*n")
    if p == 0 then root = i else children[p] = children[p] or {}; children[p][#children[p] + 1] = i end
end
local degree = 0
for i = 1, n do degree = math.max(degree, #(children[i] or {})) end
local full = true
for i = 1, n do if #(children[i] or {}) > 0 and #(children[i] or {}) ~= degree then full = false end end
local order, stack = {}, { root }
while #stack > 0 do
    local x = stack[#stack]; stack[#stack] = nil; order[#order + 1] = x
    local list = children[x] or {}
    for i = #list, 1, -1 do stack[#stack + 1] = list[i] end
end
print(degree .. (full and " yes" or " no"))
print(table.concat(order, " "))
