-- L2-013 红色警报
-- 实现原理：每次城市失守后，用 DFS 统计尚存城市构成的连通块数量。
-- 若连通块数增加，说明这座城市是当前图的割点，需要发出红色警报。

local n, m = io.read("*n"), io.read("*n")
local graph = {}
for i = 0, n - 1 do graph[i] = {} end
for _ = 1, m do
    local a, b = io.read("*n"), io.read("*n")
    graph[a][#graph[a] + 1] = b
    graph[b][#graph[b] + 1] = a
end
local k = io.read("*n")
local attacks = {}
for i = 1, k do attacks[i] = io.read("*n") end

local alive = {}
for i = 0, n - 1 do alive[i] = true end

local function components()
    local seen, count = {}, 0
    for start = 0, n - 1 do
        if alive[start] and not seen[start] then
            count = count + 1
            local stack = { start }
            seen[start] = true
            while #stack > 0 do
                local u = table.remove(stack)
                for _, v in ipairs(graph[u]) do
                    if alive[v] and not seen[v] then
                        seen[v] = true
                        stack[#stack + 1] = v
                    end
                end
            end
        end
    end
    return count
end

local remain = n
for _, city in ipairs(attacks) do
    local before = components()
    alive[city] = false
    remain = remain - 1
    local after = components()
    if after > before then
        print("Red Alert: City " .. city .. " is lost!")
    else
        print("City " .. city .. " is lost.")
    end
    if remain == 0 then print("Game Over.") end
end
