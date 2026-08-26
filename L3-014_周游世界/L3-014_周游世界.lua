-- L3-014 周游世界
-- 实现原理：状态为“当前站点、当前线路”，用优先队列按经过区间数、换乘数
-- 的字典序求最短路。回溯边上的线路编号，再在编号变化处分段输出。

local data = io.read("*a")
if not data or data:match("^%s*$") then return end
local toks = {}
for tok in data:gmatch("%S+") do toks[#toks + 1] = tok end
local pos = 1
local function nextTok() local t = toks[pos]; pos = pos + 1; return t end
local function nextNum() local t = nextTok(); return t and tonumber(t) end

local lines = nextNum()
local graph = {}
for company = 1, lines do
    local count = nextNum()
    local stops = {}
    for i = 1, count do stops[i] = nextTok(); graph[stops[i]] = graph[stops[i]] or {} end
    for i = 1, count - 1 do
        graph[stops[i]][#graph[stops[i]] + 1] = { stops[i + 1], company }
        graph[stops[i + 1]][#graph[stops[i + 1]] + 1] = { stops[i], company }
    end
end
local q = nextNum()
for _ = 1, q do
    local source, target = nextTok(), nextTok()
    if not graph[source] or not graph[target] then print("Sorry, no line is available.") else
        local heap, dist, prev = {}, {}, {}
        local function push(item)
            heap[#heap + 1] = item; local i = #heap
            while i > 1 do local p = math.floor(i / 2); local a, b = heap[i], heap[p]
                if a.hops > b.hops or (a.hops == b.hops and a.trans >= b.trans) then break end
                heap[i], heap[p], i = heap[p], heap[i], p
            end
        end
        local function pop()
            local top, last = heap[1], heap[#heap]; heap[#heap] = nil
            if #heap > 0 then
                heap[1] = last; local i = 1
                while true do local l, r, best = i * 2, i * 2 + 1, i
                    if l <= #heap and (heap[l].hops < heap[best].hops or (heap[l].hops == heap[best].hops and heap[l].trans < heap[best].trans)) then best = l end
                    if r <= #heap and (heap[r].hops < heap[best].hops or (heap[r].hops == heap[best].hops and heap[r].trans < heap[best].trans)) then best = r end
                    if best == i then break end; heap[i], heap[best], i = heap[best], heap[i], best
                end
            end
            return top
        end
        local startKey = source .. "|0"; dist[startKey] = { hops = 0, trans = 0 }; push({ station = source, line = 0, hops = 0, trans = 0, key = startKey })
        local bestKey, bestCost
        while #heap > 0 do
            local cur = pop(); local known = dist[cur.key]
            if known and known.hops == cur.hops and known.trans == cur.trans then
                if cur.station == target then bestKey, bestCost = cur.key, cur; break end
                for _, edge in ipairs(graph[cur.station]) do
                    local ns, line = edge[1], edge[2]
                    local hops, trans = cur.hops + 1, cur.trans + (cur.line ~= 0 and cur.line ~= line and 1 or 0)
                    local key, old = ns .. "|" .. line, dist[ns .. "|" .. line]
                    if not old or hops < old.hops or (hops == old.hops and trans < old.trans) then
                        dist[key] = { hops = hops, trans = trans }
                        prev[key] = { cur.key, cur.station, line }
                        push({ station = ns, line = line, hops = hops, trans = trans, key = key })
                    end
                end
            end
        end
        if not bestKey then print("Sorry, no line is available.") else
            local edges, key = {}, bestKey
            while key ~= startKey do local p = prev[key]; table.insert(edges, 1, { p[2], key:match("^(.-)|"), p[3] }); key = p[1] end
            print(bestCost.hops)
            local beginStation, line = source, edges[1] and edges[1][3]
            for i, edge in ipairs(edges) do
                local nextLine = edges[i + 1] and edges[i + 1][3]
                if nextLine ~= line then print("Go by the line of company #" .. line .. " from " .. beginStation .. " to " .. edge[2] .. "."); beginStation, line = edge[2], nextLine end
            end
        end
    end
end
