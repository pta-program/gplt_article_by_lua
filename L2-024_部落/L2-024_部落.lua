-- L2-024 部落
-- 实现原理：同一朋友圈的所有人并入同一并查集。出现过的人数为社区人数，
-- 这些人的不同根节点数为部落数；查询时比较两个根节点即可。

local parent, present = {}, {}
local function find(x)
    if parent[x] ~= x then parent[x] = find(parent[x]) end
    return parent[x]
end
local function add(x)
    if not parent[x] then parent[x] = x end
    present[x] = true
end
local function union(a, b)
    a, b = find(a), find(b)
    if a ~= b then parent[a] = b end
end

local n = io.read("*n")
for _ = 1, n do
    local k = io.read("*n")
    local first = io.read("*n")
    add(first)
    for _ = 2, k do
        local x = io.read("*n")
        add(x)
        union(first, x)
    end
end
local people, roots = 0, {}
for x in pairs(present) do people = people + 1; roots[find(x)] = true end
local tribes = 0
for _ in pairs(roots) do tribes = tribes + 1 end
print(people .. " " .. tribes)
local q = io.read("*n")
for _ = 1, q do
    local a, b = io.read("*n"), io.read("*n")
    print(find(a) == find(b) and "Y" or "N")
end
