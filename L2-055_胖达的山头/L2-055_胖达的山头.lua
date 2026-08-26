-- L2-055 胖达的山头
-- 实现原理：将每段时间看作一个起止事件，扫描时间轴维护同时覆盖的区间数。
-- 该最大覆盖数就是样例所求的最高“山头”数量；相同时间先处理开始事件。

local raw = io.read("*a")
local toks = {}
for tok in raw:gmatch("%S+") do toks[#toks+1] = tok end
local p = 1
local function nt() p = p + 1; return toks[p-1] end
local n = tonumber(nt())
if not n then return end
local events = {}
local function toSecond(s)
    local h, m, sec = s:match("(%d%d):(%d%d):(%d%d)")
    return tonumber(h) * 3600 + tonumber(m) * 60 + tonumber(sec)
end
for _ = 1, n do
    local a, b = nt(), nt()
    events[#events + 1] = { toSecond(a), 1 }
    events[#events + 1] = { toSecond(b), -1 }
end
table.sort(events, function(a, b) if a[1] ~= b[1] then return a[1] < b[1] else return a[2] > b[2] end end)
local now, answer = 0, 0
for _, event in ipairs(events) do now = now + event[2]; answer = math.max(answer, now) end
print(answer)
