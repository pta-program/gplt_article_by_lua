-- L2-046 天梯赛的赛场安排
-- 实现原理：反复选择尚未安排人数最多的学校；人数不少于 C 时单独开满场，
-- 否则填入编号最小且容量足够的已有场地。记录每校被安排的场次。

local raw = io.read("*a")
local toks = {}
for tok in raw:gmatch("%S+") do toks[#toks+1] = tok end
local p = 1
local function nt() p = p + 1; return toks[p-1] end
local function ni() local t = nt(); return t and tonumber(t) end
local n, c = ni(), ni()
if not n then return end
local schools = {}
for i = 1, n do
    local name, count = nt(), ni()
    schools[i] = { name = name, remain = count, rooms = 0, order = i }
end
local rooms = {}
while true do
    local chosen = nil
    for _, school in ipairs(schools) do
        if school.remain > 0 and (not chosen or school.remain > chosen.remain
            or (school.remain == chosen.remain and school.order < chosen.order)) then chosen = school end
    end
    if not chosen then break end
    local room = nil
    if chosen.remain < c then
        for i, empty in ipairs(rooms) do if empty >= chosen.remain then room = i; break end end
    end
    if room then
        rooms[room] = rooms[room] - chosen.remain
        chosen.remain = 0
    else
        local take = math.min(c, chosen.remain)
        rooms[#rooms + 1] = c - take
        chosen.remain = chosen.remain - take
    end
    chosen.rooms = chosen.rooms + 1
end
for _, school in ipairs(schools) do print(school.name .. " " .. school.rooms) end
print(#rooms)
