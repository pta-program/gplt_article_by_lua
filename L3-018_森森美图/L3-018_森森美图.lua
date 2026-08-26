-- L3-018 森森美图
--
-- 实现原理：由 A、B 所在直线把像素分成两个互不相交的区域。对每个区域
-- 分别在八连通网格上求 A 到 B 的最短路，边权为走入新像素的分数；斜走时
-- 再增加两端分数之和乘 (sqrt(2)-1)。两条路径均含 A、B，合并时减去它们。

local n, m = io.read("*n", "*n")
local score = {}
for y = 1, n do
    score[y] = {}
    for x = 1, m do score[y][x] = io.read("*n") end
end
local ax, ay, bx, by = io.read("*n", "*n", "*n", "*n")
ax, ay, bx, by = ax + 1, ay + 1, bx + 1, by + 1

local dx = { -1,-1,-1,0,0,1,1,1 }
local dy = { -1,0,1,-1,1,-1,0,1 }
local diagonal_extra = math.sqrt(2) - 1

local function side(x, y)
    return (bx - ax) * (y - ay) - (by - ay) * (x - ax)
end

local function shortest(wanted_side)
    local dist, hx, hy, hd, size = {}, {}, {}, {}, 0
    for y = 1, n do dist[y] = {} end
    local function push(x, y, d)
        size = size + 1
        local i = size
        while i > 1 do
            local p = math.floor(i / 2)
            if hd[p] <= d then break end
            hx[i], hy[i], hd[i] = hx[p], hy[p], hd[p]
            i = p
        end
        hx[i], hy[i], hd[i] = x, y, d
    end
    local function pop()
        local x, y, d = hx[1], hy[1], hd[1]
        local lx, ly, ld = hx[size], hy[size], hd[size]
        size = size - 1
        local i = 1
        while i * 2 <= size do
            local c = i * 2
            if c + 1 <= size and hd[c + 1] < hd[c] then c = c + 1 end
            if hd[c] >= ld then break end
            hx[i], hy[i], hd[i] = hx[c], hy[c], hd[c]
            i = c
        end
        if size >= 1 then hx[i], hy[i], hd[i] = lx, ly, ld end
        return x, y, d
    end

    dist[ay][ax] = score[ay][ax]
    push(ax, ay, score[ay][ax])
    while size > 0 do
        local x, y, d = pop()
        if d == dist[y][x] then
            if x == bx and y == by then return d end
            for k = 1, 8 do
                local nx, ny = x + dx[k], y + dy[k]
                if nx >= 1 and nx <= m and ny >= 1 and ny <= n then
                    local s = side(nx, ny)
                    if (nx == bx and ny == by) or s * wanted_side > 0 then
                        local nd = d + score[ny][nx]
                        if dx[k] ~= 0 and dy[k] ~= 0 then
                            nd = nd + (score[y][x] + score[ny][nx]) * diagonal_extra
                        end
                        if dist[ny][nx] == nil or nd < dist[ny][nx] then
                            dist[ny][nx] = nd
                            push(nx, ny, nd)
                        end
                    end
                end
            end
        end
    end
end

local answer = shortest(1) + shortest(-1) - score[ay][ax] - score[by][bx]
print(string.format("%.2f", answer))
