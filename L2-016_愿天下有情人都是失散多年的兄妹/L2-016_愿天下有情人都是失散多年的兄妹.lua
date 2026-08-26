-- L2-016 愿天下有情人都是失散多年的兄妹
-- 实现原理：记录每人的父母关系。对两人分别向上追溯至高祖父母（深度 4），
-- 若祖先集合有交集则为五服以内；同性则无需追溯，直接输出 Never Mind。

local __data = io.read("*a") or ""
local __toks = {}
for tok in __data:gmatch("%S+") do __toks[#__toks + 1] = tok end
local __idx = 1
local function __next_tok() local t = __toks[__idx]; __idx = __idx + 1; return t end
local function __next_num() local t = __next_tok(); return t and tonumber(t) end
local n = __next_num()
local sex, father, mother = {}, {}, {}
for _ = 1, n do
    local id = __next_num()
    local s = __next_tok()
    local f = __next_num()
    local m = __next_num()
    sex[id], father[id], mother[id] = s, f, m
end

local function ancestors(id)
    local result = {}
    local function visit(x, depth)
        if x == -1 or depth > 4 or result[x] then return end
        result[x] = true
        visit(father[x] or -1, depth + 1)
        visit(mother[x] or -1, depth + 1)
    end
    visit(id, 0)
    return result
end

local q = __next_num()
for _ = 1, q do
    local a, b = __next_num(), __next_num()
    if sex[a] == sex[b] then
        print("Never Mind")
    else
        local aa, bb = ancestors(a), ancestors(b)
        local related = false
        for x in pairs(aa) do
            if bb[x] then related = true; break end
        end
        print(related and "No" or "Yes")
    end
end
