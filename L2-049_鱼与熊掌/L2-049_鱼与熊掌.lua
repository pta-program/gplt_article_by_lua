-- L2-049 鱼与熊掌
-- 实现原理：对每种物品建立按用户编号递增的倒排列表。一次查询只需对两条
-- 有序列表做双指针求交集，交集长度即同时拥有两种物品的人数。

local n, m = io.read("*n"), io.read("*n")
local owners = {}
for person = 1, n do
    local k = io.read("*n")
    for _ = 1, k do
        local item = io.read("*n")
        owners[item] = owners[item] or {}
        owners[item][#owners[item] + 1] = person
    end
end
local q = io.read("*n")
for _ = 1, q do
    local a, b = io.read("*n"), io.read("*n")
    local listA, listB = owners[a] or {}, owners[b] or {}
    local i, j, count = 1, 1, 0
    while i <= #listA and j <= #listB do
        if listA[i] == listB[j] then count = count + 1; i = i + 1; j = j + 1
        elseif listA[i] < listB[j] then i = i + 1 else j = j + 1 end
    end
    print(count)
end
