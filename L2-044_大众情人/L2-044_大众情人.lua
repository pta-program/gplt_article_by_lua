-- 实现原理：Floyd-Warshall全源最短路，按性别分组求异性缘=1/max异性距离，无穷则排除，取最小max者
local INF = 1e12
local line = io.read("*l")
if not line then return end
local N = tonumber(line:match("%d+"))
if not N then return end
local gender = {}
local dist = {}
for i = 1, N do
    dist[i] = {}
    for j = 1, N do
        dist[i][j] = (i == j) and 0 or INF
    end
end
for i = 1, N do
    local l = io.read("*l")
    while l ~= nil and l:match("^%s*$") do l = io.read("*l") end
    if not l then
        gender[i] = "M"
    else
        local g = l:match("^%s*([FM])")
        gender[i] = g or "M"
        for id, w in l:gmatch("(%d+):(%d+)") do
            id = tonumber(id); w = tonumber(w)
            if id >= 1 and id <= N and w < dist[i][id] then
                dist[i][id] = w
            end
        end
    end
end
-- Floyd-Warshall
for k = 1, N do
    for i = 1, N do
        local dik = dist[i][k]
        if dik < INF then
            for j = 1, N do
                local dkj = dist[k][j]
                if dkj < INF then
                    local nd = dik + dkj
                    if nd < dist[i][j] then dist[i][j] = nd end
                end
            end
        end
    end
end
-- 对每个人求到异性最远距离
local maxDist = {}
for i = 1, N do maxDist[i] = INF end
for i = 1, N do
    local md = -1
    local reachable = true
    local hasOpposite = false
    for j = 1, N do
        if gender[j] ~= gender[i] then
            hasOpposite = true
            local d = dist[j][i]
            if d >= INF/2 then reachable = false; break end
            if d > md then md = d end
        end
    end
    if not hasOpposite then maxDist[i] = INF
    elseif not reachable then maxDist[i] = INF
    else maxDist[i] = md end
end
local function collect(targetGender)
    local best = INF
    for i = 1, N do
        if gender[i] == targetGender and maxDist[i] < best then best = maxDist[i] end
    end
    local res = {}
    if best < INF then
        for i = 1, N do
            if gender[i] == targetGender and maxDist[i] == best then res[#res+1]=tostring(i) end
        end
    end
    return res
end
local femaleRes = collect("F")
local maleRes = collect("M")
if #femaleRes > 0 then print(table.concat(femaleRes, " ")) else print("") end
if #maleRes > 0 then print(table.concat(maleRes, " ")) else print("") end
