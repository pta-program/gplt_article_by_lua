-- L2-021 点赞狂魔
-- 实现原理：对每位用户用集合去重以得到不同标签数，同时记录标签总次数。
-- 排名关键字依次为不同标签数降序、平均出现次数升序，取前三名即可。

local raw = io.read("*a")
local toks = {}
for tok in raw:gmatch("%S+") do toks[#toks+1] = tok end
local p = 1
local function nt() p = p + 1; return toks[p-1] end
local function ni() local t = nt(); return t and tonumber(t) end
local n = ni()
if not n then return end
local users = {}
for i = 1, n do
    local name, k = nt(), ni()
    local distinct = {}
    for _ = 1, k do distinct[ni()] = true end
    local kinds = 0
    for _ in pairs(distinct) do kinds = kinds + 1 end
    users[i] = { name = name, kinds = kinds, average = k / kinds }
end
table.sort(users, function(a, b)
    if a.kinds ~= b.kinds then return a.kinds > b.kinds end
    return a.average < b.average
end)
local out = {}
for i = 1, 3 do out[i] = users[i] and users[i].name or "-" end
print(table.concat(out, " "))
