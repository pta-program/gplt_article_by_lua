-- L2-042 老板的作息表
-- 实现原理：将时刻转为当天秒数并按起始时刻排序，相邻已知区间端点之间
-- 存在空档便输出。题目将端点视为区间边界，因此无需额外加减一秒。

local function parse(s)
    local h, m, sec = s:match("(%d%d):(%d%d):(%d%d)")
    return tonumber(h) * 3600 + tonumber(m) * 60 + tonumber(sec)
end
local function format(x)
    return string.format("%02d:%02d:%02d", math.floor(x / 3600), math.floor(x / 60) % 60, x % 60)
end
local n = io.read("*n")
io.read("*l")
local periods = {}
for i = 1, n do
    local line = io.read("*l")
    local a, b = line:match("(%d%d:%d%d:%d%d)%s+%-%s+(%d%d:%d%d:%d%d)")
    periods[i] = { parse(a), parse(b) }
end
table.sort(periods, function(a, b) return a[1] < b[1] end)
local current = 0
for _, period in ipairs(periods) do
    if current < period[1] then print(format(current) .. " - " .. format(period[1])) end
    if period[2] > current then current = period[2] end
end
if current < 86399 then print(format(current) .. " - " .. format(86399)) end
