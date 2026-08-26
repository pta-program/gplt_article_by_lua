-- L3-022 地铁一日游
--
-- 实现原理：先 Floyd 求任意两站间的计费距离。一次乘车的落点只由出发站
-- 决定：同一票价中保留距离最远的站，所有线路端点也可作为落点。以这些
-- 落点建有向图，再从每个询问起点做可达性搜索即可模拟任意次出站、再上车。

local N, M, K = io.read("*n", "*n", "*n")
local inf = math.huge
local dis, terminal = {}, {}
for i = 1, N do
    dis[i], terminal[i] = {}, false
    for j = 1, N do dis[i][j] = (i == j) and 0 or inf end
end

-- 数值方式读取后，先丢弃当前行余下部分；每条线路本身必须按行读取。
io.read("*l")
for _ = 1, M do
    local line = io.read("*l")
    while line ~= nil and line:match("^%s*$") do line = io.read("*l") end
    local a = {}
    for v in line:gmatch("%-?%d+") do a[#a + 1] = tonumber(v) end
    terminal[a[1]], terminal[a[#a]] = true, true
    for p = 1, #a - 2, 2 do
        local u, w, v = a[p], a[p + 1], a[p + 2]
        if w < dis[u][v] then dis[u][v], dis[v][u] = w, w end
    end
end

for mid = 1, N do
    for i = 1, N do
        if dis[i][mid] < inf then
            for j = 1, N do
                local nd = dis[i][mid] + dis[mid][j]
                if nd < dis[i][j] then dis[i][j] = nd end
            end
        end
    end
end

local next_stop = {}
for s = 1, N do
    next_stop[s] = {}
    local farthest = {}
    for t = 1, N do
        if dis[s][t] < inf then
            local fare = 2 + math.floor(dis[s][t] / K)
            if farthest[fare] == nil or dis[s][t] > farthest[fare] then
                farthest[fare] = dis[s][t]
            end
        end
    end
    for t = 1, N do
        if dis[s][t] < inf then
            local fare = 2 + math.floor(dis[s][t] / K)
            if terminal[t] or dis[s][t] == farthest[fare] then next_stop[s][t] = true end
        end
    end
end

local Q = io.read("*n")
for _ = 1, Q do
    local start = io.read("*n")
    local seen, queue, head, tail = {}, { start }, 1, 1
    seen[start] = true
    while head <= tail do
        local u = queue[head]; head = head + 1
        for v in pairs(next_stop[u]) do
            if not seen[v] then
                seen[v] = true; tail = tail + 1; queue[tail] = v
            end
        end
    end
    local out = {}
    for i = 1, N do if seen[i] then out[#out + 1] = i end end
    print(table.concat(out, " "))
end
