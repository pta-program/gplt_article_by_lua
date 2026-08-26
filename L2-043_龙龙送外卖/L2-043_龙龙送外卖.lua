-- L2-043 龙龙送外卖
-- 实现原理：已出现地址与根形成一棵最小连通子树。遍历其中每条边通常要
-- 往返一次，唯一路径终点可停在最深地址，故答案为 2*边数-最大深度。

local n, m = io.read("*n"), io.read("*n")
local parent, depth, root = {}, {}, nil
for i = 1, n do
    parent[i] = io.read("*n")
    if parent[i] == -1 then root = i; depth[i] = 0 end
end
local function getDepth(x)
    if depth[x] then return depth[x] end
    depth[x] = getDepth(parent[x]) + 1
    return depth[x]
end
for i = 1, n do getDepth(i) end
local used, edges, maxDepth = { [root] = true }, 0, 0
for _ = 1, m do
    local x = io.read("*n")
    maxDepth = math.max(maxDepth, depth[x])
    while not used[x] do
        used[x] = true
        edges = edges + 1
        x = parent[x]
    end
    print(2 * edges - maxDepth)
end
