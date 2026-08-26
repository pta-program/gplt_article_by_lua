-- L3-007 天梯地图
-- 实现原理：分别运行两次 Dijkstra。按时间优化时以“时间、距离”为关键字，
-- 按距离优化时以“距离、经过节点数”为关键字，从而满足两个不同的破同权规则。

local n, m = io.read("*n"), io.read("*n")
local graph = {}
for i = 0, n - 1 do graph[i] = {} end
for _ = 1, m do
    local a, b, one, len, time = io.read("*n"), io.read("*n"), io.read("*n"), io.read("*n"), io.read("*n")
    graph[a][#graph[a] + 1] = { b, len, time }
    if one == 0 then graph[b][#graph[b] + 1] = { a, len, time } end
end
local start, target = io.read("*n"), io.read("*n")
local function shortest(byTime)
    local primary, secondary, nodes, prev, used = {}, {}, {}, {}, {}
    for i = 0, n - 1 do primary[i], secondary[i], nodes[i] = math.huge, math.huge, math.huge end
    primary[start], secondary[start], nodes[start] = 0, 0, 1
    for _ = 1, n do
        local u = nil
        for i = 0, n - 1 do
            if not used[i] and (not u or primary[i] < primary[u]
                or (primary[i] == primary[u] and secondary[i] < secondary[u])) then u = i end
        end
        if not u or primary[u] == math.huge then break end
        used[u] = true
        for _, edge in ipairs(graph[u]) do
            local v, len, time = edge[1], edge[2], edge[3]
            local p, s = byTime and primary[u] + time or primary[u] + len,
                byTime and secondary[u] + len or nodes[u] + 1
            if p < primary[v] or (p == primary[v] and s < secondary[v]) then
                primary[v], secondary[v], prev[v] = p, s, u
                if not byTime then nodes[v] = s end
            end
        end
    end
    local path, x = {}, target
    while x ~= nil do table.insert(path, 1, x); x = prev[x] end
    return primary[target], (byTime and secondary[target] or nil), path
end
local time, timeDistance, timePath = shortest(true)
local distance, _, distancePath = shortest(false)
local function route(path) return table.concat(path, " => ") end
if #timePath == #distancePath then
    local same = true
    for i = 1, #timePath do if timePath[i] ~= distancePath[i] then same = false; break end end
    if same then print("Time = " .. time .. "; Distance = " .. distance .. ": " .. route(timePath)); return end
end
print("Time = " .. time .. ": " .. route(timePath))
print("Distance = " .. distance .. ": " .. route(distancePath))
