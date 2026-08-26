-- L3-011 直捣黄龙
-- 实现原理：Dijkstra 以距离为第一关键字；同距离时依次优先经过城市数更多、
-- 歼敌数更多的路径。记录前驱即可重建唯一最优进攻路线。

local function split(s) local t={} for w in s:gmatch("%S+") do t[#t+1]=w end return t end
local function readLine() local l=io.read("*l") while l and l:match("^%s*$") do l=io.read("*l") end return l end

local first = readLine()
if not first then return end
local parts = split(first)
while #parts < 4 do
    local nxt = io.read("*l")
    if not nxt then break end
    for w in nxt:gmatch("%S+") do parts[#parts+1]=w end
end
local n, m = tonumber(parts[1]), tonumber(parts[2])
local sourceName, targetName = parts[3], parts[4]
local id, names, enemy, nextId = {}, {}, {}, 1
local function getId(name)
    if not id[name] then id[name], names[nextId], nextId = nextId, name, nextId + 1 end
    return id[name]
end
local source, target = getId(sourceName), getId(targetName)
for _ = 1, n - 1 do
    local line = readLine()
    if not line then break end
    local w = split(line)
    -- 城镇名可能含空格？取第一个为名，最后一个为数量
    local name, count = w[1], tonumber(w[#w])
    -- 若名称含空格需拼接除最后一个外的部分
    if #w > 2 then
        name = table.concat(w, " ", 1, #w - 1)
    end
    enemy[getId(name)] = count
end
enemy[source] = 0; enemy[target] = enemy[target] or 0
local graph = {}; for i = 1, n do graph[i] = {} end
for _ = 1, m do
    local line = readLine()
    if not line then break end
    local w = split(line)
    if #w >= 3 then
        local aName, bName, d
        if #w == 3 then aName, bName, d = w[1], w[2], tonumber(w[3])
        else
            -- 处理城镇名含空格的极端情况：最后为距离，前两个为城镇名，其余忽略
            d = tonumber(w[#w])
            aName = w[1]
            bName = w[2]
            -- 若城镇名为3字母假设不会有空格，直接取前两列
        end
        local a, b = getId(aName), getId(bName)
        -- 无向图：双向建边（题目道路为无向）
        if graph[a] and graph[b] then
            graph[a][#graph[a] + 1] = { b, d }; graph[b][#graph[b] + 1] = { a, d }
        end
    end
end
local dist, cities, kills, prev, used = {}, {}, {}, {}, {}
for i = 1, n do dist[i], cities[i], kills[i] = math.huge, -1, -1 end
dist[source], cities[source], kills[source] = 0, 0, 0
for _ = 1, n do
    local u = nil
    for i = 1, n do
        if not used[i] and (not u or dist[i] < dist[u] or (dist[i] == dist[u] and (cities[i] > cities[u]
            or (cities[i] == cities[u] and kills[i] > kills[u])))) then u = i end
    end
    if not u or dist[u] == math.huge then break end
    used[u] = true
    for _, edge in ipairs(graph[u]) do
        local v, d = edge[1], edge[2]
        local nd, nc, nk = dist[u] + d, cities[u] + 1, kills[u] + enemy[v]
        if nd < dist[v] or (nd == dist[v] and (nc > cities[v] or (nc == cities[v] and nk > kills[v]))) then
            dist[v], cities[v], kills[v], prev[v] = nd, nc, nk, u
        end
    end
end
local path, x = {}, target
while x do table.insert(path, 1, names[x]); x = prev[x] end
print(table.concat(path, "->"))
print(cities[target] .. " " .. dist[target] .. " " .. kills[target])
