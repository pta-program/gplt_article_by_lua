-- L2-048 寻宝图
-- 实现原理：对每个尚未访问的非 0 格子进行四方向 BFS，它对应一座岛屿。
-- 搜索过程中若遇到字符 2..9，则该岛被标为藏宝岛。

local n, m = io.read("*n"), io.read("*n")
local grid = {}
for i = 1, n do grid[i] = io.read("*l") end
local seen, islands, treasure = {}, 0, 0
for i = 1, n do
    for j = 1, m do
        if grid[i]:sub(j, j) ~= "0" and not (seen[i] and seen[i][j]) then
            islands = islands + 1
            local queue, head, has = { { i, j } }, 1, false
            seen[i] = seen[i] or {}; seen[i][j] = true
            while head <= #queue do
                local x, y = queue[head][1], queue[head][2]; head = head + 1
                if grid[x]:sub(y, y) ~= "1" then has = true end
                for _, d in ipairs({ { 1, 0 }, { -1, 0 }, { 0, 1 }, { 0, -1 } }) do
                    local nx, ny = x + d[1], y + d[2]
                    if nx >= 1 and nx <= n and ny >= 1 and ny <= m and grid[nx]:sub(ny, ny) ~= "0"
                        and not (seen[nx] and seen[nx][ny]) then
                        seen[nx] = seen[nx] or {}; seen[nx][ny] = true
                        queue[#queue + 1] = { nx, ny }
                    end
                end
            end
            if has then treasure = treasure + 1 end
        end
    end
end
print(islands .. " " .. treasure)
