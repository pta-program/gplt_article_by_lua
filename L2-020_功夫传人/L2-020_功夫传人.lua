-- L2-020 功夫传人
-- 实现原理：从祖师爷开始广度优先遍历，队列同时保存传承层数。
-- 到达叶子节点时，将该层功力乘叶子的弟子人数并累加，最后取整数部分。

local n, z, r = io.read("*n"), io.read("*n"), io.read("*n")
local children, leaves = {}, {}
for i = 0, n - 1 do
    local k = io.read("*n")
    if k == 0 then
        leaves[i] = io.read("*n")
    else
        children[i] = {}
        for j = 1, k do children[i][j] = io.read("*n") end
    end
end

local decay = 1 - r / 100
local queue, head, answer = { { 0, 0 } }, 1, 0
while head <= #queue do
    local node, depth = queue[head][1], queue[head][2]
    head = head + 1
    if leaves[node] then
        answer = answer + z * (decay ^ depth) * leaves[node]
    else
        for _, child in ipairs(children[node]) do
            queue[#queue + 1] = { child, depth + 1 }
        end
    end
end
print(math.floor(answer))
