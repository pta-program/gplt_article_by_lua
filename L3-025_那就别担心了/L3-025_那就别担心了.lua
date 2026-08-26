-- L3-025 那就别担心了
-- 实现原理：图为 DAG。记忆化 DFS 统计 A 到 B 的路径数；同时遍历 A 可达子图，
-- 若存在一个终止命题不是 B，则并非所有推理路径都导向 B，输出 No。

local n, m = io.read("*n"), io.read("*n")
local graph = {}; for i = 1, n do graph[i] = {} end
for _ = 1, m do local a, b = io.read("*n"), io.read("*n"); graph[a][#graph[a] + 1] = b end
local a, b = io.read("*n"), io.read("*n")
local memo = {}
local function paths(x)
    if x == b then return 1 end
    if memo[x] then return memo[x] end
    local total = 0
    for _, y in ipairs(graph[x]) do total = total + paths(y) end
    memo[x] = total
    return total
end
local seen, stack, allEndAtB = { [a] = true }, { a }, true
while #stack > 0 do
    local x = stack[#stack]; stack[#stack] = nil
    if #graph[x] == 0 and x ~= b then allEndAtB = false end
    for _, y in ipairs(graph[x]) do if not seen[y] then seen[y] = true; stack[#stack + 1] = y end end
end
print(paths(a) .. " " .. (allEndAtB and "Yes" or "No"))
