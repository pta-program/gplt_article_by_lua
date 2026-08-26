-- L2-015 互评成绩
-- 实现原理：每位选手的 K 个评分排序后去掉一个最高分和一个最低分，
-- 对中间 K-2 个分数求平均；将所有平均分排序后输出最高的 M 个。

local n, k, m = io.read("*n"), io.read("*n"), io.read("*n")
local scores = {}
for i = 1, n do
    local a, sum = {}, 0
    for j = 1, k do a[j] = io.read("*n") end
    table.sort(a)
    for j = 2, k - 1 do sum = sum + a[j] end
    scores[i] = sum / (k - 2)
end
table.sort(scores)
local out = {}
for i = n - m + 1, n do out[#out + 1] = string.format("%.3f", scores[i]) end
print(table.concat(out, " "))
