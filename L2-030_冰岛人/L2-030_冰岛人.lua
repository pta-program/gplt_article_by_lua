-- L2-030 冰岛人
-- 实现原理：从带性别后缀的姓中提取性别和父亲名字，建立父系家谱。
-- 查询时分别向上收集四代祖先；异性双方祖先集合无交集则可以交往。

local raw = io.read("*a")
local toks = {}
for tok in raw:gmatch("%S+") do toks[#toks+1] = tok end
local idx = 1
local function nt() idx = idx + 1; return toks[idx-1] end
local function ni() local t = nt(); return t and tonumber(t) end
local n = tonumber(toks[idx]); idx = idx + 1
if not n then return end
local people, byKey, byFirst = {}, {}, {}
for i = 1, n do
    local first, surname = nt(), nt()
    local sex, base, fatherName
    if surname:sub(-4) == "sson" then
        sex, base, fatherName = "M", surname:sub(1, -5), surname:sub(1, -5)
    elseif surname:sub(-7) == "sdottir" then
        sex, base, fatherName = "F", surname:sub(1, -7), surname:sub(1, -7)
    else
        sex, base = surname:sub(-1) == "m" and "M" or "F", surname:sub(1, -2)
    end
    people[i] = { first = first, base = base, sex = sex, fatherName = fatherName }
    byKey[first .. " " .. base], byFirst[first] = i, i
end
for _, person in ipairs(people) do person.father = person.fatherName and byFirst[person.fatherName] or nil end

local function ancestorSet(id)
    local set, depth = {}, 0
    while id and depth < 4 do
        id = people[id].father
        depth = depth + 1
        if id then set[id] = true end
    end
    return set
end

local q = ni()
if not q then return end
for _ = 1, q do
    local f1, s1, f2, s2 = nt(), nt(), nt(), nt()
    local x, y = byKey[f1 .. " " .. s1], byKey[f2 .. " " .. s2]
    if not x or not y then
        print("NA")
    elseif people[x].sex == people[y].sex then
        print("Whatever")
    else
        local ax, ay, related = ancestorSet(x), ancestorSet(y), false
        for id in pairs(ax) do if ay[id] then related = true; break end end
        print(related and "No" or "Yes")
    end
end
