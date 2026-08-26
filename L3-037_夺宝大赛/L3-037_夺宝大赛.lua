-- L3-037 夺宝大赛
--
-- 实现原理：终点（大本营）固定，先从大本营做一次 BFS，即可得到每个可通行
-- 格子的最短路长度。每支队伍到达大本营的最早时间就是其初始格子的距离。
-- 最短时间唯一的队伍获胜；若最短时间有多支队伍，则它们同时相遇并全部淘汰。

local rows, cols = io.read("*n", "*n")
local map, dist = {}, {}
local qx, qy = {}, {}
local head, tail = 1, 0

for r = 1, rows do
    map[r], dist[r] = {}, {}
    for c = 1, cols do
        map[r][c] = io.read("*n")
        if map[r][c] == 2 then
            tail = tail + 1
            qx[tail], qy[tail] = c, r
            dist[r][c] = 0
        end
    end
end

local dx = { 1, -1, 0, 0 }
local dy = { 0, 0, 1, -1 }
while head <= tail do
    local x, y = qx[head], qy[head]
    head = head + 1
    for d = 1, 4 do
        local nx, ny = x + dx[d], y + dy[d]
        if nx >= 1 and nx <= cols and ny >= 1 and ny <= rows
            and map[ny][nx] ~= 0 and dist[ny][nx] == nil then
            dist[ny][nx] = dist[y][x] + 1
            tail = tail + 1
            qx[tail], qy[tail] = nx, ny
        end
    end
end

local team_count = io.read("*n")
local best_distance, winner, same_time_count = math.huge, nil, 0
for id = 1, team_count do
    local x, y = io.read("*n", "*n")
    local d = dist[y] and dist[y][x]
    if d ~= nil then
        if d < best_distance then
            best_distance, winner, same_time_count = d, id, 1
        elseif d == best_distance then
            same_time_count = same_time_count + 1
        end
    end
end

if same_time_count == 1 then
    print(winner .. " " .. best_distance)
else
    print("No winner.")
end
