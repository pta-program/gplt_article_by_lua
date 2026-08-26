-- L2-034 口罩发放
-- 实现原理：每天先筛出合法身份证记录，按提交时间和原出现顺序排序后发放。
-- last[id] 保存上次成功日期以检查间隔；症状名单则在所有合法记录中首次出现时收集。

local raw = io.read("*a")
if not raw or raw:match("^%s*$") then return end
local toks = {}
for tok in raw:gmatch("%S+") do toks[#toks+1] = tok end
local p = 1
local function nt() p = p + 1; return toks[p-1] end
local function ni() local t = nt(); return t and tonumber(t) end
local days, gap = ni(), ni()
if not days then return end
local last, suspicious, seenSuspicious = {}, {}, {}
local function valid(id) return #id == 18 and id:match("^%d+$") end
for day = 1, days do
    local t, quota = ni(), ni()
    local candidates = {}
    for order = 1, t do
        local name, id, status, time = nt(), nt(), ni(), nt()
        if valid(id) then
            if status == 1 and not seenSuspicious[id] then
                seenSuspicious[id] = true
                suspicious[#suspicious + 1] = { name, id }
            end
            candidates[#candidates + 1] = { name = name, id = id, time = time, order = order }
        end
    end
    table.sort(candidates, function(a, b) if a.time ~= b.time then return a.time < b.time else return a.order < b.order end end)
    local sent = 0
    for _, person in ipairs(candidates) do
        if sent < quota and (not last[person.id] or day - last[person.id] > gap) then
            print(person.name .. " " .. person.id)
            last[person.id] = day
            sent = sent + 1
        end
    end
end
for _, person in ipairs(suspicious) do print(person[1] .. " " .. person[2]) end
