-- L3-031 千手观音
-- 实现原理：相邻两个有序数的首个不同“位”决定一条符号大小关系边。
-- 收集所有符号后，以字典序最小的可选入度 0 节点进行拓扑排序，正好满足
-- 无法由数据确定相对顺序时按英文词典序排列的要求。

local n = tonumber(io.read("*l"))
local numbers, symbols = {}, {}
for i = 1, n do
    local line, a = io.read("*l"), {}
    for word in line:gmatch("[^%.]+") do a[#a + 1] = word; symbols[word] = true end
    numbers[i] = a
end
local graph, indegree = {}, {}
for s in pairs(symbols) do graph[s], indegree[s] = {}, 0 end
for i = 1, n - 1 do
    local a, b = numbers[i], numbers[i + 1]
    for j = 1, math.min(#a, #b) do
        if a[j] ~= b[j] then
            if not graph[a[j]][b[j]] then graph[a[j]][b[j]] = true; indegree[b[j]] = indegree[b[j]] + 1 end
            break
        end
    end
end
local available, answer = {}, {}
for s in pairs(symbols) do if indegree[s] == 0 then available[#available + 1] = s end end
while #available > 0 do
    table.sort(available)
    local x = table.remove(available, 1)
    answer[#answer + 1] = x
    for y in pairs(graph[x]) do
        indegree[y] = indegree[y] - 1
        if indegree[y] == 0 then available[#available + 1] = y end
    end
end
print(table.concat(answer, "."))
