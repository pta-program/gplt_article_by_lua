-- L3-006 迎风一刀斩
-- 实现原理：若两块残片来自矩形的一刀切，则存在一对等长边可作为公共切边。
-- 枚举边对并将其反向对齐；此时所有顶点的凸包必须恰为矩形，且凸包面积等于
-- 两片面积之和（无重叠、无空洞）。满足任一边对即可判定 YES。

local cases = io.read("*n")
local eps = 1e-7
local function area(p)
    local s = 0
    for i = 1, #p do local q = p[i % #p + 1]; s = s + p[i][1] * q[2] - p[i][2] * q[1] end
    return math.abs(s) / 2
end
local function cross(a, b, c) return (b[1] - a[1]) * (c[2] - a[2]) - (b[2] - a[2]) * (c[1] - a[1]) end
local function hull(points)
    table.sort(points, function(a, b) return a[1] ~= b[1] and a[1] < b[1] or a[2] < b[2] end)
    local h = {}
    for _, p in ipairs(points) do
        while #h >= 2 and cross(h[#h - 1], h[#h], p) <= eps do h[#h] = nil end
        h[#h + 1] = p
    end
    local lower = #h
    for i = #points - 1, 1, -1 do
        local p = points[i]
        while #h > lower and cross(h[#h - 1], h[#h], p) <= eps do h[#h] = nil end
        h[#h + 1] = p
    end
    h[#h] = nil
    return h
end
local function isRectangle(h)
    if #h ~= 4 then return false end
    for i = 1, 4 do
        local a, b, c = h[(i - 2) % 4 + 1], h[i], h[i % 4 + 1]
        local ux, uy, vx, vy = a[1] - b[1], a[2] - b[2], c[1] - b[1], c[2] - b[2]
        if math.abs(ux * vx + uy * vy) > eps then return false end
    end
    return true
end
for _ = 1, cases do
    local function readPoly()
        local k, p = io.read("*n"), {}
        for i = 1, k do p[i] = { io.read("*n"), io.read("*n") } end
        return p
    end
    local a, b = readPoly(), readPoly()
    local possible, total = false, area(a) + area(b)
    for i = 1, #a do for j = 1, #b do
        local a1, a2, b1, b2 = a[i], a[i % #a + 1], b[j], b[j % #b + 1]
        local ax, ay, bx, by = a2[1] - a1[1], a2[2] - a1[2], b1[1] - b2[1], b1[2] - b2[2]
        local la, lb = ax * ax + ay * ay, bx * bx + by * by
        if math.abs(la - lb) < eps and la > eps then
            local pts = {}
            local function transform(p)
                local x, y = p[1] - b2[1], p[2] - b2[2]
                return { a1[1] + (x * ax + y * ay) / la, a1[2] + (x * ay - y * ax) / la }
            end
            for _, p in ipairs(a) do pts[#pts + 1] = { p[1], p[2] } end
            for _, p in ipairs(b) do pts[#pts + 1] = transform(p) end
            local h = hull(pts)
            if isRectangle(h) and math.abs(area(h) - total) < eps then possible = true; break end
        end
    end if possible then break end end
    print(possible and "YES" or "NO")
end
