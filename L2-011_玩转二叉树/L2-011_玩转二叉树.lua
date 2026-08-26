-- L2-011 玩转二叉树
-- 实现原理：前序序列首元素为根，在中序序列中定位根即可划分左右子树。
-- 递归建树时直接交换左右孩子，最后对镜像树进行层序遍历。

local n = io.read("*n")
local inorder, preorder = {}, {}
for i = 1, n do inorder[i] = io.read("*n") end
for i = 1, n do preorder[i] = io.read("*n") end

local pos = {}
for i = 1, n do pos[inorder[i]] = i end
local preIndex = 1

local function build(left, right)
    if left > right then return nil end
    local value = preorder[preIndex]
    preIndex = preIndex + 1
    local mid = pos[value]
    -- 先构造原树的左、右子树，再反向保存，便得到镜像树。
    local originalLeft = build(left, mid - 1)
    local originalRight = build(mid + 1, right)
    return { value = value, left = originalRight, right = originalLeft }
end

local root = build(1, n)
local queue, head, answer = { root }, 1, {}
while head <= #queue do
    local node = queue[head]
    head = head + 1
    answer[#answer + 1] = node.value
    if node.left then queue[#queue + 1] = node.left end
    if node.right then queue[#queue + 1] = node.right end
end
print(table.concat(answer, " "))
