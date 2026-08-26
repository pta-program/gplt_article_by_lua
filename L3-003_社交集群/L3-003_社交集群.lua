-- L3-003 社交集群
-- 实现原理：拥有同一兴趣的人属于同一连通集群，故将他们在并查集中合并。
-- 统计各根节点人数后按非增序输出，即得到所有集群规模。

local n = tonumber(io.read("*l"))
local parent, size, first = {}, {}, {}
for i = 1, n do parent[i], size[i] = i, 1 end
local function find(x) if parent[x] ~= x then parent[x] = find(parent[x]) end; return parent[x] end
local function union(a, b) a, b = find(a), find(b); if a ~= b then parent[a] = b; size[b] = size[b] + size[a] end end
for person = 1, n do
    local line = io.read("*l")
    local k = tonumber(line:match("^(%d+):"))
    local count = 0
    for h in line:gmatch("%d+") do
        if count > 0 then h = tonumber(h); if first[h] then union(person, first[h]) else first[h] = person end end
        count = count + 1
    end
end
local groups = {}
for i = 1, n do if find(i) == i then groups[#groups + 1] = size[i] end end
table.sort(groups, function(a, b) return a > b end)
print(#groups)
print(table.concat(groups, " "))
