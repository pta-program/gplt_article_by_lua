-- L3-010 是否完全二叉搜索树
-- 实现原理：按题目的反向 BST 规则（左大右小）逐个插入。层序遍历输出节点，
-- 同时在首次遇到空孩子后检查是否还存在非空节点，以判断完全二叉树性质。

local n = io.read("*n")
local root = nil
local function insert(node, value)
    if not node then return { value = value } end
    if value > node.value then node.left = insert(node.left, value) else node.right = insert(node.right, value) end
    return node
end
for _ = 1, n do root = insert(root, io.read("*n")) end
local queue, head, order, seenNil, complete = { root }, 1, {}, false, true
while head <= #queue do
    local node = queue[head]; head = head + 1
    if node then
        if seenNil then complete = false end
        order[#order + 1] = node.value
        queue[#queue + 1], queue[#queue + 1] = node.left, node.right
    else
        seenNil = true
    end
end
print(table.concat(order, " "))
print(complete and "YES" or "NO")
