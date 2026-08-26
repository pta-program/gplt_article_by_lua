-- L3-008 喊山
-- 实现原理：声音在无权无向图中逐边传递，BFS 的层数就是传播距离。
-- 对每个询问选最大层中编号最小的山头；若没有其他可达山头则输出 0。

local n, m, k = io.read("*n"), io.read("*n"), io.read("*n")
local graph = {}
for i = 1, n do graph[i] = {} end
for _ = 1, m do local a, b = io.read("*n"), io.read("*n"); graph[a][#graph[a] + 1] = b; graph[b][#graph[b] + 1] = a end
for _ = 1, k do
    local start = io.read("*n")
    local dist, queue, head = { [start] = 0 }, { start }, 1
    local far, best = 0, 0
    while head <= #queue do
        local x = queue[head]; head = head + 1
        for _, y in ipairs(graph[x]) do
            if dist[y] == nil then
                dist[y] = dist[x] + 1; queue[#queue + 1] = y
                if dist[y] > far or (dist[y] == far and y < best) then far, best = dist[y], y end
            end
        end
    end
    print(best)
end
