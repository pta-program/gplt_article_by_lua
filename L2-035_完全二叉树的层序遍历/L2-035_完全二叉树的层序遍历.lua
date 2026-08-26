-- L2-035 完全二叉树的层序遍历
-- 实现原理：完全二叉树可用层序数组表示，i 的左右孩子为 2i、2i+1。
-- 后序序列逆向为“根、右、左”，递归填入数组即可直接得到层序结果。

local n = io.read("*n")
local post, tree = {}, {}
for i = 1, n do post[i] = io.read("*n") end
local pos = n
local function fill(i)
    if i > n then return end
    tree[i] = post[pos]
    pos = pos - 1
    fill(i * 2 + 1)
    fill(i * 2)
end
fill(1)
print(table.concat(tree, " "))
