-- L2-031 深入虎穴
-- 实现原理：门和通路构成一棵以唯一入门为根的树。先由入度找到根，
-- 再以迭代 DFS 记录深度，深度最大的门即为目标。

local n = io.read("*n")
local children, indegree = {}, {}
for i = 1, n do
    local k = io.read("*n")
    children[i] = {}
    for j = 1, k do
        local x = io.read("*n")
        children[i][j] = x
        indegree[x] = (indegree[x] or 0) + 1
    end
end
local root
for i = 1, n do if not indegree[i] then root = i; break end end
local stack, farDoor, farDepth = { { root, 0 } }, root, -1
while #stack > 0 do
    local x, depth = stack[#stack][1], stack[#stack][2]
    stack[#stack] = nil
    if depth > farDepth then farDoor, farDepth = x, depth end
    for _, child in ipairs(children[x]) do stack[#stack + 1] = { child, depth + 1 } end
end
print(farDoor)
