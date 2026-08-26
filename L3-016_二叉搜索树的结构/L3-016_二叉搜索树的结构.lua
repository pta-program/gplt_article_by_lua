-- L3-016 二叉搜索树的结构
-- 实现原理：插入时记录每个值的父节点、左右孩子和深度。所有英文断言都可
-- 直接转化为这些记录之间的等式关系，因此每条查询可 O(1) 判断。

local n = io.read("*n")
local root, info = nil, {}
for _ = 1, n do
    local value = io.read("*n")
    if not root then root = value; info[value] = { depth = 0 }
    else
        local cur = root
        while true do
            if value < cur then
                if info[cur].left then cur = info[cur].left else info[cur].left = value; info[value] = { parent = cur, depth = info[cur].depth + 1 }; break end
            else
                if info[cur].right then cur = info[cur].right else info[cur].right = value; info[value] = { parent = cur, depth = info[cur].depth + 1 }; break end
            end
        end
    end
end
io.read("*l")
local q = tonumber(io.read("*l"))
for _ = 1, q do
    local s = io.read("*l")
    local a, b = s:match("^(-?%d+) and (-?%d+) are siblings$")
    local ok
    if a then a, b = tonumber(a), tonumber(b); ok = info[a] and info[b] and info[a].parent and info[a].parent == info[b].parent
    else
        a = s:match("^(-?%d+) is the root$")
        if a then ok = tonumber(a) == root else
            a, b = s:match("^(-?%d+) is the parent of (-?%d+)$")
            if a then a, b = tonumber(a), tonumber(b); ok = info[b] and info[b].parent == a else
                a, b = s:match("^(-?%d+) is the left child of (-?%d+)$")
                if a then a, b = tonumber(a), tonumber(b); ok = info[b] and info[b].left == a else
                    a, b = s:match("^(-?%d+) is the right child of (-?%d+)$")
                    if a then a, b = tonumber(a), tonumber(b); ok = info[b] and info[b].right == a else
                        a, b = s:match("^(-?%d+) and (-?%d+) are on the same level$")
                        a, b = tonumber(a), tonumber(b); ok = info[a] and info[b] and info[a].depth == info[b].depth
                    end
                end
            end
        end
    end
    print(ok and "Yes" or "No")
end
