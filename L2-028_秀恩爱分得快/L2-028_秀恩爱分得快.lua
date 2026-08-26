-- L2-028 秀恩爱分得快
-- 实现原理：一张含 K 人的照片，对其中每对异性累计 1/K 的亲密度。
-- 分别找出 A、B 的最大异性亲密度对象；若两人互为最大对象则只输出这一对。

local n, m = io.read("*n"), io.read("*n")
local intimacy = {}
local function add(a, b, value)
    intimacy[a] = intimacy[a] or {}
    intimacy[a][b] = (intimacy[a][b] or 0) + value
end
for _ = 1, m do
    local k, people = io.read("*n"), {}
    for i = 1, k do people[i] = io.read("*n") end
    for i = 1, k do
        for j = i + 1, k do
            if (people[i] < 0) ~= (people[j] < 0) then
                add(people[i], people[j], 1 / k)
                add(people[j], people[i], 1 / k)
            end
        end
    end
end
local a, b = io.read("*n"), io.read("*n")
local function best(x)
    local maxValue, result = -1, {}
    for y, value in pairs(intimacy[x] or {}) do
        if value > maxValue + 1e-10 then maxValue, result = value, { y }
        elseif math.abs(value - maxValue) < 1e-10 then result[#result + 1] = y end
    end
    table.sort(result, function(u, v) return math.abs(u) < math.abs(v) end)
    return result
end
local pa, pb = best(a), best(b)
local aLikesB, bLikesA = false, false
for _, x in ipairs(pa) do if x == b then aLikesB = true end end
for _, x in ipairs(pb) do if x == a then bLikesA = true end end
if aLikesB and bLikesA then
    print(a .. " " .. b)
else
    for _, x in ipairs(pa) do print(a .. " " .. x) end
    for _, x in ipairs(pb) do print(b .. " " .. x) end
end
