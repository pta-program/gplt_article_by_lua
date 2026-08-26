-- L2-038 病毒溯源
-- 实现原理：这是一棵有根树。递归求每个节点到叶子的最长链长度，
-- 并在长度并列时优先选择编号更小的孩子，即得到字典序最小的最长链。

local n = io.read("*n")
local children, indegree = {}, {}
for i = 0, n - 1 do
    local k = io.read("*n")
    children[i] = {}
    for j = 1, k do
        local x = io.read("*n")
        children[i][j] = x
        indegree[x] = true
    end
    table.sort(children[i])
end
local root
for i = 0, n - 1 do if not indegree[i] then root = i; break end end
local function longest(x)
    local bestLength, bestPath = 1, { x }
    for _, child in ipairs(children[x]) do
        local length, path = longest(child)
        if length + 1 > bestLength then
            bestLength, bestPath = length + 1, { x }
            for _, v in ipairs(path) do bestPath[#bestPath + 1] = v end
        end
    end
    return bestLength, bestPath
end
local length, path = longest(root)
print(length)
print(table.concat(path, " "))
