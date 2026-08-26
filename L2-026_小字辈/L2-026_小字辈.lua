-- L2-026 小字辈
-- 实现原理：由父/母编号反建孩子邻接表，从祖先进行层序遍历。
-- 队列中的深度就是辈分，遍历结束时深度最大的所有节点即为小字辈。

local n = io.read("*n")
local children, root = {}, nil
for i = 1, n do
    local p = io.read("*n")
    if p == -1 then root = i else
        children[p] = children[p] or {}
        children[p][#children[p] + 1] = i
    end
end
local queue, head, maxDepth, youngest = { { root, 1 } }, 1, 0, {}
while head <= #queue do
    local x, depth = queue[head][1], queue[head][2]
    head = head + 1
    if depth > maxDepth then maxDepth, youngest = depth, { x }
    elseif depth == maxDepth then youngest[#youngest + 1] = x end
    for _, child in ipairs(children[x] or {}) do queue[#queue + 1] = { child, depth + 1 } end
end
table.sort(youngest)
print(maxDepth)
print(table.concat(youngest, " "))
