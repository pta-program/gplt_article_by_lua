-- L2-027 名人堂与代金券
-- 实现原理：成绩排序时按分数降序、账号升序处理；排序后下标就是竞赛排名
-- （同分沿用前一名的排名）。代金券则按原始成绩区间直接累计。

local raw = io.read("*a")
local toks = {}
for tok in raw:gmatch("%S+") do toks[#toks+1] = tok end
local p = 1
local function nt() p = p + 1; return toks[p-1] end
local function ni() local t = nt(); return t and tonumber(t) end
local n, g, k = ni(), ni(), ni()
if not n then return end
local students, coupon = {}, 0
for i = 1, n do
    local id, score = nt(), ni()
    students[i] = { id = id, score = score }
    if score >= g then coupon = coupon + 50 elseif score >= 60 then coupon = coupon + 20 end
end
table.sort(students, function(a, b)
    if a.score ~= b.score then return a.score > b.score else return a.id < b.id end
end)
print(coupon)
local rank = 0
for i = 1, math.min(k, n) do
    if i == 1 or students[i].score ~= students[i - 1].score then rank = i end
    print(rank .. " " .. students[i].id .. " " .. students[i].score)
end
