-- L2-036 网红点打卡攻略
-- 实现原理：用邻接矩阵保存道路费用。一个攻略有效当且仅当恰含 N 个不同景点，
-- 每条相邻路段（含家 0 的出发、返回）都存在；同时累计其总费用。

local n, m = io.read("*n"), io.read("*n")
local cost = {}
for _ = 1, m do
    local a, b, c = io.read("*n"), io.read("*n"), io.read("*n")
    cost[a] = cost[a] or {}; cost[b] = cost[b] or {}
    cost[a][b], cost[b][a] = c, c
end
local k, valid, bestIndex, bestCost = io.read("*n"), 0, nil, math.huge
for index = 1, k do
    local len, route = io.read("*n"), {}
    for i = 1, len do route[i] = io.read("*n") end
    local seen, ok, sum = {}, len == n, 0
    for _, x in ipairs(route) do
        if x < 1 or x > n or seen[x] then ok = false end
        seen[x] = true
    end
    local prev = 0
    for i = 1, len + 1 do
        local cur = route[i] or 0
        if not cost[prev] or not cost[prev][cur] then ok = false else sum = sum + cost[prev][cur] end
        prev = cur
    end
    if ok then
        valid = valid + 1
        if sum < bestCost then bestCost, bestIndex = sum, index end
    end
end
print(valid)
print(bestIndex .. " " .. bestCost)
