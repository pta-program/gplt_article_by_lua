-- L3-005 垃圾箱分布
-- 实现原理：分别从每个垃圾箱候选点运行 Dijkstra，取得其到所有居民的最短路。
-- 合法候选按最小距离最大、平均距离最小、编号最小依次比较。

local data = io.read("*a")
if not data or data:match("^%s*$") then return end
local toks = {}
for tok in data:gmatch("%S+") do toks[#toks + 1] = tok end
local pos = 1
local function nextTok() local t = toks[pos]; pos = pos + 1; return t end
local function nextNum() local t = nextTok(); return t and tonumber(t) end

local n, m, k, limit = nextNum(), nextNum(), nextNum(), nextNum()
local total, graph = n + m, {}
for i = 1, total do graph[i] = {} end
local function idOf(s) local x = s:match("G(%d+)"); return x and n + tonumber(x) or tonumber(s) end
for _ = 1, k do
    local a, b, d = idOf(nextTok()), idOf(nextTok()), nextNum()
    graph[a][#graph[a] + 1] = { b, d }; graph[b][#graph[b] + 1] = { a, d }
end
local best = nil
for source = n + 1, n + m do
    local dist, used = {}, {}
    for i = 1, total do dist[i] = math.huge end
    dist[source] = 0
    for _ = 1, total do
        local u = nil
        for i = 1, total do if not used[i] and (not u or dist[i] < dist[u]) then u = i end end
        if not u or dist[u] == math.huge then break end
        used[u] = true
        for _, e in ipairs(graph[u]) do if dist[e[1]] > dist[u] + e[2] then dist[e[1]] = dist[u] + e[2] end end
    end
    local minD, sum, ok = math.huge, 0, true
    for i = 1, n do if dist[i] > limit then ok = false; break end; minD = math.min(minD, dist[i]); sum = sum + dist[i] end
    if ok and (not best or minD > best.minD or (minD == best.minD and sum < best.sum)) then best = { id = source, minD = minD, sum = sum } end
end
if not best then print("No Solution") else print("G" .. (best.id - n)); print(string.format("%.1f %.1f", math.floor(best.minD * 10 + 0.5) / 10, math.floor(best.sum / n * 10 + 0.5) / 10)) end
