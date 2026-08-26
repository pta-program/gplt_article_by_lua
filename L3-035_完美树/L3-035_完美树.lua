-- L3-035 完美树
-- 实现原理：好子树的黑白数量差只能为 -1、0、1。后序 DP 中，记录每个子树
-- 达到这三种差值的最小成本；合并子树时对孩子差值做最小代价卷积，最后加上
-- 当前节点选择黑色(+1)或白色(-1)的翻色代价。

local n = io.read("*n")
local color, price, children = {}, {}, {}
for i = 1, n do
    color[i], price[i], children[i] = io.read("*n"), io.read("*n"), {}
    local k = io.read("*n")
    for j = 1, k do children[i][j] = io.read("*n") end
end
local order, stack = {}, { 1 }
while #stack > 0 do local x = stack[#stack]; stack[#stack] = nil; order[#order + 1] = x; for _, y in ipairs(children[x]) do stack[#stack + 1] = y end end
local dp, inf = {}, 10 ^ 30
for oi = #order, 1, -1 do
    local x, ways = order[oi], { [0] = 0 }
    for ci, child in ipairs(children[x]) do
        local nextWays = {}
        local remaining = #children[x] - ci
        for sum, cost in pairs(ways) do
            for delta, childCost in pairs(dp[child]) do
                local v = sum + delta
                -- 余下孩子每个最多补偿 1，无法回到节点允许范围的状态可丢弃。
                if math.abs(v) <= remaining + 2 and (not nextWays[v] or cost + childCost < nextWays[v]) then nextWays[v] = cost + childCost end
            end
        end
        ways = nextWays
    end
    dp[x] = {}
    for target = -1, 1 do
        local best = inf
        for own, extra in pairs({ [-1] = color[x] == 0 and 0 or price[x], [1] = color[x] == 1 and 0 or price[x] }) do
            local childCost = ways[target - own]
            if childCost and childCost + extra < best then best = childCost + extra end
        end
        if best < inf then dp[x][target] = best end
    end
end
local answer = math.min(dp[1][-1] or inf, dp[1][0] or inf, dp[1][1] or inf)
print(answer)
